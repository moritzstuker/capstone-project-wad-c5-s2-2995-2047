class DashboardController < ApplicationController
  before_action :authenticated?, :current_user

  def index
  end
end
