class DeadlinesController < ApplicationController
  def index
    @deadlines = Deadline.search(params[:q]).order('date ASC')
    @deadline_dates = Deadline.order('date ASC').distinct.pluck(:date)
  end

  def show
    @deadline = Deadline.find(params[:id])
  end
end
