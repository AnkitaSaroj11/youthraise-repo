class AddPaidOnToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :paid_on, :date
    add_index :payments, :paid_on
  end
end
