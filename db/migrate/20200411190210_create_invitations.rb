class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.belongs_to :company, foreign_key: true, index: true
      t.belongs_to :user, foreign_key: true, index: true
      t.string :email, null: false
      t.belongs_to :invitee, foreign_key: {to_table: :users}
      t.string :token, index: {unique: true}
      t.timestamps
      t.index [:company_id, :email], unique: true
    end
  end
end
