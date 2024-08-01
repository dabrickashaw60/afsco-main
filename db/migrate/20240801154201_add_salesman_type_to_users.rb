class AddSalesmanTypeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :salesman_type, :string
  end
end
