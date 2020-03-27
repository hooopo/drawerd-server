# == Schema Information
#
# Table name: relationships
#
#  id                         :bigint           not null, primary key
#  relation_table_key         :bigint           default([]), is an Array
#  relation_type(many or one) :string           default("many")
#  table_key                  :bigint           default([]), is an Array
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  relation_table_id          :bigint
#  table_id                   :bigint
#
# Indexes
#
#  index_relationships_on_relation_table_id  (relation_table_id)
#  index_relationships_on_table_id           (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (relation_table_id => tables.id)
#  fk_rails_...  (table_id => tables.id)
#

class Relationship < ApplicationRecord
  enum relation_type: [:one, :many]
  belongs_to :table
  belongs_to :relation_table, class_name: 'Table'
end
