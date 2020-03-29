class AddColumnType < ActiveRecord::Migration[5.2]
  def change
    add_column :columns, :column_type, :string, default: 'string'
  end
end
