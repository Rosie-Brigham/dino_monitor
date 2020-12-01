require 'rails_helper'
RSpec.describe Admin::BulkUploadController, type: :request do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess
  include Devise::Test::IntegrationHelpers

  describe "bulk uploading submissions" do
    before do
      user = User.create!(email: "thing@thing.com", password: "supersecure", admin: true)
      sign_in user
    end
    
    let(:site) { create(:site) }
    let(:second_site) { create(:site, name: 'More Stones') }

    let(:headers)  { {"CONTENT_TYPE" => "application/json" }}
    let(:test_image_path) { 'spec/fixtures/assets/test-image.jpg' }
    let(:params) {{  
                  "site_ids": "#{site.id}",
                  "reliable": "false", 
                  "record_taken": "1111-11-11",
                  "type_name": "INSTAGRAM", 
                  "participant_id": "example@email.com", 
                  "file": { "0": Rack::Test::UploadedFile.new(test_image_path, 'image/jpg', true) } 
                }}
                
    context "with correct params" do
      it "create new submissions" do
        expect {
          post "/admin/bulk_upload", params, headers: headers
        }.to change(Submission, :count)

      end
    end

    context "with multiple sites" do
      let(:params) {{  
        "site_ids": "#{site.id}, #{second_site.id}",
        "reliable": "false", 
        "record_taken": "1111-11-11",
        "type_name": "INSTAGRAM", 
        "participant_id": "example@email.com", 
        "file": { "0": Rack::Test::UploadedFile.new(test_image_path, 'image/jpg', true) } 
      }} 

      it "create new submissions" do
        expect {
          post "/admin/bulk_upload", params, headers: headers
        }.to change(Submission, :count)
        expect(Submission.last.sites.count).to eq 2
      end
    end

    context "when participant exists" do
      let(:email) { 'example@email.com' }
      let!(:participant) { Participant.create(participant_id: 'example@email.com') }
      
      before do
        params["participant_id"] = email
      end

      it "adds to participants submissions" do
        expect {
          post "/admin/bulk_upload", params, headers: headers
        }.to change(participant.submissions, :count)
      end
    end
      
    context "when participant does not exist" do
      it "creates a new participant" do
        expect {
          post "/admin/bulk_upload", params, headers: headers
        }.to change(Participant, :count)
      end
    end

    context "with image but incorrect params" do
      # login_user
      it "does not create submissions" do
        headers = { "CONTENT_TYPE" => "application/json" }
        test_image_path = 'spec/fixtures/assets/test-image.jpg'
        params = { "file": { "0": Rack::Test::UploadedFile.new(test_image_path, 'image/jpg', true) } }
        
        expect {
          post "/admin/bulk_upload", params, headers: headers
        }.to_not change(Submission, :count)
      end
    end

    context "without uploading image" do
      it "does not create submissions" do
        params = {}
        headers = { "CONTENT_TYPE" => "application/json" }

        expect {
          post "/admin/bulk_upload", params: params, headers: headers
        }.to_not change(Submission, :count)
        
        # TODO - why does this not work?
        # follow_redirect!
        # expect(response.body).to include("include some pictures!")
      end
    end 
  end
end