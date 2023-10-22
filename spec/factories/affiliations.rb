FactoryBot.define do
  factory :affiliation do
    project
    organization
    role { "Fake Affiliation Role" }
  end
end
