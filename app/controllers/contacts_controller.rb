class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show ]
  before_action :can_edit?,   only: %i[ edit update ]
  before_action :can_delete?, only: %i[ destroy ]
  helper_method :can_edit?, :can_delete?

  def index
    @all_contacts = Contact
    @contacts = @all_contacts.filter(params.slice(:role, :category, :country)).order(:last_name, :first_name) # filters
    @contacts = @contacts.search(params[:q]) if params[:q].present? # searches
    @contacts = @contacts.includes(:address, :role) # this is to prevent an N+1 query down the line
    @contacts = @contacts.page(params[:page]).per(10) # Finally, add some pagination

    @countries = ContactAddress.distinct.pluck(:country).sort
  end

  def show
  end

  def new
    @contact = Contact.new
    @results = params[:find].present? ? query_tel_search(params[:find]) : nil
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
    params.require(:contact).permit()
  end

  def can_edit?(contact = @contact, user = current_user)
    can_delete?(contact, user) || is_associate?(user)
  end

  def can_delete?(contact = @contact, user = current_user)
    is_partner?(user) || is_admin?(user)
    # 'contact = @contact' is not used. But this method is called from partials that apply tu multiple different models, so there has to be an attribute casing.
  end

  def query_tel_search(query)
    query = URI.parse(URI.escape(query))
    response = HTTParty.get(
      # the TEL_SEARCH_KEY cannot be passed as a header item in this case, this being a requirement from this provider... https://tel.search.ch/api/help.html
      "https://tel.search.ch/api/?was=#{ query }&maxnum=25&lang=#{ 'fr' }&key=#{ ENV['TEL_SEARCH_KEY'] }"
    )

    hash = Hash.from_xml(response.body)
    results = {
      total: hash['feed']['totalResults'].to_i,
      items: hash['feed']['entry']
    }

    response.code == 200 ? results : nil
  end
end
