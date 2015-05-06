require 'rails_helper'
require 'pry'

RSpec.describe TasksController, :type => :controller do

  describe "GET #index" do
    it "return all tasks" do
     project = FactoryGirl.create(:project)
     3.times { FactoryGirl.create(:task, project_id: project.id) }

     get :index, { project_id: project.id }
     body = JSON.parse(response.body)
     expect(body.count).to eq(3)
    end
  end

  describe "GET #show" do
    it "show one task" do
      task = FactoryGirl.create(:task)

      get :show, {id: task.id }
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(task.id)
    end
  end

  describe "POST #create" do
    it "create one task" do
      expect {
        post :create, FactoryGirl.attributes_for(:task)
        body = JSON.parse(response.body)
      }.to change(Task, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "update on task" do
      task = FactoryGirl.create(:task)
      old_name = task.name

      put :update, { id: task.id, name: "sample" }
      body = JSON.parse(response.body)
      new_name = body["name"]
      expect(new_name).not_to eq(old_name)
    end
  end

  describe "DELETE #destroy" do
    it "delete one task" do
      task = FactoryGirl.create(:task)

      delete :destroy, { id: task.id }
      expect(response.body).to eq("")
    end
  end

end
