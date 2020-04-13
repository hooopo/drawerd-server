class AddShareKeyOnProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :share_key, :string, index: {unique: true}
  end
end