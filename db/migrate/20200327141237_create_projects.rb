class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :company, foreign_key: true, index: true
      t.string :adapter, default: 'postgresql', comment: 'postgresql,mysql,mssql', null: false
      t.string :name
      t.timestamps
    end
  end
end
