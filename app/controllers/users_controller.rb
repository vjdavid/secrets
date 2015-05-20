class UsersController < ApplicationController
  before_action :find_user, only: [:show, :update, :destroy, :current_project]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.create(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  def update
   if @user.update(user_params)
     render json: @user
   else
     render json: @user.errors
   end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def current_project
    @project = @user.current_project
    render json: @project
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
