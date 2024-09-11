class MemberTexter
  def self.send_member_message(message)
    user = message.user

    sns = Aws::SNS::Client.new(
      region: 'us-east-1', 
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id), 
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )
    recipients = message.campaign_members
    recipients.each do |campaign_member|
      sns.publish(
        phone_number: "+1#{campaign_member.mobile}", 
        message: message.text_message
      )
    end
    message.update!(texts_used: recipients.count)
  end
end