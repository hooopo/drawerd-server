class AddCsvColumnForProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :table_csv_data, :jsonb
    add_column :projects, :relation_csv_data, :jsonb
  end
end
