class ProfilesController < ApplicationController
  before_action :current_user_required

  def edit
    
  end

  def update
    if current_user.update(user_params)
      redirect_to landing_page_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :avatar,
      :first_name,
      :last_name,
      :email,
      :mobile,
      :accepts_texts_from_youthraise
    )
  end

end