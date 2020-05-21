class AddExtFieldForSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :next_bill_date, :date
    remove_column :subscriptions, :trial_end_at
    add_column :subscriptions, :paddle_subscription_id, :string
  end
end
