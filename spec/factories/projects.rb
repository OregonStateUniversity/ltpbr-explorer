FactoryBot.define do
  factory :project do
    name { "Example Project Name" }
    url { "example.com" }
    stream_name { "Example Stream Name" }
    watershed { "Example Watershed" }
    implementation_date { Date.today }
    narrative { "Example Narrative" }
    structure_description { "Example project description with design elements"}
    length { 100 }
    primary_contact { "Example Contact" }
    latitude { 44.042969 }
    longitude { -121.333481 }
    number_of_structures { 1 }
    author factory: :user
  end
end
