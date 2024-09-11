class OrganizationsController < AdminController

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save?
      redirect_to organizations_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
  end

  def show
    @organization = current_user.admin_organizations.find(params[:id])
    @campaigns = @organization.campaigns
    @members = @organization.members
  end

  def edit
  end

  def update

  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
