class Campaign < ApplicationRecord
  belongs_to :organization, optional: true
  belongs_to :user
  has_many :campaign_members, dependent: :destroy
  has_many :supporters, through: :campaign_members
  has_many :roles, through: :campaign_members
  has_many :payments, through: :campaign_members
  has_many :troop_track_imports
  has_many :donor_levels
  has_many :campaign_exports
  has_many :messages
  has_many :groups
  
  has_one_attached :banner_image 

  before_create :generate_uuid
  after_create :create_default_donor_levels

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :organization

  DEFAULT_DONOR_LEVELS = [
    {
      name: "Platinum Sponsor",
      description: "Donations at this level have a profound effect on our efforts and enable us to exceed our goals",
      has_star: true,
      amount: 1000,
    },
    {
      name: "Gold Benefactor",
      description: "Everyone in our organization benefits from donations of this size",
      has_star: false,
      amount: 500
    },
    {
      name: "Silver Supporter",
      description: "Multiple kids benefit from large donations like this",
      has_star: false,
      amount: 250
    },
    {
      description: "Your above average generosity makes an above average difference",
      has_star: false,
      amount: 100
    },
    {
      description: "Average donations like this are critical to the success of our program",
      has_star: false,
      amount: 50
    },
    {
      description: "Every donation is important and appreciated!",
      has_star: false,
      amount: 35
    }
  ]

  def available_texts
    [text_limit - texts_used, 0].max
  end

  def out_of_texts?
    available_texts == 0
  end

  def texts_used
    messages.where(delivery_type: "text").sum(:texts_used)
  end

  def goal_oriented?
    display_mode == 'goal-oriented'
  end

  def sort_order_string
    if sort_order == "ascending-by-price"
      "amount asc"
    else
      "amount desc"
    end
  end

  def members
    campaign_members
  end

  def non_members
    organization.users.where.not(id: roles.pluck(:user_id))
  end

  def gross_amount_raised
    payments.sum(:amount)
  end

  def net_amount_raised
    payments.sum(:amount) * 0.9
  end

  def net_goal
    return 0 unless goal
    goal * 0.9
  end

  def member_emails
    campaign_members.map{|cm| cm.user.email}.uniq.compact
  end

  def coming_soon?
    return true unless self.start_on
    self.start_on > Date.today
  end

  def complete?
    self.end_on < Date.today
  end

  def create_stripe_price
    price = Stripe::Price.create({
      unit_amount: 500,
      currency: 'usd',
      product: stripe_product_id,
    })
    update(stripe_price_id: price[:id])
  end

  def create_stripe_product
    return unless stripe_product_id.blank?
    product = Stripe::Product.create({
      name: "#{organization.name} - #{id}",
      description: purpose,
      statement_descriptor: "YouthRaise.com"
    })
    update(stripe_product_id: product[:id])
  end

  def create_default_donor_levels
    DEFAULT_DONOR_LEVELS.each do |dl|
      self.donor_levels.create!(dl)
    end
  end

  def self_registration_qr_code_svg
    return self.self_registration_qr_code unless self_registration_qr_code.blank?
    qrcode = RQRCode::QRCode.new(
      Rails.application.routes.url_helpers.new_campaign_self_registration_url(
        self.uuid,
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
    self.update(self_registration_qr_code: svg)
    return self_registration_qr_code
  end

  def generate_uuid
    self.uuid ||= loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Campaign.exists?(uuid: random_token)
    end
  end

end
