FactoryBot.define do
  factory :user do
    username { 'username' }
    email { 'example@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'Fake Name' }
    affiliation { 'exampleAffiliation' }
  end

  trait :admin do
    role { 'admin' }
  end

end
