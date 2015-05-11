class Agent < ActiveRecord::Base
  has_secure_password validations: false

  before_validation :generate_token,                    on: :create

  has_many :projects
  belongs_to :current_project,                          class: Project

  validates :name,                                      presence: true
  validates :email,                   presence: true, uniqueness: true
  validates :password,                                  presence: true
  validates :token,                                     presence: true

  private

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end

end
