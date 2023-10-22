FactoryBot.define do
  factory :organization do
    name { "Example Organization" }
    description { "Example organization description"}
    contact { "Example organization contact info" }
    website { "https://example.org" }
  end
end
