class Agent < ActiveRecord::Base
  has_many :projects
  belongs_to :current_project, class: Project
  validates :name, presence: true
  validates :email, presence: true
end
