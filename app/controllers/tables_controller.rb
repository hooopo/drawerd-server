class TablesController < ApplicationController
  def new
    @project = current_user.company.projects.find(params[:project_id])
    @table   = @project.tables.new
  end
end
