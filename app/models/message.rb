class Message < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  validates :body, :delivery_type, presence: true
  validates :subject, presence: true, unless: :text?

  SEND_TO_OPTIONS = {
    everyone: "All members who have provided a mobile number",
    strugglers: "Members who are sruggling to start (90% or more below goal)", 
    midway: "Members who are not yet half-way there (50% or more below goal)", 
    closers: "Members who are almost there (10% or less below goal)"
  }

  def text?
    delivery_type == 'text'
  end

  def text_message
    "From: #{user.name_or_email}: #{body} https://app.youthraise.com"
  end

  def campaign_members
    case(send_to)
    when 'everyone'
      campaign.campaign_members.with_mobile
    when 'strugglers'
      campaign.campaign_members.with_mobile.reject{|cm| !cm.struggler?}
    when 'midway'
      campaign.campaign_members.with_mobile.reject{|cm| !cm.midway?}
    when 'closers'
      campaign.campaign_members.with_mobile.reject{|cm| !cm.closer?}
    end
  end

end