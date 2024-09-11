class AddIndexToMessageDeliveryType < ActiveRecord::Migration[7.0]
  def change
    add_index :messages, :delivery_type
  end
end
