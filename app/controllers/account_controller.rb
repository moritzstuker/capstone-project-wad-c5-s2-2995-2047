class AccountController < ApplicationController
  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to account_path, notice: 'Account updated' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user)
    .permit(
      :login,
      :password,
      :avatar,
      :preferred_lang,
      contact_attributes: [
        :id,
        :first_name,
        :last_name,
        :email,
        :birthday
      ]
    )
  end
end
