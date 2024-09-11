class CampaignMembers::DashboardsController < ApplicationController
  before_action :current_user_required
  before_action :set_campaign_member
  
  def show
    if @campaign_member.needs_personal_message?
      @campaign_member.generate_personal_messages
    end
    if @campaign_member.needs_to_edit_personal_message?
      redirect_to edit_personal_message_campaign_member_path(@campaign_member)
    end
    if @campaign_member.pending_activation?
      @campaign_member.update!(invitation_accepted_on: Date.today)
    end
    @campaign = @campaign_member.campaign
  end

  def update
    if @campaign_member.update(campaign_member_params)
      redirect_to campaign_member_dashboard_url(@campaign_member), notice: "Update successful"
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
  
  def set_campaign_member
    @campaign_member = current_user.campaign_members.find(params[:campaign_member_id])
  end

  def email_template_params
    params.require(:email_template).permit(
      :subject,
      :email
    )
  end

  def campaign_member_params
    params.require(:campaign_member).permit(
      :goal,
      :selected_email_template_id,
      :selected_personal_message_id,
      :goal_accepted_on,
      :signup_started_on
    )
  end
end