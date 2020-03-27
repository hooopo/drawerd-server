class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.belongs_to :company, foreign_key: true, index: true
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end
