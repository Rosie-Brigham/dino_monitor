require 'rails_helper'
RSpec.describe Submission, type: :model do
  
  context 'associations' do
    it { should have_many(:sites) }
    it { should have_one(:type) }
  end 
  
  context 'validations' do
    subject { described_class.new(params) }
    let(:params) { { site_id: 123, record_taken: Date.today }}
    
    context 'when site ids are invalid' do
      it 'throws error' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages[:site_ids].to_sentence).to eq "site ids are missing or invalid"
      end
    end
    
    context 'when participant id invalid' do
      let(:site)    { create(:site) }
      let(:params) { { site_id: site.id, record_taken: Date.today }}
      
      it 'throws error' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages[:participant_id].to_sentence).to eq "participant is invalid or missing"
      end
    end

    context 'when site id and participant id valid' do
      let(:site)   { create(:site) }
      let(:participant) { create(:participant) }
      let(:params) { { site_ids: [site.id], participant_id: participant.id, record_taken: Date.today }}

      it 'creates submission' do
        expect(subject.valid?).to be true
      end
    end
  end

  context "set file name" do
    let(:submission) { create(:submission) }

    before { submission.set_filename}
    it "corrects the file name" do
      type = submission.type_name
      expected_filename = "#{Date.today.strftime("%d-%m-%Y")}_#{type.first.downcase}.jpg"

      expect(submission.image.attachment.filename.to_s).to eq expected_filename
    end
  end


  context "scope" do
    let!(:submission_one) { create(:submission, reliable: true) }
    let!(:submission_two) { create(:submission) }
   
    it "should scope on reliable" do
      expect(Submission.all.reliable.count).to eq 1
      expect(Submission.all.reliable).to include submission_one
    end
    
    context "#tags" do
    before do 
      tag_list = ['tag one', 'tag two']
      submission_one.tag_list = tag_list
      submission_one.save
    end

      it "filters on multiple tags" do
        expect(Submission.all.with_tags("tag one, tag two")).to eq [submission_one]
      end
    end
  end

  context "instance methods" do
    subject { create(:submission) }
    describe "#site_name" do
      it "returns site name" do
        expect(subject.site_names).to eq subject.sites.map(&:name)
      end 
    end
  end
end
