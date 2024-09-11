class DonorLevel < ApplicationRecord
  belongs_to :campaign
  has_many :payments

  validates :amount, :description, presence: true
  validates :perk, presence: true, if: :has_perk
  validates :name, presence: true, if: :has_star

  attr_accessor :remove_perk_image

  has_one_attached :perk_image do |attachable|
    attachable.variant :profile, resize_to_limit: [300, 300]
  end

  def quantity
    amount/campaign.unit_price
  end
end
