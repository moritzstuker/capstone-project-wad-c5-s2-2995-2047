class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action do
    has_access_rights(current_user)
  end
  helper_method :can_view?, :can_edit?, :can_delete?

  def index
    @users = User.all
  end

  def show
    redirect_to dashboard_url if @user == current_user
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
        log_in @user unless is_logged_in?
        format.html { redirect_to @user, notice: "#{ t('.success') }." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "#{ t('.success') }." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "#{ t('.success') }." }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:login, :name, :password, :password_confirmation, :avatar, :email, :locale, :role, :default_fee)
  end

  def log_in(user)
    session[:user_id] = user.id
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

  def has_access_rights(user)
    unless is_admin?(user) || user == @user
      flash[:alert] = "#{ t('users.restricted_access') }."
      redirect_back fallback_location: dashboard_url
    end
  end
end
