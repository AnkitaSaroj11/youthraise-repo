class AddUuidToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :uuid, :string
    add_index :campaigns, :uuid
  end
end
