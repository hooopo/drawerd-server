# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  subdomain  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :projects, dependent: :destroy
  validates :subdomain, presence: true
  validates :subdomain,
          format: { with: /\A[a-z][a-z0-9\-]+[a-z0-9]\Z/ },
          uniqueness: true
end
