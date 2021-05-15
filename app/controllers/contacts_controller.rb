class ContactsController < ApplicationController
  def index
    @contacts = Contact.search(params[:q])
  end

  def show
    @contact = Contact.find(params[:id])
  end
end
