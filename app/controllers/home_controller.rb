class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    redirect_to dashboard_path if is_logged_in?
    @particles_js = true
  end
end
