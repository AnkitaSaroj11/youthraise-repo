class Campaigns::ExportsController < AdminController
  before_action :set_campaign

  def index
    @exports = @campaign.campaign_exports
  end

  def create
    @export = @campaign.campaign_exports.create!(status: "Queued")
    redirect_to campaign_exports_path, notice: "Export started. Please refresh this page to see when it is finished."
    CampaignExportsJob.perform_later(@export)
  end

  private

  def set_campaign
    @campaign = current_user.admin_campaigns.find(params[:campaign_id])
    @current_campaign_member = current_user.campaign_members.find_by(campaign_id: @campaign.id)
  end
end