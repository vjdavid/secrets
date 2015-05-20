require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:projects) }
  it { should belong_to(:current_project) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

end
