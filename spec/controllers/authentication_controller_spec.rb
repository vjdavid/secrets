require 'rails_helper'

RSpec.describe AuthenticationController, :type => :controller do

  describe "POST #register" do
    it "join one user" do
      user = FactoryGirl.create(:user, password: "holis")
      expect {
        post :register, FactoryGirl.attributes_for(:user, password: "holis")
        body = JSON.parse(response.body)
      }.to change(User, :count).by(1)
    end
  end

  describe "POST #login" do
    it "login one user" do
      user = FactoryGirl.create(:user, password: "nolis")
      user_extra = FactoryGirl.create(:user, email: "holis@trolis.com", password: "trolis")

      post :login, { email: user.email, password: user.password }
      body = JSON.parse(response.body)
      expect(user).not_to eq(user_extra)
    end
  end

  describe "POST #logout" do
    it "signout one user" do
      user = FactoryGirl.create(:user, password: "holis")
      old_token = user.token
      new_token = SecureRandom.hex

      post :logout, { id: 1, token: new_token }
      expect(old_token).not_to eq(new_token)
    end
  end

end
