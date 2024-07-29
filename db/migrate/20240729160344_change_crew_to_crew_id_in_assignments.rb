class ChangeCrewToCrewIdInAssignments < ActiveRecord::Migration[7.1]
  def change
    rename_column :assignments, :crew, :crew_id
    change_column :assignments, :crew_id, :bigint, null: false
    add_foreign_key :assignments, :crews
  end
end
