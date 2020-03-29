class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.belongs_to :project, foreign_key: true, index: true
      t.belongs_to :table, foreign_key: true
      t.belongs_to :relation_table, foreign_key: {to_table: 'tables'}
      t.string :relation_type, default: 'many', comment: 'many or one'
      t.bigint :table_key, array: true, default: [] # id
      t.bigint :relation_table_key, array: true, default: [] #xxx_id
      t.timestamps
    end
  end
end
