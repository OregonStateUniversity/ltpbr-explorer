FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'Fake Name' }
    affiliation { 'Fake Affiliation' }
  end

  trait :admin do
    role { 'admin' }
  end

end
