class ContactsController < ApplicationController
  layout "dashboard"
  def index
    @contacts = Contact.all
  end
end
