require 'rails_helper'
require 'pry'

RSpec.describe ProjectsController, :type => :controller do

  describe "GET #index" do
    it "return all projects belongs to agent" do

      first_agent = FactoryGirl.create(:agent, password: "holis")
      5.times { FactoryGirl.create(:project, agent_id: first_agent.id) }

      additional_agent = FactoryGirl.create(:agent, password: "crayolis")
      5.times { FactoryGirl.create(:project, agent_id: additional_agent.id) }

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ first_agent.token }\""

      get :index, { agent_id: first_agent.id }
      body = JSON.parse(response.body)
      expect(body.count).to eq(5)
    end

    it "return all projects" do
      agent = FactoryGirl.create(:agent)
      5.times { FactoryGirl.create(:project, agent_id: agent.id) }

      agent = FactoryGirl.create(:agent)
      5.times { FactoryGirl.create(:project, agent_id: agent.id) }

      agent = FactoryGirl.create(:agent)
      5.times { FactoryGirl.create(:project, agent_id: agent.id) }

      agent = FactoryGirl.create(:agent)
      5.times { FactoryGirl.create(:project, agent_id: agent.id) }

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      get :index
      body = JSON.parse(response.body)
      expect(body.count).to eq(20)
    end
  end

  describe "GET #show" do
    it "show one project" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      get :show, { id: project.id }
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(project.id)
    end
  end

  describe "POST #create" do
    it "create one project" do
      agent = FactoryGirl.create(:agent)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      expect {
        post :create, FactoryGirl.attributes_for(:project, agent_id: agent.id)
      }.to change(Project, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "update one project" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      old_name = project.name

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      put :update, { id: project.id, name: "holis" }
      body = JSON.parse(response.body)
      new_name = body["name"]
      expect(old_name).not_to eq(new_name)
    end
  end

  describe "DELETE #destroy" do
    it "delete one project" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      expect {
        delete :destroy, { id: project.id }
      }.to change(Project, :count).by(-1)
    end
  end

end
