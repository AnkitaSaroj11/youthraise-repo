class AddDeliveryTypeToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :delivery_type, :string
  end
end
