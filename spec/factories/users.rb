FactoryBot.define do
  factory :user do
    name { 'Maya' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'pas123' }
  end
end
