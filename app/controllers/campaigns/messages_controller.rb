class Campaigns::MessagesController < AdminController
  before_action :find_campaign
  
  def index
    @messages = @campaign.messages
  end

  def new
    @message = @campaign.messages.new(delivery_type: params[:type])
  end

  def create
    @message = @campaign.messages.new(message_params)
    @message.user = current_user
    
    if @message.save
      CampaignMessageDeliveryJob.perform_later(@message)
      redirect_to campaign_messages_path, notice: "Message created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def find_campaign
    @campaign = current_user.admin_campaigns.find(params[:campaign_id])
    @current_campaign_member = current_user.campaign_members.find_by(campaign_id: @campaign.id)
  end

  def message_params
    params.require(:message).permit(
      :subject,
      :body,
      :delivery_type,
      :send_to
    )
  end
end