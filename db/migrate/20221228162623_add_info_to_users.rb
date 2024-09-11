class AddInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_name, :string
    add_index :users, :last_name
    add_column :users, :first_name, :string
    add_index :users, :first_name
    add_column :users, :mobile, :string
  end
end
