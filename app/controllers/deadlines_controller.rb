class DeadlinesController < ApplicationController
  def index
    @deadlines = Deadline.filter(params.slice(:assignee)).search(params[:q]).order('date ASC')
  end

  def show
    @deadline = Deadline.find(params[:id])
  end
end
