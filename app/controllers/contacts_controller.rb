class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

  def index
    @contacts = Contact.filter(params.slice(:query, :role, :category, :country)).order(:name) # filters
    @contacts = @contacts.page(params[:page]).per(20) # Add some pagination

    @all_contacts = Contact.all
    @countries = Contact.distinct.pluck(:country).sort

    flash.now[:notice] = 'No such contact found…' if params[:query].present? && @contacts.count == 0
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: "Contact was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: "Contact was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:prefix, :name, :activity, :phone, :email, :pobox, :street, :streetno, :zip, :city, :country, :category, :notes, :contact_role_id)
    end
end
