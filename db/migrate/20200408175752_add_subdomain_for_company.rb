class AddSubdomainForCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :subdomain, :string, index: { unique: true }
    remove_column :companies, :name
    remove_column :companies, :uuid
  end
end
