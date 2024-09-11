class ChangeEmailIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :email
    add_index :users, :email
    add_index :users, :mobile
  end
end
