class DeadlinesController < ApplicationController
  before_action :set_deadline, only: %i[ show edit update destroy ]

  def index
    @deadlines = Deadline.filter(params.slice(:query, :category, :urgency, :user)).order(:date, :label) # filters
    @deadlines = @deadlines.includes(:assignee, project: [:owner])

    @deadlines_by_dates = @deadlines.group_by(&:date).sort
    @deadlines_by_dates = Kaminari.paginate_array(@deadlines_by_dates).page(params[:page]).per(10)

    @categories = @deadlines.distinct.pluck(:category).sort
    @users = User.all

    flash.now[:notice] = "#{ t('.no_results') }." if params[:query].present? && @deadlines.count == 0
  end

  def new
    @deadline = Deadline.new
  end

  def create
    @deadline = Deadline.new(deadline_params)

    respond_to do |format|
      if @deadline.save
        format.html { redirect_to @deadline.project, notice: "#{ t('.success') }." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deadline.update(deadline_params)
        format.html { redirect_to @deadline.project, notice: "#{ t('.success') }." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deadline.destroy
    respond_to do |format|
      format.html { redirect_to @deadline.project, notice: "#{ t('.success') }." }
    end
  end

  def complete
    @deadline = Deadline.find(params[:id])
    @deadline.update(completed_at: Time.now)
    redirect_back(fallback_location: @deadline.project)
    flash.now[:notice] = "#{ t('.success') }."
  end

  private
    def set_deadline
      @deadline = Deadline.find(params[:id])
    end

    def deadline_params
      params.require(:deadline).permit(:label, :category, :date, :completed_at, :project_id, :user_id)
    end
end
