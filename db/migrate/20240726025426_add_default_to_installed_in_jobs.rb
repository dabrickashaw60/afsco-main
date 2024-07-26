class AddDefaultToInstalledInJobs < ActiveRecord::Migration[7.1]
  def change
    change_column_default :jobs, :installed, from: nil, to: false
  end
end
