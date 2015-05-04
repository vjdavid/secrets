require 'rails_helper'

RSpec.describe Project, :type => :model do

  it { should belong_to(:agent) }
  it { should have_many(:tasks) }
  it { should have_one(:assigned_agent) }

end
