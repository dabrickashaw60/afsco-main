class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.references :job, null: false, foreign_key: true
      t.integer :crew, null: false
      t.date :date, null: false

      t.timestamps
    end
    add_index :assignments, [:crew, :date], unique: true
  end
end
