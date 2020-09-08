require 'rails_helper'
Sidekiq::Testing.fake!

RSpec.describe ImageZipController, :type => :request do
  let(:site) { create(:site) }
  let(:params) { {site_id: site.id} }
  tmp_user_folder = "tmp/archive_submissions"

  describe "GET #get_images" do
    after(:all) do
      FileUtils.rm_rf(Dir["#{tmp_user_folder}/*"]) 
      FileUtils.rm_rf(Dir["#{tmp_user_folder}"]) 
    end
    context "without authentication" do
      before {get '/admin/zip_images'}
      it "returns http success" do
        # expect(response).to have_http_status(401)
        # expect(response.body).to include("Bad Credentials")
      end
    end

    context "with authentication" do
      headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }
      subject { get '/admin/zip_images', params: params, headers: headers, as: :json }
       
      it "returns http success" do
        subject
        expect(response).to have_http_status(:redirect)
      end

      Sidekiq::Testing.inline! do
        it "calls submission zip worker" do
          expect{ subject }.to change(SubmissionZipWorker.jobs, :size).by(1) 
        end
      end

      context "if folder already present" do
        # it deletes it
      end
    end
  end
  


  xdescribe "GET #download_zip" do

    context "without authentication" do
      before { get '/admin/download_zip' }
      xit "returns http success" do
        # expect(response).to have_http_status(401)
        # expect(response.body).to include("Bad Credentials")
      end
    end

    context "with authentication" do
      headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }

      # before do
      #   get '/admin/download_zip', headers: headers, as: :json
      # end

      context "if zip file present" do
        before(:all) do
          # Create the tmp archive folder if it exists
          FileUtils.mkdir_p(tmp_user_folder) unless Dir.exists?(tmp_user_folder)
          # Copy test zip from support folder
          FileUtils.cp 'spec/support/assets/archive_submissions.zip', 'tmp/'
        end
        
        before { allow(Rails.logger).to receive(:info) }
        
        it "downloads file" do
          get '/admin/download_zip', headers: headers, as: :json
          expect(response).to have_http_status(:success)
          expect(response.content_type).to eq "application/zip"
        end
        
        it "logs message" do
          expect(Rails.logger).to receive(:info).with("Zip file downloading")
          get '/admin/download_zip', headers: headers, as: :json
        end
      end

      context "if zip file not present" do
        before do
          # Delete existing folders if they exist
          if Dir.exists?(tmp_user_folder)
            FileUtils.rm_rf(Dir["#{tmp_user_folder}/*"]) 
            FileUtils.rm_rf(Dir["#{tmp_user_folder}"]) 
          end
          allow(Rails.logger).to receive(:info)
        end

        it "returns error message" do
          expect(Rails.logger).to receive(:info).with("Zip folder not present, try again later")
          get '/admin/download_zip', headers: headers, as: :json
        end
      end
    end
  end
end