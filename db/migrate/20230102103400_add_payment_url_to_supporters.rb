class AddPaymentUrlToSupporters < ActiveRecord::Migration[7.0]
  def change
    add_column :supporters, :payment_url, :string
  end
end
