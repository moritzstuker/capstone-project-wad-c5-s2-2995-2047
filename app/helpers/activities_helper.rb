module ActivitiesHelper
  def can_delete_activity?(activity, user)
    user == activity.project.owner || user == activity.user || can_delete?(activity.project, user)
  end
end
