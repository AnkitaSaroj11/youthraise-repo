class AddStripePriceIdToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :stripe_price_id, :string
    add_index :campaigns, :stripe_price_id
  end
end
