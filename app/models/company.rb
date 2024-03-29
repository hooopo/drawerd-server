# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  subdomain  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#

class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :purchases, dependent: :destroy

  belongs_to :owner, class_name: "User"

  validates :subdomain, presence: true
  validates :subdomain, exclusion: { in: %w(www admin help wiki console), message: "%{value} is reserved." }
  validates_format_of :subdomain, with: /\A[a-z0-9_-]*?\z/, message: "accepts only letters, numbers"
  validates_uniqueness_of :subdomain

  def current_plan
    if sub = subscriptions.where(state: %w[active trial]).first
      sub.plan.to_sym
    else
      :free
    end
  end

  def free?
    current_plan == :free
  end

  def pro?
    current_plan == :pro
  end

  def enterprise?
    current_plan == :enterprise
  end
end
