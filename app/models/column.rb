# == Schema Information
#
# Table name: columns
#
#  id         :bigint           not null, primary key
#  comment    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  table_id   :bigint
#
# Indexes
#
#  index_columns_on_table_id  (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (table_id => tables.id)
#

class Column < ApplicationRecord
end
