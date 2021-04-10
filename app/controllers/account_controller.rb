class AccountController < ApplicationController
  before_action :logged_in?
  layout "dashboard"

  def index
  end
end
