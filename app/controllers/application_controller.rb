class ApplicationController < ActionController::Base
  include Authentication

  before_action :current_user_required
  
  private

  def current_user_required
    redirect_to new_organizer_signup_path unless user_signed_in?
  end

  def current_campaign_member_path
    if current_user.campaign_members.empty?
      root_path
    elsif @campaign
      campaign_member_dashboard_path(current_user.campaign_members.find_by(user_id: current_user.id))
    else
      campaign_member_dashboard_path(current_user.campaign_members.last)
    end
  end

  def landing_page_path
    active_campaign_member = current_user.campaign_members.invited.includes(:campaign).references(:campaigns).where(
      'personal_message_accepted_on is NULL AND campaigns.end_on >= ?', Date.today).first
    if active_campaign_member.nil?
      root_path
    else
      campaign_member_dashboard_path(active_campaign_member)
    end
  end
end
