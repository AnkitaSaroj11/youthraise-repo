module SupportersHelper
  include ActionView::Helpers::NumberHelper
  
  def mobile_supporter_message(supporter)
    campaign = supporter.campaign_member.campaign
    "Dear #{supporter.name}. As a member of #{campaign.organization.name}, #{supporter.campaign_member.name_or_email} has set a goal to raise #{number_to_currency(supporter.campaign_member.goal)} for #{campaign.name} by #{campaign.end_on.to_s}. Please consider supporting this effort. To learn more, please follow this link: #{supporter.payment_url}. This text was sent on behalf of #{supporter.name} by YouthRaise.com. If you are worried that it is not legitimate, please feel free to contact #{supporter.name} for more information. Reply STOP if you do not want to recieve any further messages."
  end
end