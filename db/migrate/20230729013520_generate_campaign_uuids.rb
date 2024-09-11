class GenerateCampaignUuids < ActiveRecord::Migration[7.0]
  def up
    Campaign.all.each do |c|
      c.generate_uuid
      c.save(validate: false)
    end
  end

  def down
    Campaign.update_all(uuid: nil)
  end
end
