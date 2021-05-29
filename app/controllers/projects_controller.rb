class ProjectsController < ApplicationController
  def index
    @projects = params[:q].present? ? Project.search(params[:q]) : Project.all
    @assignments = Assignment.all
  end

  def show
    @project = Project.find(params[:id])
    @activities = @project.activities.order('date DESC')
  end
end
#client.project_contacts.find_by(project: @project).main
