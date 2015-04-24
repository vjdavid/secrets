class Agent < ActiveRecord::Base
  has_many :projects
  belongs_to :current_project, class: Project
end
