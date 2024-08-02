class AddJobIdToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :job_id, :integer
  end
end
