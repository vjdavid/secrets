FactoryGirl.define do
  factory :agent do
    name "David"
    email { Faker::Internet.email }
  end
end
