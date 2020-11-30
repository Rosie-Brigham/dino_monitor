require "rails_helper"
RSpec.describe CSVCreateService do
  let(:submission) { create(:submission) }
  let(:params) {{ site_id: submission.site_id }}
  let(:expected_csv) { "site_name,type_name,reliable,record_taken\nSome Stones,EMAIL,false,2019-04-26 00:00:00 UTC\n" }
  
  subject { described_class.new(params) }

  xdescribe "#create" do
    subject { described_class.new(params).create }
    
    it "creates a csv" do
      expect(subject).to be_a(String)
    end

    it "includes submission details" do
      expect(subject).to include(submission.site.name)
      expect(subject).to include(submission.type_name)
      expect(subject).to include(submission.reliable.to_s)
      expect(subject).to include(submission.record_taken.to_s)
    end

    it "only includes headers and submission details" do
      expect(subject.split("\n").size).to eq(2)
    end
  end

  # TODO: Bad case
end