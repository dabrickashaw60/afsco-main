class AddInstallDateAndInstalledToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :install_date, :date
    add_column :jobs, :installed, :boolean
  end
end
