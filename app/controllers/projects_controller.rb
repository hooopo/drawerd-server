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

  def render_svg
    @project = current_user.company.projects.includes(:tables => :columns).find(params[:id])
    graph = @project.to_graph(mode: params[:mode], layout: params[:layout])
    path = Rails.root.join("tmp", "#{@project.id}.svg")
    graph.output(svg: path)
    send_file path, type: 'image/svg+xml', disposition: "inline"
  end

  def show
    @project = current_user.company.projects.includes(:tables => :columns).find(params[:id])
  end
end
