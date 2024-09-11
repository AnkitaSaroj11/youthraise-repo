class UsersController < ApplicationController
  
  def update
    if current_user.update(user_params)
      if params[:campaign_member_id].present?
        campaign_member = current_user.campaign_members.find(params[:campaign_member_id])
        redirect_to campaign_member_dashboard_path(campaign_member)
      else
        redirect_to root_path
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :avatar,
    )
  end

end