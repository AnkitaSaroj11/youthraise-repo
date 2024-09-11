class CreateDefaultDonorLevels < ActiveRecord::Migration[7.0]
  def up
    Campaign.all.each do |c|
      c.create_default_donor_levels
    end
  end

  def down
    DonorLevel.destroy_all
  end
end
