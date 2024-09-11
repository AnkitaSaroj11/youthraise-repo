class DropPaymentOptions < ActiveRecord::Migration[7.0]
  def change
    drop_table :payment_options
  end
end
