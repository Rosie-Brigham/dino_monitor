FactoryBot.define do
  factory :submission do
    site_ids { [create(:site).id] }
    participant_id { create(:participant).id }
    record_taken { Date.today }
    ai_tags  { {} }
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'assets', 'test-image.jpg'), 'image/jpg') }
    type_name { "EMAIL" }

    factory :submission_with_insta_type do
      type_name { "INSTAGRAM" }
    end
  end
end