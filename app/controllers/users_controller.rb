class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update destroy ]
  helper_method :can_view?, :can_edit?, :can_delete?

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

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully deleted." }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:login, :name, :password, :password_confirmation, :avatar, :email, :locale, :role, :default_fee)
    end

    def can_view?(user)
      is_partner?(current_user) || can_edit?(user)
    end

    def can_edit?(user)
      is_admin?(current_user) || user == current_user
    end

    def can_delete?(user)
      is_admin?(current_user) unless user == current_user
    end

    def restrict_access
      unless is_admin?
        flash[:error] = "You must be logged in to access this section"
        redirect_to projects_path # halts request cycle
      end
    end
end
