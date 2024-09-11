class CampaignMember < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  belongs_to :group, optional: true
  has_many :supporters, dependent: :destroy
  has_many :payments, through: :supporters
  has_many :delivery_attempts, as: :deliverable, dependent: :destroy
  has_many :email_templates, as: :templateable, dependent: :destroy
  has_many :personal_messages, as: :messageable, dependent: :destroy

  delegate :last_name, to: :user
  delegate :first_name, to: :user
  delegate :email, to: :user
  delegate :name_or_email, to: :user
  delegate :name, to: :user
  delegate :purpose, to: :campaign
  delegate :organization_affiliation, to: :campaign
  delegate :organization, to: :campaign
  delegate :end_on, to: :campaign
  delegate :mobile, to: :user

  before_create :generate_uuid

  scope :needs_invitation, -> { where(invitation_sent_at: nil) }
  scope :invited, -> { where.not(invitation_sent_at: nil) }
  scope :with_mobile, -> { includes(:user).references(:users).where('users.mobile is not null')}

  accepts_nested_attributes_for :user
  
  ADMIN = 'admin'.freeze
  MEMBER = 'member'.freeze

  STATUSES = {
    "uninvited" => "Hasn't been sent a profile activation link",
    "pending_activation" => "Hasn't clicked on the profile activation link",
    "pending_signup" => "Hasn't created their profile yet",
    "needs_personal_message" => "Hasn't chosen a personal message",
    "edit_personal_message" => "Hasn't edited their personal message",
    "active" => "Active"
  }

  def active?
    status_key == "active"
  end

  def name_and_group
    "#{name_or_email} #{group ? "(#{group.name})" : ""}"
  end

  def admin?
    role == ADMIN
  end
  
  def invitation_valid?
    invitation_sent_at + 1.week >= DateTime.now && invitation_accepted_on.blank?
  end

  def amount_raised
    payments.sum(:amount)
  end

  def percent_complete
    (amount_raised/goal).round(0)
  end

  def struggler?
    percent_complete <= 10.0
  end

  def midway?
    percent_complete <= 50.0
  end

  def closer?
    percent_complete >= 90.0 && percent_complete < 100.0
  end

  def needs_to_edit_personal_message?
    status_key == "edit_personal_message"
  end

  def personal_message
    selected_personal_message&.message
  end

  def selected_personal_message
    personal_messages.find_by(id: selected_personal_message_id)
  end

  def needs_invitation?
    status_key == "uninvited"
  end

  def pending_activation?
    status_key == "pending_activation"
  end

  def needs_email_template?
    status_key == "needs_email_template" && email_templates.empty?
  end

  def needs_personal_message?
    status_key == "needs_personal_message" && personal_messages.empty?
  end

  def status_key
    if invitation_sent_at.blank?
      "uninvited"
    elsif invitation_accepted_on.blank?
      "pending_activation"
    elsif signup_started_on.blank?
      'pending_signup'
    elsif selected_personal_message_id.nil?
      "needs_personal_message"
    # elsif personal_message_accepted_on.blank?
    #   "edit_personal_message"
    else
      "active"
    end
  end

  def status
    STATUSES[status_key]
  end

  def deletable?
    amount_raised.zero?
  end

  def generate_personal_messages
    Bot.generate_personal_message(self)
    self.reload
    self.selected_personal_message_id = self.personal_messages.first.id
    self.personal_message_accepted_on = Date.today
    self.save!
  end

  def personal_message_prompt
    "Write a short personal message of 40 words or less by #{name_or_email}, a member of #{organization.name},
    thanking donors for supporting #{organization.name}'s fundraising effort and the good that will result. Do not include a salutation, greeting, complimentary close, or signature line." + affiliation_blurb
  end

  def affiliation_blurb
    organization_affiliation = campaign.organization.affiliation
    return "" if organization_affiliation.blank?
    "#{organization.name} is affiliated with #{organization_affiliation}. Emphasize the value of #{organization_affiliation}
    in helping prepare youth for the future."
  end


  def qr_code_svg
    return self.qr_code unless qr_code.blank?
    qrcode = RQRCode::QRCode.new(
      Rails.application.routes.url_helpers.campaign_member_donations_url(
        self.uuid,
        anchor: 'donate',
        host: Rails.application.config.action_mailer.default_url_options[:host]
      )
    )

    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true,
      viewbox: true,
    )
    self.update(qr_code: svg)
    return qr_code
  end

  def generate_uuid
    self.uuid ||= loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless CampaignMember.exists?(uuid: random_token)
    end
  end
end
