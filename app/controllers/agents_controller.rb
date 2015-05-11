class AgentsController < ApplicationController
  before_action :find_agent, only: [:show, :update, :destroy, :current_project]

  def index
    @agents = Agent.all
    render json: @agents
  end

  def show
    render json: @agent
  end

  def create
    @agent = Agent.create(agent_params)

    if @agent.save
      render json: @agent
    else
      render json: @agent.errors
    end
  end

  def update
   if @agent.update(agent_params)
     render json: @agent
   else
     render json: @agent.errors
   end
  end

  def destroy
    @agent.destroy
    head :no_content
  end

  def current_project
    @project = @agent.current_project
    render json: @project
  end

  def login
    unless @agent = Agent.find_by(email: params[:email])
      return json: { message: "Record not found with this email" }
    end

    if @agent.authenticate(params[:password])
      render json: { token: @agent.token }
    else
      render json: { message: "Password does match with this agent" }
    end
  end

  private

  def restrict_access
    agent = Agent.find(params[:token])
    head :no_content unless agent
  end

  def find_agent
    @agent = Agent.find(params[:id])
  end

  def agent_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
