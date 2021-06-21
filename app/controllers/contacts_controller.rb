class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

  def index
    @contacts = Contact.filter(params.slice(:query, :role, :category, :country)).order(:name) # filters
    @contacts = @contacts.includes([:role])
    @contacts = @contacts.page(params[:page]).per(20) # Add some pagination

    @all_contacts = Contact.all
    @countries = Contact.distinct.pluck(:country).sort

    flash.now[:notice] = 'No such contact found…' if params[:query].present? && @contacts.count == 0
  end

  def show
  end

  def new
    @contact = Contact.new
    @results = params[:find].present? ? query_tel_search(params[:find]) : nil
    @import_link = params[:tel_search_data].present? ? params[:tel_search_data] : nil
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: "Contact was successfully created." }
        format.js
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
      format.html { redirect_to contacts_url, notice: "Contact was successfully deleted." }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :activity, :phone, :email, :pobox, :street, :city, :country, :category, :notes, :contact_role_id)
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

      puts results

      response.code == 200 ? results : nil
    end
end
