class DropNamesFromSupporters < ActiveRecord::Migration[7.0]
  def change
    remove_column :supporters, :last_name
    remove_column :supporters, :first_name
    add_column :supporters, :name, :string
    add_index :supporters, :name
  end
end
