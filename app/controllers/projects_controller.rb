class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  helper_method :can_edit?, :can_delete?

  def index
    @projects = Project.filter(params.slice(:category, :status, :user)).order(:label) # filters
    @projects = @projects.search(params[:q]) if params[:q].present? # searches
    @projects = @projects.includes(:category) # this is to prevent an N+1 query down the line
    @projects = @projects.page(params[:page]).per(10) # Finally, add some pagination
    @assignments = Assignment.all

    @users = User.includes(:contact).order("contacts.last_name")
  end

  def show
    @activities = @project.activities.order('date DESC').includes(:user)
    @deadlines  = @project.deadlines.includes(:assignee)
    @assignees  = @project.assignees.includes(:contact)
  end

  def new
    @project = Project.new
    @potential_owners = User.partners.includes([:contact]).order('contacts.last_name')
    @potential_categories = ProjectCategory.all.order(:label)
    @potential_assignees = User.lawyers.includes([:contact]).order('contacts.last_name ASC, contacts.first_name ASC')
    @potential_clients = Contact.clients.order('last_name ASC, first_name ASC')
    @potential_adversaries = Contact.adversaries.order('last_name ASC, first_name ASC')
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:login, :password, :avatar, :contact, :role, :preferred_lang)
  end

  def can_edit?(project = @project, user = current_user)
    can_delete?(project, user) || project.assignees.include?(user)
  end

  def can_delete?(project = @project, user = current_user)
    is_partner?(user) || is_admin?(user)
    # 'project = @project' is not used. But this method is called from partials that apply tu multiple different models, so there has to be an attribute casing.
  end
end
