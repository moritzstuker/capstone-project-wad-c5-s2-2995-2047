class DeadlinesController < ApplicationController
  def index
    @deadlines = Deadline.all
    @deadlines_dates = Deadline.distinct.pluck(:date).sort
  end

  def show
    @deadline = Deadline.find(params[:id])
  end
end
