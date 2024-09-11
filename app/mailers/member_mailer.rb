class MemberMailer < ApplicationMailer

  def create_your_profile
    @campaign_member = params[:campaign_member]
    
    @campaign = @campaign_member.campaign
    @campaign_organizer = @campaign.campaign_members.find_by(user_id: @campaign.user.id)
    mail to: @campaign_member.email, 
      subject: "Please support the #{@campaign.organization.name} fundraiser starting #{@campaign.start_on}",
      from: "#{@campaign.user.name_or_email} via YouthRaise.com <noreply@youthraise.com>"
  end

  def campaign_message
    @message = params[:message]

    mail bcc: @message.campaign.member_emails,
      subject: @message.subject,
      from: "#{@message.user.name_or_email} via YouthRaise.com <noreply@youthraise.com>"
  end

end
