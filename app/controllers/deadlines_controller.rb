class DeadlinesController < ApplicationController
  before_action :set_deadline, only: %i[ update destroy complete ]

  def index
    @all_deadlines_reset = Deadline.where(completed_at: nil)
    @all_deadlines = Deadline.filter(params.slice(:query, :category, :urgency, :user)).order(:date, :label) # filters
    @deadlines = params[:completed] == 'true' ? @all_deadlines : @all_deadlines.where(completed_at: nil)

    @deadlines_by_dates = @deadlines.group_by(&:date).sort
    @deadlines_by_dates = Kaminari.paginate_array(@deadlines_by_dates).page(params[:page]).per(10)

    @categories = Deadline::CATEGORIES.sort
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
    @deadline.update(completed_at: Time.now)

    respond_to do |format|
      format.js
    end
  end

  private

  def set_deadline
    @deadline = Deadline.find(params[:id])
  end

  def deadline_params
    params.require(:deadline).permit(:label, :category, :date, :completed_at, :project_id, :user_id)
  end
end
