class CreateCrews < ActiveRecord::Migration[7.1]
  def change
    create_table :crews do |t|
      t.string :name
      t.integer :foreman_id
      t.integer :laborer1_id
      t.integer :laborer2_id

      t.timestamps
    end
    add_foreign_key :crews, :users, column: :foreman_id
    add_foreign_key :crews, :users, column: :laborer1_id
    add_foreign_key :crews, :users, column: :laborer2_id
  end
end
