class CampaignDeliveryJob < ApplicationJob
  include SupportersHelper
  queue_as :default

  def perform(supporter)
    return unless supporter.payments.empty?
    return if supporter.delivery_attempts.count >= 5
    SupporterMailer.with(supporter: supporter).contribute_email.deliver_later
    
    supporter.delivery_attempts.create!(email_status: "queued")
    unless supporter.delivery_attempts.count >= 5
      CampaignDeliveryJob.set(wait: 2.days).perform_later(supporter)
    end
  end
end
