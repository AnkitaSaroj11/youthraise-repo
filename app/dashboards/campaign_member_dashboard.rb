require "administrate/base_dashboard"

class CampaignMemberDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    status: Field::String.with_options(
      searchable: false
    ),
    actuals: Field::Number,
    campaign: Field::BelongsTo,
    delivery_attempts: Field::HasMany,
    amount_raised: Field::Number.with_options(
      prefix: "$",
      decimals: 0
    ),
    goal: Field::Number.with_options(
      prefix: "$",
      decimals: 0
    ),
    goal_accepted_on: Field::Date,
    invitation_accepted_on: Field::Date,
    invitation_sent_at: Field::DateTime,
    organization_role: Field::String,
    payments: Field::HasMany,
    personal_message: Field::Text,
    personal_message_accepted_on: Field::Date,
    personal_messages: Field::HasMany,
    qr_code: Field::Text,
    role: Field::String,
    selected_email_template_id: Field::Number,
    selected_personal_message_id: Field::Number,
    signup_started_on: Field::Date,
    supporters: Field::HasMany,
    user: Field::BelongsTo.with_options(
      searchable: true,
      searchable_fields: ['last_name', 'first_name', 'email']
    ),
    uuid: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    goal
    amount_raised
    status
    supporters
    delivery_attempts
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    actuals
    campaign
    delivery_attempts
    goal
    goal_accepted_on
    invitation_accepted_on
    invitation_sent_at
    organization_role
    payments
    personal_message
    personal_message_accepted_on
    qr_code
    role
    selected_email_template_id
    selected_personal_message_id
    signup_started_on
    supporters
    user
    uuid
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    goal
    goal_accepted_on
    invitation_accepted_on
    invitation_sent_at
    organization_role
    personal_message
    personal_message_accepted_on
    role
    selected_personal_message_id
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how campaign members are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(campaign_member)
    campaign_member.user.name
  end
end
