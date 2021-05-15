class SettingsController < ApplicationController
  def index
    @case_categories = ProjectCategory.all
    @contact_roles = ContactRole.all
    @contacts = Contact.all
    @users = User.all
    @cases = Project.all
  end
end
