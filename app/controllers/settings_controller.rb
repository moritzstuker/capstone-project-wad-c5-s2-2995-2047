class SettingsController < ApplicationController
  def index
    @case_categories = ProjectCategory.all
    @contact_categories = ProjectCategory.all
    @users = User.all
    @cases = Project.all
  end
end
