class CreateSqlFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :sql_files do |t|
      t.belongs_to :project, foreign_key: true, index: true
      t.belongs_to :user, foreign_key: true, index: true
      t.string :filename
      t.text :body
      t.timestamps
    end
  end
end
