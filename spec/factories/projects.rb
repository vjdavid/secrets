FactoryGirl.define do
  factory :project do
    name "This is my first project"
    description "Sample of description"
    agent_id FactoryGirl.create(:agent).id
  end
end
