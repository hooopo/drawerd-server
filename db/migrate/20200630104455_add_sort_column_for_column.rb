class AddSortColumnForColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :columns, :sort, :integer, default: 0
    add_index :columns, [:table_id, :sort, :id]
  end
end
