class DashboardController < ApplicationController
  before_action -> { restrict_access(4) }

  def index
  end
end
