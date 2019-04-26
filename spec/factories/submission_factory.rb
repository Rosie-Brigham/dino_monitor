FactoryBot.define do
  factory :submission do
    site_id { create(:site).id}
    record_taken { Date.today }
    tags  { {} }

    factory :submission_with_type do
      type { Type.new(name: "EMAIL", data: { email_address: "thing@thing.com" }) }
    end
  end
end