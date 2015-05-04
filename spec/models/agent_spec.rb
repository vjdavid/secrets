require 'rails_helper'

RSpec.describe Agent, :type => :model do

  it { should have_many(:projects) }
  it { should belong_to(:current_project) }

end
