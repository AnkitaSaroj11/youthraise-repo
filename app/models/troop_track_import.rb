class TroopTrackImport < ApplicationRecord
  belongs_to :campaign

  before_create :get_data

  attr_accessor :user_ids
  attr_accessor :activate_members
  
  def import_users
    members = data['youth'] + data['leaders'] + data['parents']
    user_ids.each do |id|
      member_info = members.find{|m| m['id'] == id.to_i}

      member = Member.new(
        first_name: member_info["first_name"], 
        last_name: member_info["last_name"], 
        email: member_info["email"]
      )
      member.organization = campaign.organization
      if member.save
        unless campaign.campaign_members.where(user_id: member.user.id).exists?
          campaign_member = campaign.campaign_members.create!(
            role: CampaignMember::MEMBER,
            user: member.user,
            goal: campaign.individual_goal
          )
          if activate_members
            campaign_member.update!(invitation_sent_at: DateTime.now)
            CampaignMemberInvitationJob.perform_later(campaign_member)
          end
        end
      else
        raise "Couldn't save member"
      end
    end
  end

  def get_data
    uri = URI(show_trooptrack_import_url)
    response = Net::HTTP.get(uri)
    self.data = JSON.parse(response)
  end

  def show_trooptrack_import_url
    raise "Export UUID missing" if export_uuid.blank?
    "#{Rails.application.config.x.trooptrack_url}/youth_raise_exports/#{export_uuid}.json"
  end

end