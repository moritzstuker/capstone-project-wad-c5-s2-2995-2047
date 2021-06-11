class UsersController < ApplicationController
  before_action :set_user,  only: %i[ show edit update destroy ]
  before_action :can_edit?, only: %i[ edit update destroy ]
  helper_method :can_edit?, :can_delete?

  def index
    @users = User.all.includes(:contact, :role)
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
        log_in @user
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
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    end
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
