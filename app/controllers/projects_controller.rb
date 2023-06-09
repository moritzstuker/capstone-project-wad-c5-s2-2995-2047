class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  helper_method :can_edit?, :can_delete?

  def index
    @projects = Project.filter(params.slice(:query, :category, :status, :owner)).order(created_at: :desc) # filters
    @all_projects = Project.all.order(created_at: :desc)

    @projects = @projects.includes(:category, :owner) # this is to prevent an N+1 query down the line
    @projects = @projects.page(params[:page]).per(10) # Finally, add some pagination

    @users = User.order(role: :desc, last_name: :asc)

    flash.now[:notice] = "#{ t('.no_results') }." if params[:query].present? && @projects.count == 0
  end

  def show
    @deadlines = @project.deadlines.includes(:user)
    @deadlines_by_dates = @deadlines.group_by(&:date).sort
    respond_to do |format|
      format.html { render 'show' }
      format.json { render json: @project }
    end
  end

  def new
    @project = Project.new
  end

  def edit
    if can_edit?(@project, current_user)
      true
    else
      flash[:alert] = "#{ t('users.restricted_access') }."
      redirect_back fallback_location: dashboard_url
    end
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "#{ t('.success') }." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if can_edit?(@project, current_user)
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to @project, notice: "#{ t('.success') }." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = "#{ t('users.restricted_access') }."
      redirect_back fallback_location: dashboard_url
    end
  end

  def destroy
    if can_delete?(@project, current_user)
      @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_url, notice: "#{ t('.success') }." }
      end
    else
      flash[:alert] = "#{ t('users.restricted_access') }."
      redirect_back fallback_location: dashboard_url
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:label, :reference, :status, :description, :owner_id, :project_category_id, contact_ids: [])
  end

  def can_edit?(project = @project, user = current_user)
    can_delete?(project, user) || is_partner?(user) || is_associate?(user)
  end

  def can_delete?(project = @project, user = current_user)
    user == project.owner || is_admin?(user)
  end
end
