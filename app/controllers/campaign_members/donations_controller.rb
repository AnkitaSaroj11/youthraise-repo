require "htmlcsstoimage"

class CampaignMembers::DonationsController < ApplicationController
  skip_before_action :current_user_required
  before_action :set_campaign_member
  before_action :set_campaign

  layout 'donations', only: [:index, :show, :image]
  
  def index
    @social_image = image_campaign_member_donations_url(@campaign_member.uuid, format: :png)
    @supporter = @campaign_member.supporters.new
  end

  def other
    @social_image = image_campaign_member_donations_url(@campaign_member.uuid, format: :png)
    @supporter = @campaign_member.supporters.new
  end
  
  def show
    @social_image = image_campaign_member_donations_url(@campaign_member.uuid, format: :png)
    @supporter = @campaign_member.supporters.find_by(uuid: params[:id])
  end

  def image
    @disable_termly = true
    @supporter = @campaign_member.supporters.new
    respond_to do |format|
      format.html {}
      format.png {
        redirect_to image_url, status: :found, allow_other_host: true
      }
    end
  end
  
  private

  def image_url
    cache_key = "htmlcssimage/#{@campaign_member.uuid}/#{@campaign_member.updated_at}"
    cached_url = Rails.cache.read(cache_key)
  
    return cached_url if cached_url.present?
  
    client = HTMLCSSToImage.new(
      user_id: Rails.application.credentials.dig(:htmlcsstoimage, :user_id),
      api_key: Rails.application.credentials.dig(:htmlcsstoimage, :api_key)
    )

    image = client.url_to_image(
      image_campaign_member_donations_url(@campaign_member.uuid),
      viewport_width: 1200,
      viewport_height: 630,
      ms_delay: 750
    )
  
    if image.success?
      Rails.cache.write(cache_key, image.url, expires_in: 1.month)
    end
  
    image.url
  end
  
  def set_campaign_member
    @campaign_member = CampaignMember.find_by(uuid: params[:campaign_member_id])
  end

  def set_campaign
    @campaign = @campaign_member.campaign
  end
end