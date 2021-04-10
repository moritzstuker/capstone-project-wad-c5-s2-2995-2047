class ContactsController < ApplicationController
  before_action :logged_in?
  layout "dashboard"

  def index
    @contacts = Contact.all
  end
end
