class ContactsController < ApplicationController
  before_action -> { restrict_access(3) }

  def index
    @contacts = Contact.filter(params.slice(:role, :category, :country)).order(:last_name, :first_name) # filters
    @contacts = @contacts.search(params[:q]) if params[:q].present? # searches
  end

  def show
    @contact = Contact.find(params[:id])
  end
end
