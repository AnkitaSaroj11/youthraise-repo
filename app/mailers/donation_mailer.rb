class DonationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.donation_mailer.new_donation_for_member.subject
  #
  def new_donation_for_member
    @payment = params[:payment]
    @campaign_member = @payment.campaign_member
    @campaign = @payment.campaign
    
    mail to: @campaign_member.email, subject: "New Donation Alert!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.donation_mailer.new_donation_for_organizer.subject
  #
  def new_donation_for_organizer
    @payment = params[:payment]
    @campaign = @payment.campaign
    @organizer = @campaign.user
    @campaign_member = @payment.campaign_member

    mail to: @organizer.email, subject: "New Donation Alert!"
  end
end
