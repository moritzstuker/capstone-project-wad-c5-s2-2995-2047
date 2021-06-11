class UsersController < ApplicationController
  before_action :set_user,  only: %i[ show edit update destroy ]
  before_action :can_edit?, only: %i[ edit update destroy ]
  helper_method :can_edit?, :can_delete?
  def index
    @users = User.all.includes(:contact, :role)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash.notice = "Welcome to the app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:login, :password, :avatar, :contact, :role, :preferred_lang)
    end

    def can_edit?(target_user, user = current_user)
      can_delete?(target_user, user) || is_partner?(user) || is_admin?(user)
    end

    def can_delete?(target_user, user = current_user)
      target_user.role.access_level > current_user.role.access_level
    end
end
