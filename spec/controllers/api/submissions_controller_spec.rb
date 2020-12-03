require 'rails_helper'
RSpec.describe Api::V1::SubmissionsController, :type => :request do
  context 'GET types' do
    let!(:email_submission) { create(:submission, type_name: "EMAIL") }
    let!(:insta_submission) { create(:submission_with_insta_type) }
    let(:params) { {} }
    headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }

    describe "GET #index" do

      context "without authentication" do
        before {get '/api/v1/submissions'}
        xit "returns http success" do
          expect(response).to have_http_status(401)
          expect(response.body).to include("Bad Credentials")
        end
      end

      context "with authentication" do
        before {get '/api/v1/submissions', params: params, headers: headers, as: :json}

        it "returns http success" do
          expect(response).to have_http_status(:success)
          
          results = JSON.parse(response.body)
          expect(results['data'].count).to eq 2
        end

        context "params" do
          let(:params) { {type_filter: "instagram"} }
          it "returns filtered sites" do
            results = JSON.parse(response.body)
            expect(results['data'].count).to eq 1
          end
        end

        context "with site group filter" do
          it "filters on site groups" do
          # TODO - when I am less tired
          end
        end
      end
    end  
  
  end
end
