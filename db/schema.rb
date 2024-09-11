# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_14_184112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "campaign_exports", force: :cascade do |t|
    t.integer "campaign_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_exports_on_campaign_id"
    t.index ["status"], name: "index_campaign_exports_on_status"
  end

  create_table "campaign_members", force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "goal"
    t.integer "actuals"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.text "personal_message"
    t.date "invitation_accepted_on"
    t.date "email_template_accepted_on"
    t.integer "selected_email_template_id"
    t.date "goal_accepted_on"
    t.text "qr_code"
    t.integer "selected_personal_message_id"
    t.date "personal_message_accepted_on"
    t.string "role"
    t.integer "user_id"
    t.datetime "invitation_sent_at"
    t.date "signup_started_on"
    t.string "organization_role"
    t.integer "group_id"
    t.index ["actuals"], name: "index_campaign_members_on_actuals"
    t.index ["campaign_id"], name: "index_campaign_members_on_campaign_id"
    t.index ["goal"], name: "index_campaign_members_on_goal"
    t.index ["goal_accepted_on"], name: "index_campaign_members_on_goal_accepted_on"
    t.index ["group_id"], name: "index_campaign_members_on_group_id"
    t.index ["invitation_accepted_on"], name: "index_campaign_members_on_invitation_accepted_on"
    t.index ["invitation_sent_at"], name: "index_campaign_members_on_invitation_sent_at"
    t.index ["personal_message_accepted_on"], name: "index_campaign_members_on_personal_message_accepted_on"
    t.index ["role"], name: "index_campaign_members_on_role"
    t.index ["selected_email_template_id"], name: "index_campaign_members_on_selected_email_template_id"
    t.index ["selected_personal_message_id"], name: "index_campaign_members_on_selected_personal_message_id"
    t.index ["signup_started_on"], name: "index_campaign_members_on_signup_started_on"
    t.index ["user_id"], name: "index_campaign_members_on_user_id"
    t.index ["uuid"], name: "index_campaign_members_on_uuid"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "user_id"
    t.integer "goal"
    t.integer "actuals"
    t.string "name"
    t.text "purpose"
    t.date "start_on"
    t.date "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "individual_goal"
    t.string "stripe_product_id"
    t.string "stripe_price_id"
    t.string "sort_order", default: "ascending-by-price"
    t.integer "unit_price", default: 5
    t.string "display_mode", default: "goal-oriented"
    t.string "uuid"
    t.text "self_registration_qr_code"
    t.integer "text_limit", default: 500, null: false
    t.index ["actuals"], name: "index_campaigns_on_actuals"
    t.index ["end_on"], name: "index_campaigns_on_end_on"
    t.index ["goal"], name: "index_campaigns_on_goal"
    t.index ["name"], name: "index_campaigns_on_name"
    t.index ["organization_id"], name: "index_campaigns_on_organization_id"
    t.index ["start_on"], name: "index_campaigns_on_start_on"
    t.index ["stripe_price_id"], name: "index_campaigns_on_stripe_price_id"
    t.index ["stripe_product_id"], name: "index_campaigns_on_stripe_product_id"
    t.index ["unit_price"], name: "index_campaigns_on_unit_price"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
    t.index ["uuid"], name: "index_campaigns_on_uuid"
  end

  create_table "delivery_attempts", force: :cascade do |t|
    t.string "email_status"
    t.string "text_status"
    t.integer "deliverable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deliverable_type"
    t.index ["deliverable_id"], name: "index_delivery_attempts_on_deliverable_id"
    t.index ["deliverable_type", "deliverable_id"], name: "index_delivery_attempts_on_deliverable_type_and_deliverable_id"
  end

  create_table "donor_levels", force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "amount"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "perk"
    t.boolean "has_perk", default: false
    t.boolean "has_star", default: false
    t.index ["amount"], name: "index_donor_levels_on_amount"
    t.index ["campaign_id"], name: "index_donor_levels_on_campaign_id"
  end

  create_table "email_templates", force: :cascade do |t|
    t.string "subject"
    t.text "body"
    t.text "prompt"
    t.integer "owner_id"
    t.string "owner_type"
    t.json "bot_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "templateable_id"
    t.string "templateable_type"
    t.index ["owner_id"], name: "index_email_templates_on_owner_id"
    t.index ["owner_type"], name: "index_email_templates_on_owner_type"
    t.index ["templateable_type", "templateable_id"], name: "index_email_templates_on_templateable_type_and_templateable_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "goal"
    t.text "registration_qr_code"
    t.text "donation_qr_code"
    t.integer "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_groups_on_campaign_id"
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "logins", force: :cascade do |t|
    t.string "email"
    t.string "uuid"
    t.string "confirmation_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mobile"
    t.index ["created_at"], name: "index_logins_on_created_at"
    t.index ["email"], name: "index_logins_on_email"
    t.index ["mobile"], name: "index_logins_on_mobile"
    t.index ["uuid"], name: "index_logins_on_uuid"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "campaign_id"
    t.text "body"
    t.string "subject"
    t.date "sent_on"
    t.text "recipients"
    t.text "delivery_methods"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "delivery_type"
    t.string "send_to"
    t.integer "texts_used"
    t.index ["campaign_id"], name: "index_messages_on_campaign_id"
    t.index ["delivery_type"], name: "index_messages_on_delivery_type"
    t.index ["sent_on"], name: "index_messages_on_sent_on"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "affiliation"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount"
    t.string "visibility"
    t.integer "supporter_id"
    t.integer "campaign_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "paid_on"
    t.text "message"
    t.integer "donor_level_id"
    t.index ["amount"], name: "index_payments_on_amount"
    t.index ["campaign_member_id"], name: "index_payments_on_campaign_member_id"
    t.index ["donor_level_id"], name: "index_payments_on_donor_level_id"
    t.index ["paid_on"], name: "index_payments_on_paid_on"
    t.index ["supporter_id"], name: "index_payments_on_supporter_id"
  end

  create_table "personal_messages", force: :cascade do |t|
    t.json "bot_response"
    t.integer "messageable_id"
    t.string "messageable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.text "message"
    t.index ["messageable_id"], name: "index_personal_messages_on_messageable_id"
    t.index ["messageable_type"], name: "index_personal_messages_on_messageable_type"
  end

  create_table "supporters", force: :cascade do |t|
    t.string "email"
    t.string "mobile"
    t.integer "campaign_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "visibility"
    t.string "payment_url"
    t.string "uuid"
    t.string "stripe_session_id"
    t.string "name"
    t.string "postal_code"
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.index ["campaign_member_id"], name: "index_supporters_on_campaign_member_id"
    t.index ["email"], name: "index_supporters_on_email"
    t.index ["mobile"], name: "index_supporters_on_mobile"
    t.index ["name"], name: "index_supporters_on_name"
    t.index ["postal_code"], name: "index_supporters_on_postal_code"
    t.index ["uuid"], name: "index_supporters_on_uuid"
  end

  create_table "troop_track_imports", force: :cascade do |t|
    t.string "tt_import"
    t.json "data"
    t.string "export_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "campaign_id"
    t.index ["campaign_id"], name: "index_troop_track_imports_on_campaign_id"
    t.index ["export_uuid"], name: "index_troop_track_imports_on_export_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "mobile"
    t.boolean "youthraise_admin", default: false
    t.json "text_preferences"
    t.boolean "accepts_texts_from_youthraise", default: false, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["mobile"], name: "index_users_on_mobile"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
