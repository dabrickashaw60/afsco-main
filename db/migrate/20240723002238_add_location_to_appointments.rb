class AddLocationToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :location, :string
  end
end
