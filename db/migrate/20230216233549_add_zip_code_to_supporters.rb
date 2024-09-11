class AddZipCodeToSupporters < ActiveRecord::Migration[7.0]
  def change
    add_column :supporters, :postal_code, :string
    add_index :supporters, :postal_code
  end
end
