class AddInstallDatesToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :install_start_date, :date
    add_column :jobs, :install_end_date, :date
  end
end
