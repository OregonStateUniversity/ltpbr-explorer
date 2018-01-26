FactoryBot.define do
  factory :user do
    username 'username'
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
    affiliation 'exampleAffiliation'
  end
end
