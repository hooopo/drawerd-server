class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.belongs_to :company, foreign_key: true, index: true
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :subscription, foreign_key: true, index: true
      t.date :next_bill_date
      t.string :paddle_subscription_id
      t.string :payment_method
      t.jsonb :event_data
      t.timestamps
    end
  end
end
