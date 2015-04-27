class AgentsController < ApplicationController
  before_action :find_agent, only: [:show, :current_project]

  def index
    @agents = Agent.all
    render json: @agents
  end

  def show
    render json: @agent
  end

  def current_project
    @agent = @agent.current_project
    render json: @agent
  end

  private
  def find_agent
    @agent = Agent.find(params[:id])
  end

  def agent_params
    params.permit(:name, :email)
  end

end
