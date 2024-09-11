class AddAddressToSupporters < ActiveRecord::Migration[7.0]
  def change
    add_column :supporters, :line1, :string
    add_column :supporters, :line2, :string
    add_column :supporters, :city, :string
    add_column :supporters, :state, :string
    add_column :supporters, :country, :string
  end
end
