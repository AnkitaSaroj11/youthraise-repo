class AddDonorLevelIdToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :donor_level_id, :integer
    add_index :payments, :donor_level_id
  end
end
