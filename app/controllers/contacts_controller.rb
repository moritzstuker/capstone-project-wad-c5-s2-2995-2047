class ContactsController < ApplicationController
  before_action :set_contact,  only: %i[ show ]
  helper_method :can_edit?, :can_delete?

  def index
    @all_contacts = Contact
    @contacts = @all_contacts.filter(params.slice(:role, :category, :country)).order(:last_name, :first_name) # filters
    @contacts = @contacts.search(params[:q]) if params[:q].present? # searches
    @contacts = @contacts.includes(:address, :role) # this is to prevent an N+1 query down the line

    @countries = ContactAddress.distinct.pluck(:country).sort
  end

  def show
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def can_edit?(contact = @contact, user = current_user)
    can_delete?(contact, user) || is_associate?(user)
  end

  def can_delete?(contact = @contact, user = current_user)
    is_partner?(user) || is_admin?(user)
    # 'contact = @contact' is not used. But this method is called from partials that apply tu multiple different models, so there has to be an attribute casing.
  end
end
