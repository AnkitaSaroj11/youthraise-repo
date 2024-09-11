class OrganizerSignupsController < ApplicationController
  skip_before_action :current_user_required, only: [:new, :create, :email_confirmation, :update_email_confirmation]
  before_action :set_campaign, except: [:new, :create, :email_confirmation, :update_email_confirmation]
  before_action :set_trooptrack, only: [:import]

  def new
    if current_user
      @campaign = current_user.campaigns.create!
      @campaign.campaign_members.create!(
        user: current_user,
        invitation_accepted_on: Date.today, 
        invitation_sent_at: DateTime.now,
        role: 'admin'
      )
      @organization = @campaign.organization || @campaign.build_organization
    else
      @user = User.new
    end
    @email_signup = params[:email_signup]
  end

  def create
    if user_params[:mobile]
      @user = User.find_or_initialize_by(mobile: user_params[:mobile])
    else
      @user = User.find_or_initialize_by(email: user_params[:email])
    end
    if @user.new_record?
      @user.attributes = user_params
    end
    if @user.save
      @login = user_params[:mobile] ? Login.new(mobile: user_params[:mobile]) : Login.new(email: user_params[:email])
      if @login.save
        if @login.user
          if @login.mobile
            @login.send_confirmation_code_text
          else
            LoginsMailer.with(login: @login).login_attempt.deliver_now
          end
        end
        redirect_to email_confirmation_organizer_signup_path(@login.uuid),
          notice: "Thanks! We've sent you #{@login.mobile ? "a text" : "an email"} with a code you can use to verify your identity."
      else
        render :new, status: :unprocessable_entity
      end

    else
      render :new, status: :unprocessable_entity
    end
  end

  def email_confirmation
    @login = Login.active.find_by(uuid: params[:id])
  end

  def update_email_confirmation
    @login = Login.active.find_by(uuid: params[:id])
    if @login.user && login_params[:confirmation_code_attempt] == @login.confirmation_code
      login(@login.user)
      campaign = current_user.campaigns.new(
        name: "My First Fundraiser"
      )
      campaign.save!
      campaign.campaign_members.create!(
        user: current_user,
        invitation_accepted_on: Date.today, 
        invitation_sent_at: DateTime.now,
        role: 'admin'
      )
      redirect_to organization_organizer_signup_path(campaign), notice: "Thank you for confirming your email address" 
    else
      render :email_confirmation, notice: "That is not the correct email confirmation code"
    end
  end

  def organization
    @organization = @campaign.organization || @campaign.build_organization
  end

  def update_organization
    if @campaign.update(organization_params)
      current_user.campaign_members.find_by(campaign_id: @campaign.id).update!(
        organization_role: campaign_member_params[:organization_role]
      )
      @campaign.create_stripe_product
      redirect_to campaign_organizer_signup_path(@campaign)
    else
      render :organization, status: :unprocessable_entity
    end
  end

  def campaign
    
  end

  def update_campaign
    if @campaign.update(campaign_params)
      @campaign.update!(name: "#{@campaign.start_on.month}/#{@campaign.start_on.year} - #{@campaign.organization.name} Fundraiser")
      current_user.campaign_members.find_by(campaign_id: @campaign.id).update!(goal: @campaign.individual_goal)
      @campaign.create_stripe_price
      redirect_to campaign_path(@campaign)
    else
      render :campaign, status: :unprocessable_entity
    end
  end

  def import
   
  end

  def trooptrack_import
    @import = @campaign.troop_track_imports.new
    @import.export_uuid = params[:export_uuid]
    @import.save!
  end

  def create_trooptrack_import
    @import = @campaign.troop_track_imports.find_by(export_uuid: trooptrack_import_params[:export_uuid])
    
    if @import.update(trooptrack_import_params)
      @import.import_users
      @campaign.save!
      redirect_to campaign_path(@campaign)
    else
      render :trooptrack_import, status: :unprocessable_entity
    end
  end

  def new_file_import
    @import = Import.new
  end

  def create_file_import
    file = params[:import][:file]
    data = CSV.parse(file.read, headers: true)
    data.each do |row|
      member = Member.new(first_name: row["first"], last_name: row["last"], email: row["email"])
      member.organization = @campaign.organization
      if member.save
        member = @campaign.campaign_members.create!(role: CampaignMember::MEMBER, goal: @campaign.individual_goal, user: member.user)
        if params[:import][:activate_members] == "1"
          member.update!(invitation_sent_at: DateTime.now)
          CampaignMemberInvitationJob.perform_later(member)
        end
      else
        raise "Couldn't save member"
      end
    end
    redirect_to campaign_path(@campaign)
  end

  private

  def set_campaign
    @campaign = current_user.campaigns.find(params[:id])
  end

  def set_trooptrack
    @trooptrack = "#{Rails.application.config.x.trooptrack_url}/youth_raise_exports/new?redirect_to=#{trooptrack_import_organizer_signup_url(@campaign)}"
  end

  def find_signup
    @signup = OrganizerSignup.find(params[:id])
  end

  def find_signup_by_uuid
    @signup = OrganizerSignup.find_by!(uuid: params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(
      :goal,
      :end_on,
      :start_on,
      :individual_goal,
      :low_option,
      :middle_option,
      :high_option
    )
  end

  def campaign_member_params
    params.require(:campaign_member).permit(
      :organization_role
    )
  end

  def organization_params
    params.require(:campaign).permit(
      :purpose,
      organization_attributes: [
        :name,
        :affiliation,
        :avatar
      ]
    )
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :mobile
    )
  end

  def login_params
    params.require(:login).permit(
      :confirmation_code_attempt
    )
  end

  def email_template_params
    params.require(:email_template).permit(
      :subject,
      :email
    )
  end

  def trooptrack_import_params
    params.require(:troop_track_import).permit(
      :export_uuid,
      user_ids: []
    )
  end

end
