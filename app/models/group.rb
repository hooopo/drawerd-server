# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  color      :string
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
  belongs_to :project, touch: true
  belongs_to :user
  has_many :tables
  validates :name, presence: true
  validates :name, uniqueness: { scope: :project_id }
  validates_format_of :color,
    with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/,
    allow_blank: true,
    message: "Accept Hex color"

  def color_with_default
    color.presence || "#F7F8F9"
  end
end
