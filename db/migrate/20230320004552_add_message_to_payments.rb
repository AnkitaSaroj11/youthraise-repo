class AddMessageToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :message, :text
  end
end
