FactoryGirl.define do
  factory :task do
    name "My task name"
    description "sample description of my first task"
    project_id FactoryGirl.create(:project).id
  end
end
