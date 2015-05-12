class TasksController < ApplicationController
  before_action :deny_access
  before_action :find_task, only: [:show, :update, :destroy]

  def index
    if params[:project_id]
      @tasks = Task.where(project_id: params[:project_id])
      render json: @tasks
    else
      @tasks = Task.all
      render json: @tasks
    end
  end

  def show
    render json: @task
  end

  def create
    @task= Task.create(task_params)

    if @task.save
      render json: @task
    else
      render json: @task.errors
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private
  def task_params
    params.permit(:name, :description, :project_id)
  end

  def find_task
    @task = Task.find(params[:id])
  end

end
