class RenamePerksToDonorLevels < ActiveRecord::Migration[7.0]
  def change
    rename_table :perks, :donor_levels
  end
end
