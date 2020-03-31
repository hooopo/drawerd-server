class TablesController < ApplicationController
  layout false
  def new
    @project = current_user.company.projects.find(params[:project_id])
    @table   = @project.tables.new
  end

  def create
    @project = current_user.company.projects.find(params[:project_id])

    @project = current_user.company.projects.find(params[:project_id])
    @table   = @project.tables.new(table_params)
    if @table.save
      render :js => %Q|$('#new-table').modal('toggle');$("#svg-object").attr("data", $("#svg-object").attr('data'));|
    else
      render :js => %Q|alert("#{@table.errors.full_messages.join(", ")}");|
    end

  end

  def table_params
    params.require(:table).permit(:name, :comment, :group_id, columns_attributes: [:id, :name, :nullable, :column_type, :_destroy])
  end
end
