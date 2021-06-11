class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @particles_js = true
  end

  def create
    user = User.find_by(login: params[:session][:login].downcase)

    if user.present? && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      render 'new', danger: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: "Logged out successfully."
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
