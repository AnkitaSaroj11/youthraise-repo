class CampaignsController < AdminController
  before_action :set_campaign, only: %i[ show edit update destroy ]
  before_action :set_trooptrack, :campaign_members, only: :show

  def index
    @campaigns = current_user.campaigns.all
  end

  def show
    
  end

  def new
    @campaign = @organization.campaigns.new
  end

  def edit
  end

  def create
    @campaign = @organization.campaigns.new(campaign_params)
    @campaign.user = current_user

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to organization_campaign_url(@organization, @campaign), notice: "Campaign was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to campaign_path(@campaign), notice: "Campaign was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = current_user.campaigns.find(params[:id])
      @current_campaign_member = current_user.campaign_members.find_by(campaign_id: @campaign.id)
    end

    # Only allow a list of trusted parameters through.
    def campaign_params
      params.require(:campaign).permit(
        :goal, :name, :purpose, :start_on, :end_on, :banner_image, :display_mode, :unit_price, :individual_goal
      )
    end

    def set_trooptrack
      @trooptrack = "#{Rails.application.config.x.trooptrack_url}/youth_raise_exports/new?redirect_to=#{trooptrack_import_organizer_signup_url(@campaign)}"
    end

    def campaign_members
      @campaign_members = @campaign.campaign_members.includes(:user).references(:user).order('users.last_name asc')
    end
end
