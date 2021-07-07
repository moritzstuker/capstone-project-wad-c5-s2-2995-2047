class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]
  helper_method :can_edit?, :can_delete?

  def index
    @contacts = Contact.filter(params.slice(:query, :role, :category, :country)).order(:name) # filters
    @contacts = @contacts.includes([:role])
    @contacts = @contacts.page(params[:page]).per(20) # Add some pagination

    @all_contacts = Contact.all
    @countries = Contact.distinct.pluck(:country).sort

    flash.now[:notice] = "#{ t('.no_results') }." if params[:query].present? && @contacts.count == 0
  end

  def show
    @projects = @contact.projects.includes(:owner)
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
        format.html { redirect_to @contact, notice: "#{ t('.success') }." }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: "#{ t('.success') }." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "#{ t('.success') }." }
    end
  end

  def import
    @search_limit = 25
    @contact = Contact.new
    @results = params[:search].present? ? query_tel_search(params[:search]) : nil
    @import_link = params[:tel_search_data].present? ? params[:tel_search_data] : nil
  end

  private
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :activity, :email, :street, :city, :country, :category, :notes, :contact_role_id, :import_uid)
  end

  def query_tel_search(query)
    query = URI.parse(URI.escape(query))
    response = HTTParty.get(
      # the TEL_SEARCH_KEY cannot be passed as a header item in this case, this being a requirement from this provider... https://tel.search.ch/api/help.html
      "https://tel.search.ch/api/?was=#{ query }&maxnum=#{ @search_limit }&lang=#{ I18n.locale.to_s }&key=#{ ENV['TEL_SEARCH_KEY'] }"
    )

    hash = Hash.from_xml(response.body)
    results = {
      total: hash['feed']['totalResults'].to_i,
      items: hash['feed']['entry']
    }

    response.code == 200 ? results : nil
  end

  def can_edit?(contact = @contact, user = current_user)
    is_associate?(user) || can_delete?(contact, user)
  end

  def can_delete?(contact = @contact, user = current_user)
    is_admin?(user)
  end
end
