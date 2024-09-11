class TextPreferencesController < ApplicationController
  
  def edit

  end

  def update
    current_user.text_preferences = text_preferences_params
    if current_user.save && current_user.update(user_params)
      redirect_to current_campaign_member_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :mobile,
    )
  end

  def text_preferences_params
    params.require(:text_preferences).permit(
      :donations,
      :member_activity,
      :summary,
      :tips
    )
  end

end