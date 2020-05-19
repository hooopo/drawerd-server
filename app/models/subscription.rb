# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id           :bigint           not null, primary key
#  event_data   :jsonb
#  plan         :string           default("free")
#  plan_cycle   :string           default("monthly")
#  start_at     :datetime
#  state        :string           default("trial")
#  trial_end_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_subscriptions_on_company_id  (company_id)
#  index_subscriptions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :company
  enum plan_cycle: %w[monthly yearly].map { |name| [name, name] }.to_h
  enum state: %w[trial active refunded cancelled].map { |name| [name, name] }.to_h
end
