class User < ApplicationRecord
  has_many :campaigns, dependent: :destroy
  has_many :organizations, through: :campaigns
  has_many :campaign_members, dependent: :destroy
  has_many :messages
  
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [64, 64]
    attachable.variant :small, resize_to_limit: [128, 128]
  end

  validates :first_name, :last_name, presence: true

  def admin_campaigns
    campaigns.includes(:campaign_members).where(campaign_members: {role: 'admin'})
  end

  def name
    return nil if first_name.blank? && last_name.blank?
    "#{first_name} #{last_name}"
  end

  def needs_text_preferences?
    text_preferences.nil?
  end

  def name_or_email
    name || email
  end

  def wants_donation_texts?
    text_preferences && text_preferences["donations"] == "1"
  end

  def wants_member_activity_texts?
    text_preferences && text_preferences["member_activity"] == "1"
  end

  def wants_summary_texts?
    text_preferences && text_preferences["summary"] == "1"
  end

  def wants_tip_texts?
    text_preferences && text_preferences["tips"] == "1"
  end

  def is_youthraise_admin?
    youthraise_admin
  end
end
