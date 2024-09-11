class AddFieldsToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :sort_order, :string, default: 'ascending-by-price'
    add_column :campaigns, :unit_price, :integer, default: 5
    add_column :campaigns, :display_mode, :string, default: 'goal-oriented'
    add_index :campaigns, :unit_price
  end
end
