class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @activities = Activity.order('date DESC').includes(:user)
  end
end
