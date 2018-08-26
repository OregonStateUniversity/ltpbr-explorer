FactoryBot.define do
  factory :project do
    affiliation { "Example Affiliation" }
    stream_name { "Example Stream Name" }
    implementation_date { Date.today }
    narrative { "Example Narrative" }
    area { 1 }
    maintenance { false }
    primary_contact { "Example Contact" }
    latitude { 1.0 }
    longitude { 1.0 }
    number_of_structures { 1 }
    author factory: :user
  end
end
