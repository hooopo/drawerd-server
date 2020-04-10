# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :redirect_to_subdomain
  layout false

  def new
    @project = current_user.company.projects.find(params[:project_id])
    @relationship = @project.relationships.new
  end

  def edit
    @project = current_user.company.projects.find(params[:project_id])
    @relationship = @project.relationships.find(params[:id])
  end

  def update
    @project = current_user.company.projects.find(params[:project_id])
    @relationship = @project.relationships.find(params[:id])
    if @relationship.update(rel_params)
      render js: %Q|$('#edit-relationship').modal('toggle');$("#svg-object").attr("data", $("#svg-object").attr('data'));|
    else
      render js: %Q|alert("#{@relationship.errors.full_messages.join(", ")}");|
    end
  end

  def destroy
    @project = current_user.company.projects.find(params[:project_id])
    @relationship = @project.relationships.find(params[:id])
    @relationship.destroy
    render js: %Q|$('#edit-relationship').modal('toggle');$("#svg-object").attr("data", $("#svg-object").attr('data'));|
  end

  def create
    @project = current_user.company.projects.find(params[:project_id])
    @relationship = @project.relationships.new(rel_params)
    if @relationship.save
      render js: %Q|$('#new-relationship').modal('toggle');$("#svg-object").attr("data", $("#svg-object").attr('data'));|
    else
      render js: %Q|alert("#{@relationship.errors.full_messages.join(", ")}");|
    end
  end

  def rel_params
    params.require(:relationship).permit(:table_id, :column_id, :relation_table_id, :relation_column_id, :relation_type)
  end
end
