require 'rails_helper'
require 'pry'

RSpec.describe AgentsController, :type => :controller do

  describe "GET #index" do
    it "display all agents" do
      5.times { FactoryGirl.create(:agent) }

      get :index, { :id => 1 }
      body = JSON.parse(response.body)
      expect(body.count).to eq(5)
    end
  end

  describe "GET #show" do
    it "display one agent" do
      agent = FactoryGirl.create(:agent)

      get :show, { :id => agent.id }
      body = JSON.parse(response.body)
      expect(agent.id).to eq(agent.id)
    end
  end

end
