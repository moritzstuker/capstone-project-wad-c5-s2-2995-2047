class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @particles_js = true
  end

  def create
    user = User.find_by(login: params[:session][:login].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to dashboard_path
    else
      flash.now[:alert] = "#{ t('.invalid_combination') }."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: "#{ t('.success') }."
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
