module ApplicationHelper
  ActionView::Base.default_form_builder = FormBuilders::TailwindFormBuilder

  def class_for_flash_key(key)
    case(key)
    when "danger"
      return "rounded-md bg-purple-100 p-4 mb-2"
    when "warning"
      return "rounded-md bg-red-100 p-4 mb-2"
    when "info"
      return "rounded-md bg-yellow-100 p-4 mb-2"
    when "success"
      return "rounded-md bg-green-100 p-4 mb-2"
    when "notice"
      return "rounded-md bg-green-100 p-4 mb-2"
    else
      raise key.inspect
    end
  end

  def campaign_alerts(campaign)
    alerts = []
    # if current_user.text_preferences.nil?
    #   alerts << "Please complete your text message preferences - update your #{link_to "Text Preferences", edit_text_preferences_path, class: 'text-indigo-800'} to get updates on your fundraiser progress"
    # end
    campaign_member = current_user.campaign_members.where(campaign_id: campaign.id).first
    return alerts if campaign_member.nil?

    unless campaign_member.active?
      alerts << "Please complete your #{link_to 'personal campaign dashboard', campaign_member_dashboard_path(campaign_member), class: 'text-indigo-800'} to start raising money"
    end

    alerts
  end

end
