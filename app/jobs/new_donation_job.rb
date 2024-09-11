class NewDonationJob < ApplicationJob
  include ActionView::Helpers::NumberHelper

  queue_as :default

  def perform(payment)
    send_email(payment)
    send_text(payment)
  end

  private

  def send_email(payment)
    DonationMailer.with(payment: payment).new_donation_for_member.deliver_later
    DonationMailer.with(payment: payment).new_donation_for_organizer.deliver_later
  end

  def send_text(payment)
    organizer = payment.campaign.user
    member = payment.campaign_member.user

    client = Twilio::REST::Client.new(
      Rails.application.credentials.dig(:twilio, :account_sid),
      Rails.application.credentials.dig(:twilio, :auth_token)
    )
    if organizer.mobile && organizer.wants_donation_texts?
      client.messages.create(
        from: Rails.application.credentials.dig(:twilio, :phone_number),
        to: organizer.mobile,
        body: "#{member.name} just received a donation of #{number_to_currency(payment.amount)}. \
Goal progress: #{number_to_currency(payment.campaign.gross_amount_raised)}/#{number_to_currency(payment.campaign.goal)}"
      )
    end

    

    if organizer.mobile && organizer.wants_donation_texts?
      client.messages.create(
        from: Rails.application.credentials.dig(:twilio, :phone_number),
        to: member.mobile,
        body: "You just received a donation #{number_to_currency(payment.amount)} from #{payment.supporter.name}. \
Goal progress: #{number_to_currency(payment.campaign_member.amount_raised)}/#{number_to_currency(payment.campaign_member.goal)}"
      )
    end
  end
end
