class SessionsController < ApplicationController
  def new
    @particles_js = true
  end

  def create
    user = User.find_by(login: params[:session][:login].downcase)

    if user.present? && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or projects_path
    else
      render 'new', danger: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: "Logged out successfully."
  end
end
