class DeadlinesController < ApplicationController
  before_action :set_deadline, only: %i[ show edit update destroy ]

  def index
    @deadlines = Deadline.filter(params.slice(:query, :category, :urgency, :user)).order(:date, :label) # filters

    @deadlines = @deadlines.includes(:project).includes(:assignee)
    @deadlines_by_dates = @deadlines.group_by(&:date).sort
    @deadlines_by_dates = Kaminari.paginate_array(@deadlines_by_dates).page(params[:page]).per(10)

    @categories = @deadlines.distinct.pluck(:category).sort
    @users = User.all

    flash.now[:notice] = 'No such deadline found…' if params[:query].present? && @deadlines.count == 0
  end

  def show
  end

  def new
    @deadline = Deadline.new
  end

  def edit
  end

  def create
    @deadline = Deadline.new(deadline_params)

    respond_to do |format|
      if @deadline.save
        format.html { redirect_to @deadline.project, notice: "Deadline was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deadline.update(deadline_params)
        format.html { redirect_to @deadline.project, notice: "Deadline was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deadline.destroy
    respond_to do |format|
      format.html { redirect_to @deadline.project, notice: "Deadline was successfully deleted." }
    end
  end

  def complete
    @deadline = Deadline.find(params[:id])
    @deadline.update(completed_at: Time.now)
    redirect_to @deadline.project, notice: "Deadline was successfully marked as complete."
  end


  private
    def set_deadline
      @deadline = Deadline.find(params[:id])
    end

    def deadline_params
      params.require(:deadline).permit(:label, :category, :date, :completed_at, :project_id, :user_id)
    end
end
