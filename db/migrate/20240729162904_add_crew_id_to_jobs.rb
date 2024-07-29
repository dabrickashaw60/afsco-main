class AddCrewIdToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :crew_id, :integer
  end
end
