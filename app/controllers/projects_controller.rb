class ProjectsController < ApplicationController
  before_action -> { restrict_access(3) }

  def index
    @projects = Project.filter(params.slice(:category, :status, :user)).order(:label) # filters
    @projects = @projects.search(params[:q]) if params[:q].present? # searches
    @assignments = Assignment.all
  end

  def show
    @project = Project.find(params[:id])
    @activities = @project.activities.order('date DESC')
  end
end
#client.project_contacts.find_by(project: @project).main
