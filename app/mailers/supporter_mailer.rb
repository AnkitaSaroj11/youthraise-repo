class SupporterMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  def contribute_email
    @supporter = params[:supporter]
    @campaign_member = @supporter.campaign_member
    @campaign = @supporter.campaign_member.campaign

    mail(
      to: @supporter.email, 
      subject: "Please help #{@campaign_member.name_or_email} raise #{number_to_currency(@campaign_member.goal)} for #{@campaign.organization.name}"
    )
  end
end
