# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id                     :bigint           not null, primary key
#  event_data             :jsonb
#  next_bill_date         :date
#  payment_method         :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#  paddle_subscription_id :string
#  subscription_id        :bigint
#  user_id                :bigint
#
# Indexes
#
#  index_purchases_on_company_id       (company_id)
#  index_purchases_on_subscription_id  (subscription_id)
#  index_purchases_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (subscription_id => subscriptions.id)
#  fk_rails_...  (user_id => users.id)
#

class Purchase < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  belongs_to :company
end
