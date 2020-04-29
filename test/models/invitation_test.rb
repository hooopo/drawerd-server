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

require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
