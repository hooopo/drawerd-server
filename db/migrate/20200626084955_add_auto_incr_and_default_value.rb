class AddAutoIncrAndDefaultValue < ActiveRecord::Migration[5.2]
  def change
    add_column :columns, :auto_incr, :boolean, default: false
    add_column :columns, :default_value, :string
  end
end
