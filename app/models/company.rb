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

  belongs_to :owner, class_name: "User"

  validates :subdomain, presence: true
  validates :subdomain, exclusion: { in: %w(www admin help wiki console), message: "%{value} is reserved." }
  validates_format_of :subdomain, with: /\A[a-zA-Z0-9_-]*?\z/, message: "accepts only letters, numbers"
  validates_uniqueness_of :subdomain
end
