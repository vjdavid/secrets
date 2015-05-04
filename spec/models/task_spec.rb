require 'rails_helper'

RSpec.describe Task, :type => :model do
  it { belong_to(:project) }
end
