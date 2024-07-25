class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :job_number
      t.references :salesman, null: false, foreign_key: true
      t.string :customer_name
      t.text :address
      t.string :customer_phone
      t.string :customer_email
      t.decimal :total_amount
      t.string :type_of_work

      t.timestamps
    end
  end
end
