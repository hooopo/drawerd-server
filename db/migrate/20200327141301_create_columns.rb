class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.belongs_to :table, foreign_key: true, index: true
      t.string :name
      t.string :comment
      t.boolean :nullable, default: true
      t.timestamps
    end
  end
end
