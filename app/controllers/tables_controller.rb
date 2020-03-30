class TablesController < ApplicationController
  layout false
  def new
    @project = current_user.company.projects.find(params[:project_id])
    @table   = @project.tables.new
  end

  def create
    @project = current_user.company.projects.find(params[:project_id])

    @project = current_user.company.projects.find(params[:project_id])
    @table   = @project.tables.new(params.fetch(:table, {}).permit(:name, :group_id, :comment))
    if @table.save
      render :js => %Q|$('#new-table').modal('toggle');$("#svg-object").attr("data", $("#svg-object").attr('data'));|
    else
      render :js => %Q|alert("#{@table.errors.full_messages.join(", ")}");|
    end

  end
end
