class CorrectForeignKeyInJobs < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :jobs, :salesmen if foreign_key_exists?(:jobs, :salesmen)
    add_foreign_key :jobs, :users, column: :salesman_id
  end
end
