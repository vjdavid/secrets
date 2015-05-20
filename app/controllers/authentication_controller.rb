class AuthenticationController < ApplicationController
  skip_before_filter :authenticate, only: [:login, :register]

  def register
    @user = User.create(params.permit(:name, :email, :password, :password_confirmation))

    if @user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  def login
    unless @user = User.find_by(email: params[:email])
      render json: "Not records find with this email"
    end

    if @user.authenticate(params[:password])
      render json: { token: @user.token }
    else
      render json: { message: "This password does not matches with user" }
    end
  end

  def logout
    @current_user.generate_token

    if @current_user.save
      render json: { message: "Suscessfully logged out" }
    else
      raise StandardError.new("Error while logging user out")
    end
  end
end
