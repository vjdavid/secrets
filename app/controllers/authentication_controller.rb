class AuthenticationController < ApplicationController
  skip_before_filter :authenticate, only: [:login, :register]

  def register
    @agent = Agent.create(params.permit(:name, :email, :password, :password_confirmation))

    if @agent.save
      render json: @agent
    else
      render json: @agent.errors
    end
  end

  def login
    unless @agent = Agent.find_by(email: params[:email])
      render json: "Not records find with this email"
    end

    if @agent.authenticate(params[:password])
      render json: { token: @agent.token }
    else
      render json: { message: "This password does not matches with user" }
    end
  end

  def logout
    @current_agent.generate_token

    if @current_agent.save
      render json: { message: "Suscessfully logged out" }
    else
      raise StandardError.new("Error while logging user out")
    end
  end
end
