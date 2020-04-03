# frozen_string_literal: true

# == Schema Information
#
# Table name: tables
#
#  id                              :bigint           not null, primary key
#  comment                         :string
#  name                            :string
#  schema                          :string           default("public")
#  table_type(table or view or mv) :string           default("table")
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  group_id                        :bigint
#  project_id                      :bigint
#
# Indexes
#
#  index_tables_on_group_id    (group_id)
#  index_tables_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (project_id => projects.id)
#

require "test_helper"

class TableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
