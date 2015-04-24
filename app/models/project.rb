class Project < ActiveRecord::Base
  belongs_to :agent
  has_many :tasks
  has_one :assigned_agent, class: Agent, foreign_key: "current_project_id"
end
