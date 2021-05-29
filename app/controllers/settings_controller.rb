class SettingsController < ApplicationController
  before_action -> { restrict_access(1) }

  def index
    @case_categories = ProjectCategory.all
    @contact_roles = ContactRole.all
    @contacts = Contact.all
    @users = User.all
    @cases = Project.all
  end
end
