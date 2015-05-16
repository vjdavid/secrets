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
      agent = FactoryGirl.create(:agent, password: "trolis")
      expect {
        post :login, FactoryGirl.create(:agent, password: "trolis")
        body = JSON.parse(response.body)
      }
    end
  end

  describe "POST #logout" do
    it "signout one agent" do
    end
  end

end
