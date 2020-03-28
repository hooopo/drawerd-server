# == Schema Information
#
# Table name: projects
#
#  id                              :bigint           not null, primary key
#  adapter(postgresql,mysql,mssql) :string           default("postgresql"), not null
#  name                            :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  company_id                      :bigint
#  user_id                         :bigint
#
# Indexes
#
#  index_projects_on_company_id  (company_id)
#  index_projects_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#

class Project < ApplicationRecord
  enum adapter: %w[postgresql mysql mssql].map { |name| [name, name] }.to_h
  validates :name, presence: true
  belongs_to :user
  belongs_to :company
  has_many :tables
  has_many :groups
end
