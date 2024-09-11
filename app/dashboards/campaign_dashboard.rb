require "administrate/base_dashboard"

class CampaignDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    actuals: Field::Number,
    campaign_members: Field::HasMany,
    end_on: Field::Date,
    net_amount_raised: Field::Number.with_options(
      prefix: "$",
      decimals: 0
    ),
    goal: Field::Number.with_options(
      prefix: "$",
      decimals: 0
    ),
    individual_goal: Field::Number,
    name: Field::String,
    organization: Field::BelongsTo,
    payments: Field::HasMany,
    purpose: Field::Text,
    start_on: Field::Date,
    stripe_product_id: Field::String,
    stripe_price_id: Field::String,
    troop_track_imports: Field::HasMany,
    user: Field::BelongsTo.with_options(
      searchable: true,
      searchable_fields: ['last_name', 'first_name', 'email']
    ),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    unit_price: Field::Number,
    display_mode: Field::Select.with_options(
      collection: ['goal-oriented', 'purpose-oriented']
    ),
    sort_order: Field::Select.with_options(
      collection: ["ascending-by-price", "descending-by-price"]
    )
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    name
    created_at
    user
    goal
    net_amount_raised
    start_on
    end_on
    campaign_members
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    actuals
    campaign_members
    end_on
    net_amount_raised
    goal
    individual_goal
    name
    organization
    payments
    purpose
    start_on
    stripe_product_id
    user
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :end_on,
    :goal,
    :individual_goal,
    :purpose,
    :start_on,
    :stripe_product_id,
    :stripe_price_id,
    :unit_price,
    :user,
    :display_mode,
    :sort_order
  ]

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
  COLLECTION_FILTERS = {
    open: ->(resources) {resources.open},
    closed: -> (resources) {resources.closed}
  }.freeze

  # Overwrite this method to customize how campaigns are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(campaign)
    "#{campaign.name} (#{campaign.id})"
  end
end
