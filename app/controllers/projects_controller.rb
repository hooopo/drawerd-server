class ProjectsController < ApplicationController
  def index
    @projects = current_user.company.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(params.fetch(:project, {}).permit(:name, :adapter))
    @project.company = current_user.company
    if @project.save
      redirect_to project_path(@project), notice: 'success created'
    else
      flash.now[:notice] = 'fail'
      render :new
    end
  end

  def show
    @project = current_user.company.projects.find(params[:id])
  end
end
