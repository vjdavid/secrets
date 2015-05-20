require 'rails_helper'
require 'pry'

RSpec.describe UsersController, :type => :controller do

  let( :user ) { FactoryGirl.create( :user, password: "trolis" ) }

  before :each do
    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{ user.token }\""
  end

  describe "GET #index" do
    it "display all users" do
      5.times { FactoryGirl.create(:user) }

      get :index
      body = JSON.parse(response.body)
      expect(body.count).to eq(6)
    end
  end

  describe "GET #show" do
    it "display one user" do

      get :show, { id: user.id }
      body = JSON.parse(response.body)
      expect(user.id).to eq(user.id)
    end
  end

  describe "POST #create" do
    it "create an user" do
      expect {
        post :create, FactoryGirl.attributes_for(:user)
        body = JSON.parse(response.body)
      }.to change(User, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "update an user" do
      old_name = user.name
      put :update, { id: user.id, name: "Holis" }
      body = JSON.parse(response.body)
      new_name = body["name"]
      expect(old_name).not_to eq(new_name)
    end
  end

  describe "DELETE #destroy" do
      it "destroy one user" do
      delete :destroy, { id: user.id }
      expect(response.body).to eq("")
    end
  end

end
