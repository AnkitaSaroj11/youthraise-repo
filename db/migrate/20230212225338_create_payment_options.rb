class CreatePaymentOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_options do |t|
      t.integer :campaign_id
      t.integer :amount
      t.string :stripe_price_id

      t.timestamps
    end
    add_column :campaigns, :stripe_product_id, :string
    add_index :campaigns, :stripe_product_id
    add_index :payment_options, :campaign_id
    add_index :payment_options, :amount
    add_index :payment_options, :stripe_price_id
    add_column :organizer_signups, :payment_options, :json
  end
end
