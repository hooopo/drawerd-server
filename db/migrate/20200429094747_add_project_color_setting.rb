class AddProjectColorSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :bg_color, :string
    add_column :projects, :table_header_color, :string
    add_column :projects, :table_body_color, :string
    add_column :projects, :arrow_color, :string
  end
end
