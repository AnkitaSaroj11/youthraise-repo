class CampaignMembersController < AdminController
  before_action :find_campaign_member
  def edit
    
  end

  def update
    if @campaign_member.update(campaign_member_params)
      redirect_to @campaign
    else
      render :edit
    end
  end

  private

  def campaign_member_params
    params.require(:campaign_member).permit(
      :role,
      user_attributes: [
        :id,
        :first_name,
        :last_name,
        :email,
        :mobile
      ]
    )
  end

  def find_campaign_member
    @campaign = current_user.campaigns.find(params[:campaign_id])
    @campaign_member = @campaign.campaign_members.find(params[:id])
  end
end