class AddImportSqlDataToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :import_sql_data, :jsonb
  end
end
