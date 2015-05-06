require 'rails_helper'

RSpec.describe Project, :type => :model do

  it { should belong_to(:agent) }
  it { should have_many(:tasks) }
  it { should have_one(:assigned_agent) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

end
