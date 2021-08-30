module ActivitiesHelper
  def can_delete_activity?(activity, user)
    user == activity.project.owner || user == activity.user || can_delete?(activity.project, user)
  end

  def total_billed(activities)
    total = 0
    activities.each do |activity|
      total += activity.fee * activity.duration
    end
    return total
  end
end
