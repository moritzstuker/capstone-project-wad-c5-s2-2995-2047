module Dashboard
  class AccountController < ApplicationController
    before_action :authenticated?, :current_user
    layout "dashboard"

    def index
    end
  end
end
