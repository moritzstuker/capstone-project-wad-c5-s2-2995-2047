module RolesHelper
  def current_user_role
    logged_in? ? current_user.role : 'anonymous'
  end
end
