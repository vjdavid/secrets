class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_one :assigned_user, class: User, foreign_key: "current_project_id"

  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
end
