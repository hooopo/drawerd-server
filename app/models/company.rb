# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_uuid  (uuid) UNIQUE
#

class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :projects, dependent: :destroy
end
