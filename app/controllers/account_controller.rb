class AccountController < ApplicationController
  before_action -> { restrict_access(4) }

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to account_path
  end
end
