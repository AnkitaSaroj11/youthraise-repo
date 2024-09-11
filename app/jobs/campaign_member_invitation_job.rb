class CampaignMemberInvitationJob < ApplicationJob
  queue_as :default

  def perform(campaign_member)
    return unless campaign_member.invitation_accepted_on.blank?
    
    MemberMailer.with(campaign_member: campaign_member).create_your_profile.deliver_later
    campaign_member.update! invitation_sent_at: DateTime.now
    
    campaign_member.delivery_attempts.create!(email_status: "queued")
    unless campaign_member.delivery_attempts.count >= 5
      CampaignDeliveryJob.set(wait: 2.days).perform_later(campaign_member)
    end
  end
end
