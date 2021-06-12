class DeadlinesController < ApplicationController
  def index
    @all_deadlines = Deadline.includes(:assignee, :project)
    @deadlines = Deadline.filter(params.slice(:user, :category, :show, :urgency)).order(date: :asc) # filters
    @deadlines = @deadlines.where(completed_at: nil) unless params[:show].present?
    @deadlines = @deadlines.search(params[:q]) if params[:q].present? # searches
    @deadlines = @deadlines.includes(:assignee, :project) # this is to prevent an N+1 query down the line
    @deadlines = @deadlines.page(params[:page]).per(10) # Finally, add some pagination

    @dates = @deadlines.distinct.pluck(:date).sort
    @categories = @all_deadlines.distinct.pluck(:category).sort
    @users = User.includes([:contact])
  end
end
