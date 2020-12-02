require 'rails_helper'
RSpec.describe Api::V1::ZipController, :type => :request do
  describe '#zip_images' do
    let!(:submission) { create(:submission, type_name: "EMAIL") }
    let(:email) { 'foo@example.com' }
    let(:site_name) { submission.site_names.first }

    context "email params not present" do
      let(:params) {{ site_name: site_name }}
      before { get '/api/v1/zip_images', params: params }
      
      it "returns message" do
        expect(response.body).to include ("Ensure you are logged in, and have selected a site")
      end
    end

    context "site params not present" do
      let(:params) {{ email: email }}
      before { get '/api/v1/zip_images', params: params }
      
      it "returns message" do
        expect(response.body).to include ("Ensure you are logged in, and have selected a site")
      end
    end


    context "correct params are present" do
      let(:params) {{ email: email, site_name: site_name }}
      subject {  get '/api/v1/zip_images', params: params }

      it "returns message" do
        subject
        expect(response.body).to include "Zip job has been stated, you will be emailed the images soon"
      end

      Sidekiq::Testing.inline! do
        it "calls submission zip worker" do
          expect{ subject }.to change(SubmissionZipWorker.jobs, :size).by(1) 
        end

        it "uses supplied email address" do
          site_id = submission.sites.first.id
          expect(SubmissionZipWorker).to receive(:perform_async).with("#{site_id}", site_id, email, nil, nil)
          subject
        end
      end
    end
  end
end