class AddTextLimitToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :text_limit, :integer, null: false, default: 500
  end
end
