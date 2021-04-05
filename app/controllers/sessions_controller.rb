class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username].downcase)

    respond_to do |format|
      if @user.present? && @user.authenticate(params[:password])
        session[:user_id] = @user.id

        format.html { redirect_to @user }
      else
        format.html { redirect_to new_session_url, alert: "Not good" }
      end
    end
  end

  def destroy
    session.delete(:user_id)

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Good" }
    end
  end
end
