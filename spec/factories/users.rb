FactoryGirl.define do
  factory :user do
    name "David"
    email { Faker::Internet.email }
    password "holis"
  end
end
