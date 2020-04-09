class AddOwnerForCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :owner_id, :bigint, index: true
    add_foreign_key :companies, :users, column: :owner_id
  end
end
