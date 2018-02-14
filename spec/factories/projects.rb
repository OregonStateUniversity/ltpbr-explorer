FactoryBot.define do
  factory :project do
    affiliation "Example Affiliation"
    stream_name "Example Stream Name"
    implementation_date Date.today
    narrative "Example Narrative"
    area 1
    maintenance false
    primary_contact "Example Contact"
    author factory: :user
  end
end
