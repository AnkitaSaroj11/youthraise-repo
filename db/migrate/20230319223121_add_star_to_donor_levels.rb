class AddStarToDonorLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :donor_levels, :has_star, :boolean, default: false
  end
end
