class Organizations::MembersController < AdminController
  before_action :set_organization
  before_action :set_member, only: %i[ show edit update destroy ]
  
  def index
    @members = @organization.members
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    @member.organization = @organization
    if @member.save
      redirect_to organization_members_url(@organization), notice: "Member was successfully created."
    else
      render :new, status: :unprocessable_entity 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = @organization.members.find(params[:id])
    end

    def set_organization
      @organization = current_user.admin_organizations.find(params[:organization_id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :email, :mobile)
    end
end
