class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to dashboard_path, success: "User was successfully created."
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to account_path, success: "User was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url, success: "User was successfully destroyed."
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:login, :password)
    end
end
