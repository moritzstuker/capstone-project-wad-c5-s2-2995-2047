class ActivitiesController < ApplicationController
  before_action :set_project
  helper_method :can_delete?

  def create
    @activity = Activity.new(activity_params)
    @activity.project = @project
    @activity.user = current_user

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @project, notice: "#{ t('.success') }." }
        format.js
      else
        format.html { redirect_to @project, alert: "#{ t('activity.create.failure') }.", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: "#{ t('.success') }." }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def activity_params
    params.require(:activity).permit(:label, :category, :date, :duration, :fee, :project_id, :user)
  end

  def can_delete?(activity)
    current_user == activity.project.owner || current_user == activity.user || is_admin?(user)
  end
end
