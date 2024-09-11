class CampaignExport < ApplicationRecord
  belongs_to :campaign
  has_one_attached :members_csv
  has_one_attached :supporters_csv
  has_one_attached :perks_due

  def build_files
    build_members_csv
    build_supporters_csv
    self.update(status: "Complete")
  end

  def build_members_csv
    self.update(status: "Exporting Members")
    members = CSV.generate do |csv|
      csv << [
        "name", 
        "email", 
        "goal", 
        "amount raised", 
        "supporters"
      ]

      campaign.campaign_members.each do |campaign_member|
        csv << [
          campaign_member.name, 
          campaign_member.email, 
          campaign_member.goal, 
          campaign_member.amount_raised,
          campaign_member.supporters.count
        ]
      end
    end

    self.members_csv.attach(io: StringIO.new(members), filename: 'members.csv')
  end

  def build_supporters_csv
    self.update(status: "Exporting Supporters")
    supporters = CSV.generate do |csv|
      csv << [
        "name", 
        "email", 
        "amount",
        "line1",
        "line2",
        "city",
        "state",
        "postal code",
        "country",
        "donor level",
        "perks"
      ]

      campaign.payments.each do |payment|
        csv << [
          payment.supporter.name, 
          payment.supporter.email, 
          payment.amount,
          payment.supporter.line1,
          payment.supporter.line2,
          payment.supporter.city,
          payment.supporter.state,
          payment.supporter.postal_code,
          payment.supporter.country,
          payment.donor_level.name,
          payment.donor_level.perk
        ]
      end
    end

    self.supporters_csv.attach(io: StringIO.new(supporters), filename: 'supporters.csv')
  end
end
