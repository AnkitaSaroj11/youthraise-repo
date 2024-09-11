class Campaigns::MembersController < AdminController
  before_action :set_campaign
  
  def index
    @import = Import.new
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    @member.organization = @campaign.organization
    if @member.save
      @campaign.campaign_members.create!(role: CampaignMember::MEMBER, goal: @campaign.goal, user: @member.user)
      redirect_to campaign_path(@campaign), notice: "Member added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    member = @campaign.campaign_members.find(params[:id])
    member.destroy
    redirect_to campaign_path(@campaign), notice: "Member removed successfully"
  end

  def send_activation_email
    member = @campaign.campaign_members.find(params[:id])
    member.update!(invitation_sent_at: DateTime.now)
    CampaignMemberInvitationJob.perform_later(member)
    redirect_to campaign_path(@campaign), notice: "Sending an activation link now"
  end

  private

  def set_campaign
    @campaign = current_user.admin_campaigns.find(params[:campaign_id])
    @current_campaign_member = current_user.campaign_members.find_by(campaign_id: @campaign.id)
  end

  def member_params
    params.require(:member).permit(
      :first_name,
      :last_name,
      :email
    )
  end
end