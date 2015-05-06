require 'rails_helper'

RSpec.describe Task, :type => :model do

  it { belong_to(:project) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

end
