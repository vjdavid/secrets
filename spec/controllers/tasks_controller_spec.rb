require 'rails_helper'
require 'pry'

RSpec.describe TasksController, :type => :controller do

  describe "GET #index" do
    it "return all tasks belongs to project" do
     first_agent = FactoryGirl.create(:agent)
     first_project = FactoryGirl.create(:project, agent_id: first_agent.id)
     3.times { FactoryGirl.create(:task, project_id: first_project.id) }

     extra_agent = FactoryGirl.create(:agent)
     extra_project = FactoryGirl.create(:project, agent_id: extra_agent.id)
     3.times { FactoryGirl.create(:task, project_id: extra_project.id) }

     request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ first_agent.token }\""

     get :index, { project_id: first_project.id }
     body = JSON.parse(response.body)
     expect(body.count).to eq(3)
    end

    it "return all tasks" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      3.times { FactoryGirl.create(:task, project_id: project.id) }

      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      3.times { FactoryGirl.create(:task, project_id: project.id) }

      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      3.times { FactoryGirl.create(:task, project_id: project.id) }

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      get :index
      body = JSON.parse(response.body)
      expect(body.count).to eq(9)
    end
  end

  describe "GET #show" do
    it "show one task" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      task = FactoryGirl.create(:task, project_id: project.id)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      get :show, {id: task.id }
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(task.id)
    end
  end

  describe "POST #create" do
    it "create one task" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      expect {
        post :create, FactoryGirl.attributes_for(:task, project_id: project.id)
        body = JSON.parse(response.body)
      }.to change(Task, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "update on task" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      task = FactoryGirl.create(:task, project_id: project.id)
      old_name = task.name

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      put :update, { id: task.id, name: "sample" }
      body = JSON.parse(response.body)
      new_name = body["name"]
      expect(new_name).not_to eq(old_name)
    end
  end

  describe "DELETE #destroy" do
    it "delete one task" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      task = FactoryGirl.create(:task, project_id: project.id)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ agent.token }\""

      expect {
      delete :destroy, { id: task.id }
      }.to change(Task, :count).by(-1)
    end
  end

end
