class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.belongs_to :project, foreign_key: true, index: true
      t.belongs_to :user, foreign_key: true, index: true
      t.string :name
      t.timestamps
    end
  end
end
