class Campaigns::SelfRegistrationsController < ApplicationController
  skip_before_action :current_user_required
  before_action :find_campaign
  def new
    @member = Member.new
    @email_signup = params[:email_signup]
  end

  def create
    @member = Member.new(member_params)
    @member.organization = @campaign.organization
    if @member.save
      campaign_member = @campaign.campaign_members.create!(invitation_sent_at: DateTime.now, role: CampaignMember::MEMBER, goal: @campaign.individual_goal, user: @member.user)
      @login = Login.new(email: @member.email, mobile: @member.mobile)
      if @login.save
        if @login.user
          if @login.mobile
            @login.send_confirmation_code_text
          else
            LoginsMailer.with(login: @login).login_attempt.deliver_now
          end
        end
        redirect_to edit_login_path(@login.uuid)
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def find_campaign
    @campaign = Campaign.find_by!(uuid: params[:campaign_id])
  end

  def member_params
    params.require(:member).permit(
      :first_name,
      :last_name,
      :email,
      :mobile,
      :accept_text_messages
    )
  end
end