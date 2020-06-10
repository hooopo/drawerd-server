class AddExportForeignKeyOnProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :export_foreign_key, :boolean, default: true
  end
end
