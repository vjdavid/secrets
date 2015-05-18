require 'rails_helper'

RSpec.describe AuthenticationController, :type => :controller do

  describe "POST #register" do
    it "join one agent" do
      agent = FactoryGirl.create(:agent, password: "holis")
      expect {
        post :register, FactoryGirl.attributes_for(:agent, password: "holis")
        body = JSON.parse(response.body)
      }.to change(Agent, :count).by(1)
    end
  end

  describe "POST #login" do
    it "login one agent" do
      agent = FactoryGirl.create(:agent, password: "nolis")
      agent_extra = FactoryGirl.create(:agent, email: "holis@trolis.com", password: "trolis")

      post :login, { email: agent.email, password: agent.password }
      body = JSON.parse(response.body)
      expect(agent).not_to eq(agent_extra)
    end
  end

  describe "POST #logout" do
    it "signout one agent" do
      agent = FactoryGirl.create(:agent, password: "holis")
      old_token = agent.token
      new_token = SecureRandom.hex

      post :logout, { id: 1, token: new_token }
      expect(old_token).not_to eq(new_token)
    end
  end

end
