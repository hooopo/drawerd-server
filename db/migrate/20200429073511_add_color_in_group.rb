class AddColorInGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :color, :string
  end
end
