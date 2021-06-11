class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show ]
  helper_method :can_edit?, :can_delete?

  def index
    @projects = Project.filter(params.slice(:category, :status, :user)).order(:label) # filters
    @projects = @projects.search(params[:q]) if params[:q].present? # searches
    @projects = @projects.includes(:category) # this is to prevent an N+1 query down the line
    @assignments = Assignment.all

    @users = User.includes(:contact).order("contacts.last_name")
  end

  def show
    @activities = @project.activities.order('date DESC').includes(:user)
    @deadlines  = @project.deadlines.includes(:assignee)
    @assignees  = @project.assignees.includes(:contact)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def can_edit?(project = @project, user = current_user)
    can_delete?(project, user) || project.assignees.include?(user)
  end

  def can_delete?(project = @project, user = current_user)
    is_partner?(user) || is_admin?(user)
    # 'project = @project' is not used. But this method is called from partials that apply tu multiple different models, so there has to be an attribute casing.
  end
end
