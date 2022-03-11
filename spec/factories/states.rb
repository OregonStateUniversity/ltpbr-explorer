FactoryBot.define do
  factory :state do
    name { "MyString" }
    hasc_code { "MyString" }
    state_type { "" }
    geom { "" }
    total_length { 1 }
    total_number_of_structures { 1 }
  end
end
