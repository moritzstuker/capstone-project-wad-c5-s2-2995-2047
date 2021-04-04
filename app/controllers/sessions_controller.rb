class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    if !!@user && @user.authenticate(params[:username])
      #set session and redirect on success
      session[:user_id] = @user.id
      redirect_to user_path
    else
      # error message on fail
      message = "Whoops"
      redirect_to login_path, info: message
    end
  end
end
