class AddPkToColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :columns, :is_pk, :boolean, default: false
    remove_column :tables, :primary_keys
  end
end
