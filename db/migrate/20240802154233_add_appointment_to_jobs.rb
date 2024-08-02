class AddAppointmentToJobs < ActiveRecord::Migration[7.1]
  def change
    add_reference :jobs, :appointment, foreign_key: true
  end
end
