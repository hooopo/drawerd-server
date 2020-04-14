# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :redirect_to_subdomain

  def index
    @projects = current_user.company.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(params.fetch(:project, {}).permit(:name, :adapter, :import_sql))
    @project.company = current_user.company
    if @project.save
      redirect_to project_path(@project), notice: "Project successfully created"
    else
      flash.now[:notice] = "fail"
      render :new
    end
  end

  def render_svg
    if params[:share_key].present?
      @project = Project.where(share_key: params[:share_key]).includes({ tables: [:columns, :group], relationships: [:column, :relation_column] }).find(params[:id])
    else
      @project = current_user.company.projects.includes({ tables: [:columns, :group], relationships: [:column, :relation_column] }).find(params[:id])
    end
    graph = @project.to_graph(mode: params[:mode], layout: params[:layout], group_id: params[:group_id])
    path = Rails.root.join("tmp", "#{@project.id}.svg")
    graph.output(svg: path)
    if params[:download].present?
      send_file path, type: "image/svg+xml", filename: "#{@project.name}.svg"
    else
      send_file path, type: "image/svg+xml", disposition: "inline"
    end
  end

  def show
    @project = current_user.company.projects.find(params[:id])
  end

  def columns
    @project = current_user.company.projects.find(params[:id])
    @table   = @project.tables.find(params[:table_id])
    @columns = @table.columns.select("id, name").order("id asc")
    render json: { columns: @columns }
  end
end
