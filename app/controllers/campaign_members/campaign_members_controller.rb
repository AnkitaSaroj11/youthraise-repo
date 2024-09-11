class CampaignMembers::CampaignMembersController < ApplicationController
  skip_before_action :current_user_required, only: [:activation, :update_activation]
  before_action :set_campaign_member_from_uuid, only: [:activation, :update_activation]
  before_action :set_campaign_member, except: [:activation, :update_activation]
  
  def activation
    if @campaign_member.invitation_valid?
      login(@campaign_member.user)
      @campaign_member.update! invitation_accepted_on: Date.today
      redirect_to campaign_member_dashboard_path(@campaign_member)
    else
     redirect_to new_login_path, notice: "That link is no longer valid"
    end
  end

  def edit_personal_message
    @personal_message = @campaign_member.selected_personal_message
    @personal_message.message = @personal_message.body if @personal_message.message.blank?
    @campaign = @campaign_member.campaign
  end
  
  def update_personal_message
    @personal_message = @campaign_member.selected_personal_message
    if @personal_message.update(personal_message_params)
      @campaign_member.update(selected_personal_message_id: @personal_message.id, personal_message_accepted_on: Date.today)
      redirect_to campaign_member_dashboard_path(@campaign_member)
    else
      render :edit_personal_message, status: :unprocessable_entity
    end
  end

  private
  
  def set_campaign_member_from_uuid
    @campaign_member = CampaignMember.find_by(uuid: params[:id])
  end

  def set_campaign_member
    @campaign_member = CampaignMember.find(params[:id])
  end

  def email_template_params
    params.require(:email_template).permit(
      :subject,
      :email
    )
  end

  def personal_message_params
    params.require(:personal_message).permit(
      :message
    )
  end

end