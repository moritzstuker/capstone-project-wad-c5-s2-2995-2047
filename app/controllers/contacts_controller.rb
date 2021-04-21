class ContactsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all.order(sort_column + " " + sort_direction).search(params[:search])

    @contacts = @contacts.where('role LIKE ?', "#{params[:role]}") if params[:role].present?
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

    if @contact.save
      redirect_to dashboard_path, success: "Contact was successfully created."
    else
      render "new"
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to dashboard_path, success: "Contact was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @contact.destroy
    redirect_to root_url, success: "Contact was successfully destroyed."
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def sort_column
    Contact.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w(asc desc).include?(params[:dir]) ? params[:dir] : "desc"
  end
end
