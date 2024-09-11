class Campaigns::GroupsController < AdminController
  before_action :find_campaign
  before_action :find_group, only: [:edit, :update]

  def index
    @groups = @campaign.groups
  end

  def edit

  end

  def update
    if @group.update(group_params)
      redirect_to campaign_groups_path(@campaign)
    else
      render :edit
    end
  end

  def new
    @group = @campaign.groups.new
  end

  def create
    @group = @campaign.groups.new(group_params)
    if @group.save
      redirect_to campaign_groups_path(@campaign)
    else
      render :new
    end
  end

  def destroy
    @group.destroy
  end

  private

  def find_campaign
    @campaign = current_user.campaigns.find(params[:campaign_id])
    @current_campaign_member = current_user.campaign_members.find_by(campaign_id: @campaign.id)
  end

  def find_group
    @group = @campaign.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :goal, campaign_member_ids: [])
  end
end