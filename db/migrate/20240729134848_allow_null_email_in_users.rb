class AllowNullEmailInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :email, true
    remove_index :users, :email if index_exists?(:users, :email)
    add_index :users, :email, unique: true, where: 'email IS NOT NULL'
  end
end
