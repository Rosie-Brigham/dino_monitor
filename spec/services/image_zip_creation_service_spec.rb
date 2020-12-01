require "rails_helper"
RSpec.describe ImageZipCreationService do
  
  describe "#create" do
    let(:site) { create(:site) }
    !let(:submission) { create(:submission, site_ids: [site.id]) }  
    tmp_user_folder = "tmp/archive_submissions"
    subject { described_class.new(tmp_user_folder, site.id, "", "") }

    after(:all) do
      FileUtils.rm_rf(Dir["#{tmp_user_folder}/*"]) 
      FileUtils.rm_rf(Dir["#{tmp_user_folder}"]) 
    end

    # NOTE! This is probably not the best way to do this.... but I can't think of another one right now
    it "creates a tmp file full of submissions" do
      subject.create

      expect(Dir["#{tmp_user_folder}/*"].length).to eq(Submission.all.count)
    end
  end
end