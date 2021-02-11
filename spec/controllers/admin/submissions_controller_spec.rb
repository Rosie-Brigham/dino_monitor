require 'rails_helper'
RSpec.describe Admin::SubmissionsController, type: :controller do
  context "#update" do
    let(:site_one) { create(:site, name: "stones") }
    let(:site_two) { create(:site, name: "more stones") }
    let(:site_three) { create(:site, name: "all the stones stones") }
    
    let(:submission) { create(:submission, sites: [site_one]) }
    let(:params) {{
      "submission"=> { 
        "site_names"=> "[{\"value\":\"#{site_one.name}\"},{\"value\":\"#{site_two.name}\"}]", # stupid fucking tags thing.
        "record_taken"=>"01/01/2021", 
        "tag_list"=>""
      },
      "id" => submission.id
    }}

    

    login_user
    before do 
      post :update, params: params, format: :js
    end

    context "when adding a new site" do
      it "adds new site to submission" do
        expect(response.content_type).to eq("text/javascript")
        expect(response.status).to eq(200)
        expect(submission.reload.sites.count).to eq(2)
      end
    end

    context "when removing a site" do
      let(:submission) { create(:submission, sites: [site_one, site_two, site_three]) } 
      it "removes site from submission" do
        expect(response.content_type).to eq("text/javascript")
        expect(response.status).to eq(200)
        expect(submission.reload.sites.count).to eq(2)
      end
    end
  end
end
