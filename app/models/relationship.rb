# frozen_string_literal: true

# == Schema Information
#
# Table name: relationships
#
#  id                         :bigint           not null, primary key
#  relation_type(many or one) :string           default("many")
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  column_id                  :bigint
#  project_id                 :bigint
#  relation_column_id         :bigint
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
#  fk_rails_...  (column_id => columns.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (relation_column_id => columns.id)
#  fk_rails_...  (relation_table_id => tables.id)
#  fk_rails_...  (table_id => tables.id)
#

class Relationship < ApplicationRecord
  enum relation_type: %w[many one m2m].map { |name| [name, name] }.to_h
  belongs_to :table, touch: true
  belongs_to :column, optional: true

  belongs_to :relation_table, class_name: "Table"
  belongs_to :relation_column, class_name: "Column", optional: true

  belongs_to :project, touch: true

  def virtual?
    not (column && relation_column)
  end

  def to_dbml_ref
    return if virtual?
    return "Ref: #{[relation_table_desc, table_desc].join(" > ")}" if many?
    return "Ref: #{[table_desc, relation_table_desc].join(" - ")}" if one?
  end

  def table_desc
    [table.name, column.name].join(".")
  end

  def relation_table_desc
    [relation_table.name, relation_column.name].join(".")
  end
end
