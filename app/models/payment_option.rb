class PaymentOption < ApplicationRecord
  belongs_to :campaign

  # validates :amount, numericality: { greater_than_or_equal_to: 5, only_integer: true }, allow_nil: true

  def create_stripe_price
    price = Stripe::Price.create({
      unit_amount: amount * 100,
      currency: 'usd',
      product: campaign.stripe_product_id,
    })
    update(stripe_price_id: price[:id])
  end
end
