class CampaignMembers::PaymentsController < ApplicationController
  skip_before_action :current_user_required
  before_action :set_campaign_member
  
  def new
    if params[:supporter_id].present?
      @supporter = @campaign_member.supporters.find(params[:supporter_id])
      @supporter.stripe_price_id = params[:stripe_price_id]
    else
      @supporter = @campaign_member.supporters.new(stripe_price_id: params[:stripe_price_id])
    end
  end

  def create
    quantity = supporter_params['quantity']&.to_i || 1
    if params[:supporter][:uuid].present?
      @supporter = @campaign_member.supporters.find_by!(uuid: params[:supporter][:uuid])
      @supporter.assign_attributes(supporter_params)
    else
      @supporter = @campaign_member.supporters.new(supporter_params)
    end
    @supporter.save(validate: false)
    
    url = Rails.application.credentials.dig(:stripe, :url)
    session = Stripe::Checkout::Session.create({
      shipping_address_collection: {allowed_countries: ['US']},
      line_items: [{
        price: @campaign_member.campaign.stripe_price_id,
        quantity: quantity,
      }],
      customer_email: @supporter.email,
      mode: 'payment',
      success_url: success_campaign_member_payment_url(@campaign_member.uuid, @supporter, donor_level_id: params[:supporter][:donor_level_id]),
      cancel_url:  campaign_member_donations_url(@campaign_member.uuid)
    })

    @supporter.stripe_session_id = session.id
    @supporter.save(validate: false)
    
    redirect_to session.url, allow_other_host: true, status: 303
  end

  def success
    @supporter = @campaign_member.supporters.find(params[:id])
    stripe_session = Stripe::Checkout::Session.retrieve(@supporter.stripe_session_id)
    @supporter.name = stripe_session.customer_details.name
    @supporter.email = stripe_session.customer_details.email
    @supporter.postal_code = stripe_session.customer_details.address.postal_code
    @supporter.line1 = stripe_session.customer_details.address.line1
    @supporter.line2 = stripe_session.customer_details.address.line2
    @supporter.city = stripe_session.customer_details.address.city
    @supporter.state = stripe_session.customer_details.address.state
    @supporter.country = stripe_session.customer_details.address.country
    @supporter.save!
    
    payment = @supporter.payments.create!(
      amount: stripe_session.amount_total/100.0,
      campaign_member: @campaign_member,
      paid_on: Date.today,
      donor_level_id: params[:donor_level_id]
    )

    NewDonationJob.perform_later(payment)
    login_payment(payment)
    redirect_to edit_payment_customization_path, notice: "Thank you for your contribution"
  end

  private

  def amount_from_stripe_price_id(stripe_price_id)
    @campaign_member.payment_options.find_by(stripe_price_id: stripe_price_id).amount
  end
  
  def set_campaign_member
    @campaign_member = CampaignMember.find_by(uuid: params[:campaign_member_id])
  end

  def supporter_params
    params.require(:supporter).permit(
      :first_name, 
      :last_name, 
      :stripe_price_id, 
      :email, 
      :mobile, 
      :visibility,
      :quantity
    )
  end

  def product
    # This logic will need to become a lookup on the fundraiser - we will have a separate product in Stripe for every fundraiser
    'prod_N5IUBSj1MlrQFx'
  end
end