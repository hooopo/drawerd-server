# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :redirect_to_subdomain

  layout false
  def new
    @project = current_user.company.projects.find(params[:project_id])
    @group   = @project.groups.new
  end

  def edit
    @project = current_user.company.projects.find(params[:project_id])
    @group   = @project.groups.find(params[:id])
  end

  def update
    @project = current_user.company.projects.find(params[:project_id])
    @group   = @project.groups.find(params[:id])
    if @group.update(params.fetch(:group, {}).permit(:name, :color))
      render js: %Q|$('#edit-group').modal('toggle');window.location.reload();|
    else
      render js: %Q|alert("#{@group.errors.full_messages.join(", ")}");|
    end
  end

  def create
    @project = current_user.company.projects.find(params[:project_id])
    @group   = @project.groups.new(params.fetch(:group, {}).permit(:name, :color))
    @group.user = current_user
    if @group.save
      render js: "$('#new-group').modal('toggle');window.location.reload();"
    else
      render js: %Q|alert("#{@group.errors.full_messages.join(", ")}");|
    end
  end

  def destroy
    @project = current_user.company.projects.find(params[:project_id])
    @project.groups.find(params[:id]).destroy
  end
end
