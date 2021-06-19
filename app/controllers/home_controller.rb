class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    @particles_js = true
  end
end
