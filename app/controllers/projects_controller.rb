class ProjectsController < ApplicationController
  def index
    @projects = Project.search(params[:q])
  end

  def show
    @project = Project.find(params[:id])
    @activities = @project.activities.order('date DESC')
  end
end
#client.project_contacts.find_by(project: @project).main
