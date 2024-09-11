class PaymentCustomizationsController < ApplicationController
  skip_before_action :current_user_required
  before_action :current_payment_required
  layout "donations"

  def edit
    @payment = current_payment
  end

  def update
    @payment = current_payment
    if @payment.update(payment_params)
      redirect_to campaign_member_donations_path(@payment.campaign_member.uuid), anchor: 'wall', notice: "Thank you for your contribution"
    else
      render :edit
    end
  end

  private

  def current_payment_required
    redirect_to new_organizer_signup_path unless payment_signed_in?
  end

  def payment_params
    params.require(:payment).permit(
      :message,
      :visibility
    )
  end
end
