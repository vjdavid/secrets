require 'rails_helper'
require 'pry'

RSpec.describe AgentsController, :type => :controller do

  let( :agent ) { FactoryGirl.create( :agent, password: "trolis" ) }
  let( :http_auth ) { request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\"" }

  describe "GET #index" do
    it "display all agents" do
      5.times { agent }

      get :index
      body = JSON.parse(response.body)
      expect(body.count).to eq(5)
    end
  end

  describe "GET #show" do
    it "display one agent" do
      agent

      get :show, http_auth, { id: agent.id }
      body = JSON.parse(response.body)
      expect(agent.id).to eq(agent.id)
    end
  end

  describe "POST #create" do
    it "create an agent" do
      http_auth
      expect {
        post :create, FactoryGirl.attributes_for(:agent)
        body = JSON.parse(response.body)
      }.to change(Agent, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "update an agent" do
      agent
      old_name = agent.name
      put :update, { id: agent.id, name: "Holis" }
      body = JSON.parse(response.body)
      new_name = body["name"]
      expect(old_name).not_to eq(new_name)
    end
  end

  describe "DELETE #destroy" do
    it "destroy one agent" do
      agent
        delete :destroy, { id: agent.id }
      expect(response.body).to eq("")
    end
  end

end
