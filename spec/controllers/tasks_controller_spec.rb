require 'rails_helper'
require 'pry'

RSpec.describe TasksController, :type => :controller do

  describe "GET #index" do
    it "return all tasks belongs to project" do
     agent = FactoryGirl.create(:agent)
     project = FactoryGirl.create(:project, agent_id: agent.id)
     3.times { FactoryGirl.create(:task, project_id: project.id) }

     get :index, { project_id: project.id }
     body = JSON.parse(response.body)
     expect(body.count).to eq(3)
    end

    it "return all tasks" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id )
      3.times { FactoryGirl.create(:task, project_id: project.id) }

      get :index, { id: 1 }
      body = JSON.parse(response.body)
      expect(body.count).to eq(3)
    end
  end

  describe "GET #show" do
    it "show one task" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
      task = FactoryGirl.create(:task, project_id: project.id)

      get :show, {id: task.id }
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(task.id)
    end
  end

  describe "POST #create" do
    it "create one task" do
      agent = FactoryGirl.create(:agent)
      project = FactoryGirl.create(:project, agent_id: agent.id)
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

      delete :destroy, { id: task.id }
      expect(response.body).to eq("")
    end
  end

end
