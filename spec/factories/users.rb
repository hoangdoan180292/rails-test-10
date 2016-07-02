FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "user#{n}@example.com" }
    sequence(:name)   { |n| "User #{n}" }
    password          "123123123"
  end
end
