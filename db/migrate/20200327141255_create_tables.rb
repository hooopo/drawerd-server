class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.belongs_to :project, foreign_key: true, index: true
      t.string :name
      t.string :comment
      t.string :schema, default: 'public'
      t.string :table_type, default: 'table', comment: 'table or view or mv'
      t.belongs_to :group, foreign_key: true, index: true
      t.bigint :primary_keys, array: true, default: []
      t.timestamps
    end
  end
end
