class ProjectsController < ApplicationController
  before_action :deny_access
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    if params[:agent_id]
      @projects = Project.where(agent_id: params[:agent_id])
      render json: @projects
    else
      @projects = Project.all
      render json: @projects
    end
  end

  def show
    render json: @project
  end

  def create
    @project = Project.create(project_params)

    if @project.save
      render json: @project
    else
      render json: @project.errors
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors
    end
  end

  def destroy
    @project.destroy
    head :no_content
  end

  private
  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.permit(:name, :description, :agent_id)
  end
end
