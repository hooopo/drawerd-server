class FixRelationship < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :relation_table_key
    remove_column :relationships, :table_key

    add_column :relationships, :column_id, :bigint
    add_foreign_key :relationships, :columns, column: :column_id

    add_column :relationships, :relation_column_id, :bigint
    add_foreign_key :relationships, :columns, column: :relation_column_id
  end
end
#
#  id                         :bigint           not null, primary key
#  relation_table_key         :bigint           default([]), is an Array
#  relation_type(many or one) :string           default("many")
#  table_key                  :bigint           default([]), is an Array
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  project_id                 :bigint
#  relation_table_id          :bigint
#  table_id                   :bigint
#
# Indexes
#
#  index_relationships_on_project_id         (project_id)
#  index_relationships_on_relation_table_id  (relation_table_id)
#  index_relationships_on_table_id           (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (relation_table_id => tables.id)
#  fk_rails_...  (table_id => tables.id)