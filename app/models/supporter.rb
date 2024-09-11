class Supporter < ApplicationRecord
  belongs_to :campaign_member
  has_many :payments, dependent: :destroy
  has_many :delivery_attempts, as: :deliverable, dependent: :destroy

  before_create :set_uuid

  attr_accessor :stripe_price_id
  attr_accessor :quantity
  attr_accessor :donor_level_id

  validates :name, :email, presence: true

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
