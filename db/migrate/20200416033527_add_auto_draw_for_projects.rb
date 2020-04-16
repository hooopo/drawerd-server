class AddAutoDrawForProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :auto_draw, :boolean, default: false
  end
end
