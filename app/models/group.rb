class Group < ApplicationRecord
  belongs_to :campaign
  has_many :campaign_members, dependent: :nullify
  has_many :users, through: :campaign_members

  validates :name, presence: true

  attr_accessor :free

  def amount_raised
    @amount_raised ||= campaign_members.map{|cm| cm.amount_raised}.sum
  end

  def registration_qr_code_svg
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
end
