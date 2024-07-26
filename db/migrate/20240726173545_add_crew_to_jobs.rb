class AddCrewToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :crew, :string
  end
end
