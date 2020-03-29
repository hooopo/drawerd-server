# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_groups_on_project_id  (project_id)
#  index_groups_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#

class Group < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :tables
  validates :name, presence: true
  validates :name, uniqueness: { scope: :project_id }
end
