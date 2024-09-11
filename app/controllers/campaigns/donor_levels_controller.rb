class Campaigns::DonorLevelsController < AdminController
  before_action :set_campaign

  def index
    @donor_levels = @campaign.donor_levels.order(@campaign.sort_order_string)
  end

  def new
    @donor_level = @campaign.donor_levels.new
  end

  def create
    @donor_level = @campaign.donor_levels.new(donor_level_params)
    if @donor_level.save
      redirect_to campaign_donor_level_path, notice: "Perk saved"
    else
      render :new
    end
  end

  def edit
    @donor_level = @campaign.donor_levels.find(params[:id])
  end

  def update
    @donor_level = @campaign.donor_levels.find(params[:id])
    if @donor_level.update(donor_level_params)
      if donor_level_params[:remove_perk_image] == "1" && @donor_level.perk_image.present?
        @donor_level.perk_image.purge
      end
      redirect_to campaign_donor_levels_path, notice: "Perk saved"
    else
      render :new
    end
  end

  def destroy
    @donor_level = @campaign.donor_levels.find(params[:id])
    @donor_level.destroy
    redirect_to campaign_donor_levels_path, notice: "Perk deleted"
  end
  private

  def donor_level_params
    params.require(:donor_level).permit(
      :name,
      :amount,
      :description,
      :perk_image,
      :perk,
      :has_perk,
      :remove_perk_image
    )
  end

  def set_campaign
    @campaign = current_user.admin_campaigns.find(params[:campaign_id])
    @current_campaign_member = current_user.campaign_members.find_by(campaign_id: @campaign.id)
  end

end