class AddPerkToDonorLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :donor_levels, :perk, :text
    add_column :donor_levels, :has_perk, :boolean, default: false
  end
end
