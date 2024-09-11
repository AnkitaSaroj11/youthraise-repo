class CampaignMembers::SupportersController < ApplicationController
  before_action :current_user_required
  before_action :set_campaign_member
  before_action :set_supporter, only: [:edit, :update, :destroy]
  
  def new
    @supporter = @campaign_member.supporters.new
  end

  def create
    @supporter = @campaign_member.supporters.new(supporter_params)
    
    if @supporter.save
      @supporter.update(payment_url: new_campaign_member_payment_url(@campaign_member.uuid, supporter_id: @supporter.uuid))
      CampaignDeliveryJob.perform_later(@supporter)
      redirect_to campaign_member_dashboard_path(@campaign_member), notice: "Supporter added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @supporter.update(supporter_params)
      redirect_to campaign_member_dashboard_path(@campaign_member.uuid), notice: "Supporter updated successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @supporter.destroy
    redirect_to campaign_member_dashboard_path(@campaign_member.uuid), notice: "Supporter deleted successfully"
  end

  private

  def set_supporter
    @supporter = @campaign_member.supporters.find(params[:id])
  end

  def set_campaign_member
    @campaign_member = current_user.campaign_members.find(params[:campaign_member_id])
  end

  def supporter_params
    params.require(:supporter).permit(:name, :mobile, :email)
  end

end