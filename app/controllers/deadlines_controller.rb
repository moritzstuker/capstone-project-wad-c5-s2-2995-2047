class DeadlinesController < ApplicationController
  before_action -> { restrict_access(3) }

  def index
    @deadlines = Deadline.filter(params.slice(:user, :category, :show, :urgency)).order(date: :asc) # filters
    @deadlines = @deadlines.where(completed_at: nil) unless params[:show].present?
    @deadlines = @deadlines.search(params[:q]) if params[:q].present? # searches
  end

  def show
    @deadline = Deadline.find(params[:id])
  end
end
