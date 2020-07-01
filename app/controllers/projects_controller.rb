# frozen_string_literal: true

require_relative "../../lib/sql_exporter"

class ProjectsController < ApplicationController
  before_action :redirect_to_subdomain
  skip_before_action :authenticate_user!, only: [:render_svg]

  def index
    @projects = current_user.company.projects.order("id desc")
  end

  def new
    @project = current_user.projects.new
  end

  def edit
    @project = current_company.projects.find(params[:id])
  end

  def update
    @project = current_company.projects.find(params[:id])
    if @project.update(project_update_params)
      redirect_to project_path(@project)
    else
      flash.now[:notice] = "fail"
      render :edit
    end
  end

  def create
    @project = current_user.projects.new(project_create_params)
    @project.company = current_user.company
    if @project.save
      redirect_to project_path(@project)
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

  def render_sql
    @project = current_company.projects.includes({ tables: [:columns, :group], relationships: [:column, :relation_column] }).find(params[:id])
    ddl_file = SqlExporter.new(@project).ddl_file
    send_file ddl_file, filename: "#{@project.name}.sql"
  end

  def show
    @project = current_user.company.projects.find(params[:id])
  end

  def columns
    @project = current_user.company.projects.find(params[:id])
    @table   = @project.tables.find(params[:table_id])
    @columns = @table.columns.order("sort asc, id asc").select("id, name").order("id asc")
    render json: { columns: @columns }
  end

  def docs
    @project = current_company.projects.includes({ tables: [:columns, :group], relationships: [:column, :relation_column] }).find(params[:id])
    @tables = @project.tables
    @tables = if params[:group_id].present?
      @tables.where(group_id: params[:group_id])
    else
      @tables
    end

    @tables = @tables.group_by { |t| t.group }.map do |group, tables|
      tables.sort { |t| t.id }
    end.flatten
  end

  def project_update_params
    params.fetch(:project, {}).permit(:bg_color, :table_header_color, :table_body_color, :arrow_color, :export_foreign_key)
  end

  def project_create_params
    params.fetch(:project, {}).permit(:name, :adapter, :table_csv, :relation_csv, :auto_draw)
  end
end
