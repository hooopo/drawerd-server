# frozen_string_literal: true

# == Schema Information
#
# Table name: columns
#
#  id            :bigint           not null, primary key
#  auto_incr     :boolean          default(FALSE)
#  column_type   :string           default("string")
#  comment       :string
#  default_value :string
#  is_pk         :boolean          default(FALSE)
#  name          :string
#  nullable      :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  table_id      :bigint
#
# Indexes
#
#  index_columns_on_table_id  (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (table_id => tables.id)
#

require "test_helper"

class ColumnTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
