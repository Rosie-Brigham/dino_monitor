require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SubmissionZipWorker, type: :worker do
  let(:site) { create(:site) }
  let(:zip_path) { "tmp/achive_submission_#{site.id}"}
  let(:public_url) { "www.image.zip" }

  describe "#perform" do
    before do
      obj = double("S3 object", public_url: public_url, upload_file: true)
      aws = double("AWS", object: obj)
      
      allow_any_instance_of(Aws::S3::Resource)
        .to receive(:bucket)
        .and_return(aws)
    end

    context "when called" do
      it "creates an async job" do
        expect {
          described_class.perform_async(site.id)
        }.to change(SubmissionZipWorker.jobs, :size).by(1)
      end

      # Sidekiq::Testing.inline! do
      it "calls image zip creation service" do
        service = double("service double")
        allow(ImageZipCreationService).to receive(:new).and_return(service)
        allow(service).to receive(:create)
        
        expect(service).to receive(:create)#.with(site.id)
        described_class.perform_async(zip_path, site.id)
        Sidekiq::Worker.drain_all
      end

      context "uploading to s3" do
        subject { described_class.new.send(:upload_to_s3,zip_path, site.id)  }
            
        it "calls s3" do
          expect(subject).to eq public_url
        end
      end

      context "email" do
        it "send an email" do

        end

      end
    end
  end
end
