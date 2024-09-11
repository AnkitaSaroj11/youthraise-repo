class RethinkRoles < ActiveRecord::Migration[7.0]
  def change
    remove_index :campaign_members, :role_id
    remove_column :campaign_members, :role_id
    drop_table :roles
  end
end
