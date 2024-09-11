class Payment < ApplicationRecord
  belongs_to :supporter
  belongs_to :campaign_member
  belongs_to :donor_level

  delegate :campaign, to: :campaign_member
  delegate :name, to: :supporter

  after_create_commit -> {
    broadcast_prepend_later_to(
      self.campaign_member, 
      :payments
    )
  }
  after_create_commit -> {
    broadcast_prepend_later_to(
      :all_payments,
      target: 'payments'
    )
  }

  after_create_commit -> {
    broadcast_prepend_later_to(
      self.campaign,
      :payments,
      target: 'payments'
    )
  }

  def masked_name_preview(visibility)
    case visibility
    when 'full'
      return name
    when 'first'
      return name.split(" ")[0]
    when 'anonymous'
      return "Anonymous"
    end
  end

  def masked_name
    case visibility
    when 'full'
      return name
    when 'first'
      return name.split(" ")[0]
    when 'anonymous'
      return "Anonymous"
    when nil
      return "Anonymous"
    end
  end

end
