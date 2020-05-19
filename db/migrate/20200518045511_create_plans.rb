class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :company, foreign_key: true, index: true
      t.belongs_to :user, foreign_key: true, index: true
      t.string :plan, default: 'free'
      t.string :plan_cycle, default: 'monthly'
      t.string :state, default: 'trial'
      t.datetime :start_at
      t.datetime :trial_end_at
      t.jsonb :event_data
      t.timestamps
    end
  end
end
