class Campaigns::ImportsController < AdminController
  before_action :set_campaign

  def create
    file = params[:import][:file]
    data = CSV.parse(file.read, headers: true)
    data.each do |row|
      @member = Member.new(first_name: row["first"], last_name: row["last"], email: row["email"])
      @member.organization = @campaign.organization
      if @member.save
        @campaign.campaign_members.create!(role: CampaignMember::MEMBER, goal: @campaign.goal)
      end
    end
    redirect_to campaign_members_path(@campaign)
  end

  private

  def set_campaign
    @campaign = current_user.admin_campaigns.find(params[:campaign_id])
    @current_campaign_member = current_user.campaign_members.find_by(campaign_id: @campaign.id)
  end
end