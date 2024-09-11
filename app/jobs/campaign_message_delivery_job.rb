class CampaignMessageDeliveryJob < ApplicationJob
  queue_as :default

  def perform(message)
    if message.text?
      MemberTexter.send_member_message(message)
    else
      MemberMailer.with(message: message).campaign_message.deliver_later
    end
    message.update(sent_on: Date.current)
  end
end
