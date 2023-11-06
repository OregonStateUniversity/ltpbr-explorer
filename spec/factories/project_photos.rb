FactoryBot.define do
  factory :project_photo do
    description { "Example project photo" }
    date { "2023-11-05" }
    project factory: :project
  end
end
