# frozen_string_literal: true

# == Schema Information
#
# Table name: invitations
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#  invitee_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_invitations_on_company_id            (company_id)
#  index_invitations_on_company_id_and_email  (company_id,email) UNIQUE
#  index_invitations_on_invitee_id            (invitee_id)
#  index_invitations_on_token                 (token) UNIQUE
#  index_invitations_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (invitee_id => users.id)
#  fk_rails_...  (user_id => users.id)
#

class Invitation < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :invitee, class_name: "User", optional: true

  validates :email, presence: true
  validates :email, uniqueness: { scope: :company_id, message: "should be uniqueness per company" }

  before_create do
    self.token = SecureRandom.hex(32)
  end
end
