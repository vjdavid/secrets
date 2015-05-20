require 'rails_helper'
require 'pry'

RSpec.describe ProjectsController, :type => :controller do

  describe "GET #index" do
    it "return all projects belongs to user" do

      first_user = FactoryGirl.create(:user, password: "holis")
      5.times { FactoryGirl.create(:project, user_id: first_user.id) }

      additional_user = FactoryGirl.create(:user, password: "crayolis")
      5.times { FactoryGirl.create(:project, user_id: additional_user.id) }

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ first_user.token }\""

      get :index, { user_id: first_user.id }
      body = JSON.parse(response.body)
      expect(body.count).to eq(5)
    end

    it "return all projects" do
      user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:project, user_id: user.id) }

      user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:project, user_id: user.id) }

      user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:project, user_id: user.id) }

      user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:project, user_id: user.id) }

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ user.token }\""

      get :index
      body = JSON.parse(response.body)
      expect(body.count).to eq(20)
    end
  end

  describe "GET #show" do
    it "show one project" do
      user = FactoryGirl.create(:user)
      project = FactoryGirl.create(:project, user_id: user.id)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ user.token }\""

      get :show, { id: project.id }
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(project.id)
    end
  end

  describe "POST #create" do
    it "create one project" do
      user = FactoryGirl.create(:user)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ user.token }\""

      expect {
        post :create, FactoryGirl.attributes_for(:project, user_id: user.id)
      }.to change(Project, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "update one project" do
      user = FactoryGirl.create(:user)
      project = FactoryGirl.create(:project, user_id: user.id)
      old_name = project.name

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ user.token }\""

      put :update, { id: project.id, name: "holis" }
      body = JSON.parse(response.body)
      new_name = body["name"]
      expect(old_name).not_to eq(new_name)
    end
  end

  describe "DELETE #destroy" do
    it "delete one project" do
      user = FactoryGirl.create(:user)
      project = FactoryGirl.create(:project, user_id: user.id)

      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ user.token }\""

      expect {
        delete :destroy, { id: project.id }
      }.to change(Project, :count).by(-1)
    end
  end

end
