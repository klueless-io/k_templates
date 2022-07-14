# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20210406124327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "btree_gin"
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"

  create_table "account_history_data", force: :cascade do |t|
    t.integer  "source_account_id"
    t.integer  "company_id"
    t.decimal  "balance",                     precision: 19, scale: 2
    t.integer  "currentagingbucket"
    t.string   "custpo"
    t.string   "finalpaychecknumber"
    t.string   "finalpaypaymethod"
    t.string   "finalpayrefnumber"
    t.decimal  "finalpaytotal",               precision: 19, scale: 2
    t.datetime "finalpaymentdate",            precision: 6
    t.integer  "financecharge"
    t.integer  "source_invoice_id"
    t.integer  "invoice_id"
    t.string   "invoicenumber"
    t.integer  "source_journal_id"
    t.integer  "adjustment_id"
    t.boolean  "memoforcedtaxadded",                                   default: false
    t.boolean  "memoforcedtaxremoval",                                 default: false
    t.text     "name"
    t.string   "ordernodisplay"
    t.decimal  "partialpayamount",            precision: 19, scale: 2
    t.string   "partialpaychecknumber"
    t.decimal  "partialpaycnt",               precision: 19, scale: 2
    t.string   "partialpaypaymethod"
    t.datetime "partialpaypaydate",           precision: 6
    t.string   "partialpayrefnumber"
    t.decimal  "partialpaytotal",             precision: 19, scale: 2
    t.datetime "paymentduedate",              precision: 6
    t.datetime "posteddate",                  precision: 6
    t.string   "recordtype"
    t.decimal  "refundtotal",                 precision: 19, scale: 2
    t.string   "storenum"
    t.string   "storenumber"
    t.decimal  "subtotalposted",              precision: 19, scale: 2
    t.decimal  "total",                       precision: 19, scale: 2
    t.string   "usersalesname"
    t.integer  "webreferenceid"
    t.integer  "finalpaycct_id"
    t.integer  "finalpaymentcreditcard_id"
    t.integer  "partialpaycct_id"
    t.integer  "partialpaymentcreditcard_id"
    t.integer  "totaltax_id"
    t.datetime "created_at",                  precision: 6,                            null: false
    t.datetime "updated_at",                  precision: 6,                            null: false
    t.integer  "tenant_id"
    t.integer  "printsmith_id"
    t.boolean  "deleted",                                              default: false
    t.boolean  "dirty",                                                default: false
    t.boolean  "ready",                                                default: false
    t.boolean  "associations_complete",                                default: false
    t.integer  "assocation_checks",                                    default: 0
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "account_history_data", ["printsmith_id"], name: "index_account_history_data_on_printsmith_id", using: :btree
  add_index "account_history_data", ["source_account_id", "tenant_id", "printsmith_id", "deleted"], name: "index_account_history_data_tenant_source_account", where: "(deleted = false)", using: :btree
  add_index "account_history_data", ["source_account_id"], name: "index_account_history_data_on_source_account_id", using: :btree
  add_index "account_history_data", ["source_journal_id"], name: "index_account_history_data_on_source_journal_id", using: :btree
  add_index "account_history_data", ["tenant_id", "source_invoice_id", "printsmith_id", "recordtype"], name: "index_account_history_data_source_invoice", where: "((recordtype)::text = '1'::text)", using: :btree
  add_index "account_history_data", ["tenant_id", "source_invoice_id"], name: "account_history_data_tenant_id_source_invoice_id_idx", using: :btree

  create_table "action_logs", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.integer  "sales_rep_user_id"
    t.integer  "location_id"
    t.string   "action"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "context_id"
    t.string   "context_type"
  end

  add_index "action_logs", ["action"], name: "index_action_logs_on_action", using: :btree
  add_index "action_logs", ["location_id"], name: "index_action_logs_on_location_id", using: :btree
  add_index "action_logs", ["sales_rep_user_id"], name: "index_action_logs_on_sales_rep_user_id", using: :btree
  add_index "action_logs", ["tenant_id"], name: "index_action_logs_on_tenant_id", using: :btree
  add_index "action_logs", ["user_id"], name: "index_action_logs_on_user_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.integer  "element_id"
    t.string   "element_type",        limit: 255
    t.datetime "created_at",                      precision: 6
    t.datetime "updated_at",                      precision: 6
    t.integer  "contact_id"
    t.integer  "company_id"
    t.integer  "estimate_id"
    t.integer  "invoice_id"
    t.integer  "phone_call_id"
    t.integer  "task_id"
    t.integer  "email_id"
    t.integer  "comment_id"
    t.integer  "order_id"
    t.integer  "sale_id"
    t.integer  "tracker_id"
    t.integer  "email_message_id"
    t.integer  "note_id"
    t.datetime "source_created_at"
    t.string   "activity_for"
    t.boolean  "hide",                                          default: false
    t.integer  "campaign_id"
    t.integer  "campaign_message_id"
    t.integer  "parent_contact_id"
    t.boolean  "deleted",                                       default: false
    t.integer  "portal_comment_id"
    t.integer  "meeting_id"
    t.integer  "inquiry_id"
    t.integer  "shipment_id"
  end

  add_index "activities", ["activity_for", "email_id", "tenant_id", "company_id", "source_created_at", "hide"], name: "index_activities_for_email_company", where: "(((activity_for)::text = 'email'::text) AND (email_id IS NOT NULL) AND (company_id IS NOT NULL) AND (hide = false))", using: :btree
  add_index "activities", ["activity_for", "email_id", "tenant_id", "contact_id", "source_created_at", "hide"], name: "index_activities_for_email_contact", where: "(((activity_for)::text = 'email'::text) AND (email_id IS NOT NULL) AND (contact_id IS NOT NULL) AND (hide = false))", using: :btree
  add_index "activities", ["activity_for"], name: "index_activities_on_activity_for", using: :btree
  add_index "activities", ["activity_for"], name: "index_activities_on_activity_for_email", where: "((activity_for)::text = 'email'::text)", using: :btree
  add_index "activities", ["activity_for"], name: "index_activities_on_activity_for_phone_call", where: "((activity_for)::text = 'phone_call'::text)", using: :btree
  add_index "activities", ["company_id"], name: "index_activities_on_company_id", using: :btree
  add_index "activities", ["contact_id"], name: "index_activities_on_contact_id", using: :btree
  add_index "activities", ["deleted"], name: "index_activities_on_deleted", using: :btree
  add_index "activities", ["email_id"], name: "index_activities_on_email_id", using: :btree
  add_index "activities", ["estimate_id"], name: "index_activities_on_estimate_id", using: :btree
  add_index "activities", ["invoice_id"], name: "index_activities_on_invoice_id", using: :btree
  add_index "activities", ["phone_call_id"], name: "index_activities_on_phone_call_id", using: :btree
  add_index "activities", ["source_created_at"], name: "index_activities_on_source_created_at", order: {"source_created_at"=>:desc}, using: :btree
  add_index "activities", ["task_id"], name: "index_activities_on_task_id", using: :btree
  add_index "activities", ["tenant_id", "activity_for", "campaign_id", "campaign_message_id", "tracker_id", "source_created_at", "hide", "deleted"], name: "index_activities_campaign_opened", order: {"source_created_at"=>:desc}, where: "(((activity_for)::text = 'campaign_opened'::text) AND (NOT hide) AND (NOT deleted))", using: :btree
  add_index "activities", ["tenant_id", "activity_for", "campaign_id", "source_created_at", "hide", "deleted"], name: "index_activities_campaign_opened_aggregated", order: {"source_created_at"=>:desc}, where: "(((activity_for)::text = 'campaign_opened_aggregated'::text) AND (NOT hide) AND (NOT deleted))", using: :btree
  add_index "activities", ["tenant_id", "company_id", "contact_id", "estimate_id", "id"], name: "index_activities_tenant_company_contact_estimate", where: "(estimate_id IS NOT NULL)", using: :btree
  add_index "activities", ["tenant_id", "company_id", "contact_id", "invoice_id", "id"], name: "index_activities_tenant_company_contact_invoice", where: "(invoice_id IS NOT NULL)", using: :btree
  add_index "activities", ["tenant_id", "shipment_id", "hide", "deleted"], name: "index_activities_on_shipment_id", using: :btree
  add_index "activities", ["tenant_id", "source_created_at", "created_at", "deleted", "hide", "activity_for"], name: "index_activities_new", using: :btree
  add_index "activities", ["tenant_id", "source_created_at", "estimate_id", "invoice_id", "company_id", "contact_id", "id"], name: "index_activities_tenant_estiamte_invoice_source_created", order: {"source_created_at"=>:desc}, where: "((estimate_id IS NOT NULL) AND (invoice_id IS NULL))", using: :btree
  add_index "activities", ["tenant_id", "source_created_at", "invoice_id", "company_id", "contact_id", "id"], name: "index_activities_tenant_invoice_source_created", order: {"source_created_at"=>:desc}, where: "(invoice_id IS NOT NULL)", using: :btree
  add_index "activities", ["tenant_id", "source_created_at"], name: "activities_tenant_id_source_created_at_idx", order: {"source_created_at"=>:desc}, where: "((hide = false) AND (deleted = false))", using: :btree
  add_index "activities", ["tenant_id", "source_created_at"], name: "activity_test", order: {"source_created_at"=>:desc}, where: "((estimate_id IS NOT NULL) AND (invoice_id IS NULL))", using: :btree
  add_index "activities", ["tenant_id", "source_created_at"], name: "activity_test2", order: {"source_created_at"=>:desc}, where: "(invoice_id IS NOT NULL)", using: :btree
  add_index "activities", ["tenant_id", "source_created_at"], name: "index_activities_on_tenant_source_created_at_estimate", order: {"source_created_at"=>:desc}, where: "((estimate_id IS NOT NULL) AND (invoice_id IS NULL))", using: :btree
  add_index "activities", ["tenant_id", "source_created_at"], name: "index_activities_on_tenant_source_created_at_invoice", order: {"source_created_at"=>:desc}, where: "(invoice_id IS NOT NULL)", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "city"
    t.string   "country"
    t.boolean  "deleted",                         default: false
    t.boolean  "manualchange"
    t.string   "name"
    t.string   "state"
    t.string   "street1"
    t.string   "street2"
    t.string   "street3"
    t.string   "webid"
    t.string   "zip"
    t.string   "zone"
    t.integer  "printsmith_id"
    t.boolean  "dirty",                           default: false
    t.integer  "tenant_id"
    t.datetime "created_at",        precision: 6
    t.datetime "updated_at",        precision: 6
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.integer  "company_id"
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.string   "external_id"
  end

  add_index "addresses", ["company_id"], name: "index_addresses_on_company_id", using: :btree
  add_index "addresses", ["printsmith_id", "tenant_id"], name: "printsmith_id", using: :btree

  create_table "adjustments", force: :cascade do |t|
    t.decimal  "total"
    t.integer  "invoice_id"
    t.integer  "company_id"
    t.integer  "tenant_id"
    t.datetime "created_at",             precision: 6
    t.datetime "updated_at",             precision: 6
    t.integer  "printsmith_id"
    t.boolean  "dirty"
    t.boolean  "deleted",                              default: false
    t.boolean  "ready",                                default: false
    t.boolean  "associations_complete",                default: false
    t.integer  "assocation_checks",                    default: 0
    t.integer  "source_account_id"
    t.integer  "source_invoice_id"
    t.boolean  "affect_sales",                         default: false
    t.datetime "posted_date",            precision: 6
    t.datetime "final_payment_date",     precision: 6
    t.boolean  "voided",                               default: false
    t.integer  "accounting_month"
    t.integer  "accounting_year"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.string   "description"
    t.string   "comment"
    t.string   "source_sales_rep"
    t.string   "reference_number"
    t.datetime "last_refreshed_at"
    t.integer  "last_refreshed_version"
    t.integer  "sales_rep_user_id"
    t.integer  "location_user_id"
    t.integer  "sales_summary_id"
    t.integer  "daily_accounting_day"
    t.integer  "daily_accounting_month"
    t.integer  "daily_accounting_year"
    t.integer  "daily_sales_summary_id"
    t.decimal  "total_less_non_sales",                 default: 0.0
    t.decimal  "markups",                              default: 0.0
    t.decimal  "discounts",                            default: 0.0
    t.decimal  "shipping",                             default: 0.0
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "adjustments", ["accounting_year"], name: "index_adjustments_on_accounting_year", using: :btree
  add_index "adjustments", ["affect_sales", "deleted", "voided", "id"], name: "index_adjustments_affect_sales", where: "((affect_sales = true) AND (deleted = false) AND (voided = false))", using: :btree
  add_index "adjustments", ["company_id"], name: "index_adjustments_on_company_id", using: :btree
  add_index "adjustments", ["daily_sales_summary_id", "total"], name: "index_adjustments_daily_sales_summary_id_totals", using: :btree
  add_index "adjustments", ["posted_date"], name: "index_adjustments_on_posted_date", using: :btree
  add_index "adjustments", ["sales_summary_id", "posted_date"], name: "index_adjustments_sales_summary_id_posted_date", where: "(sales_summary_id IS NOT NULL)", using: :btree
  add_index "adjustments", ["tenant_id", "accounting_month", "accounting_year", "posted_date", "total", "voided", "deleted"], name: "index_adjustments_accounting_month_year", where: "((voided = false) AND (deleted = false))", using: :btree
  add_index "adjustments", ["tenant_id", "company_id", "invoice_id", "id"], name: "index_adjustments_tenant_id_company_invoice", using: :btree
  add_index "adjustments", ["tenant_id", "last_refreshed_at", "last_refreshed_version"], name: "adjustments_refresh_index", using: :btree
  add_index "adjustments", ["tenant_id", "printsmith_id"], name: "index_adjustments_on_tenant_id_and_printsmith_id", using: :btree
  add_index "adjustments", ["tenant_id"], name: "adjustments_dirty_index", where: "(dirty = true)", using: :btree

  create_table "affiliations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tenant_id"
    t.boolean "primary"
  end

  add_index "affiliations", ["tenant_id"], name: "index_affiliations_on_tenant_id", using: :btree
  add_index "affiliations", ["user_id"], name: "index_affiliations_on_user_id", using: :btree

  create_table "api_logs", force: :cascade do |t|
    t.string   "url"
    t.jsonb    "body"
    t.string   "response_message"
    t.integer  "context_id"
    t.string   "context_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tenant_id"
    t.integer  "retry_count"
    t.string   "status"
  end

  add_index "api_logs", ["context_id", "context_type", "body"], name: "api_logs_context_id_context_type_body_idx", using: :btree
  add_index "api_logs", ["tenant_id"], name: "index_api_logs_on_tenant_id", using: :btree

  create_table "assets", force: :cascade do |t|
    t.string   "category"
    t.string   "file_name"
    t.string   "file_hash"
    t.string   "content_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "enterprise_id"
    t.integer  "tenant_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.integer  "tracker_id"
    t.boolean  "archived",      default: false
    t.jsonb    "meta_data",     default: {}
    t.boolean  "global",        default: false
  end

  add_index "assets", ["category"], name: "index_assets_on_category", using: :btree
  add_index "assets", ["context_id", "context_type", "file_hash"], name: "assets_context_id_context_type_file_hash_idx", using: :btree
  add_index "assets", ["tenant_id", "context_type", "file_hash", "created_at"], name: "index_assets_pending", where: "(((context_type)::text = 'PendingAttachment'::text) AND (file_hash IS NOT NULL))", using: :btree

  create_table "background_job_results", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.string   "job_hash"
    t.string   "job_type"
    t.string   "name"
    t.string   "description"
    t.string   "status_view"
    t.string   "completed_view"
    t.jsonb    "data"
    t.jsonb    "result"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "background_jobs", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.string   "job_type"
    t.string   "name"
    t.string   "description"
    t.string   "status_view"
    t.string   "completed_view"
    t.jsonb    "data"
    t.jsonb    "result"
    t.boolean  "complete",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.datetime "completed_at"
    t.string   "job_hash"
  end

  create_table "backups", force: :cascade do |t|
    t.integer  "tenant_id",                               null: false
    t.string   "filename",                                null: false
    t.datetime "created_at", precision: 6,                null: false
    t.datetime "updated_at", precision: 6,                null: false
    t.boolean  "success",                  default: true
  end

  add_index "backups", ["tenant_id"], name: "index_backups_on_tenant_id", using: :btree

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "bookmarks", ["context_id", "user_id", "context_type"], name: "bookmarks_context_id_user_id_context_type_idx", using: :btree

  create_table "budget_months", force: :cascade do |t|
    t.integer  "budget_id",                            null: false
    t.integer  "total",                    default: 0, null: false
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.date     "month_date"
  end

  create_table "budgets", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "financial_year"
    t.datetime "created_at",     precision: 6
    t.datetime "updated_at",     precision: 6
    t.integer  "comp_perc"
  end

  add_index "budgets", ["tenant_id", "financial_year"], name: "index_budgets_on_tenant_id_and_financial_year", unique: true, using: :btree

  create_table "builds", force: :cascade do |t|
    t.text     "name"
    t.text     "os"
    t.text     "checksum"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "calendar_entries", force: :cascade do |t|
    t.integer  "calendar_id",                               null: false
    t.text     "entry_ident",                               null: false
    t.datetime "start_time",  precision: 6
    t.datetime "end_time",    precision: 6
    t.text     "summary"
    t.text     "description"
    t.boolean  "updated",                   default: false
  end

  add_index "calendar_entries", ["calendar_id", "entry_ident"], name: "calendar_entries_calendar_id_entry_ident_key", unique: true, using: :btree
  add_index "calendar_entries", ["entry_ident", "updated", "start_time", "id"], name: "index_calendar_entries_on_entry_ident", where: "(updated = true)", using: :btree
  add_index "calendar_entries", ["updated"], name: "tmp_fix_6", using: :btree

  create_table "calendar_entry_deletions", force: :cascade do |t|
    t.integer "user_id"
    t.string  "calendar_ident"
    t.string  "entry_ident"
    t.boolean "send_updates",   default: false
  end

  create_table "calendars", force: :cascade do |t|
    t.text     "calendar_ident"
    t.datetime "last_sync",       precision: 6
    t.integer  "user_id"
    t.text     "next_sync_token"
    t.text     "timezone"
    t.integer  "user_ids",                      default: [], array: true
  end

  add_index "calendars", ["calendar_ident", "id"], name: "index_calendars_calendar_ident", where: "(array_length(user_ids, 1) > 0)", using: :btree
  add_index "calendars", ["user_id"], name: "calendar_ids_calendar_ids_user_id_fk_idx", using: :btree
  add_index "calendars", ["user_ids"], name: "index_calendars_user_ids", using: :gin

  create_table "campaign_calendar_entries", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.string   "calendar_entry_id"
    t.datetime "date"
  end

  add_index "campaign_calendar_entries", ["campaign_id", "tenant_id"], name: "index_campaign_calendar_entries_campaign_tenant", using: :btree

  create_table "campaign_counts", force: :cascade do |t|
    t.integer "tenant_id"
    t.integer "campaign_id"
    t.integer "total_count"
  end

  create_table "campaign_exclusions", force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "contact_id"
  end

  add_index "campaign_exclusions", ["campaign_id", "contact_id"], name: "index_campaign_exclusions_on_campaign_id", using: :btree
  add_index "campaign_exclusions", ["contact_id"], name: "index_campaign_exclusions_on_contact_id", using: :btree

  create_table "campaign_groups", force: :cascade do |t|
    t.string  "name"
    t.integer "primary_id",    default: 0
    t.integer "campaign_ids",  default: [], array: true
    t.integer "enterprise_id"
  end

  create_table "campaign_messages", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "contact_id"
    t.boolean  "opened"
    t.boolean  "sent"
    t.datetime "created_at",        precision: 6,                 null: false
    t.datetime "updated_at",        precision: 6,                 null: false
    t.boolean  "failed",                          default: false
    t.text     "note"
    t.integer  "parent_message_id"
    t.datetime "sent_date"
    t.string   "failed_reason"
    t.boolean  "unsubscribed",                    default: false
    t.integer  "parent_contact_id"
    t.string   "sent_message_id"
    t.string   "complaint"
    t.boolean  "delivered",                       default: false
    t.boolean  "fixed",                           default: false
    t.integer  "tenant_id"
  end

  add_index "campaign_messages", ["campaign_id", "contact_id", "sent", "failed", "sent_date", "created_at", "id"], name: "index_campaign_messages_campaign_contact_status_dates", order: {"sent_date"=>:desc, "created_at"=>:desc}, using: :btree
  add_index "campaign_messages", ["campaign_id"], name: "index_campaign_messages_on_campaign_id", using: :btree
  add_index "campaign_messages", ["contact_id"], name: "index_campaign_messages_on_contact_id", using: :btree
  add_index "campaign_messages", ["parent_contact_id"], name: "index_campaign_messages_on_parent_contact_id", using: :btree
  add_index "campaign_messages", ["parent_message_id"], name: "index_campaign_messages_parent", using: :btree
  add_index "campaign_messages", ["sent_message_id", "id"], name: "index_campaign_messages_sent_message", using: :btree
  add_index "campaign_messages", ["tenant_id", "contact_id", "campaign_id", "sent", "opened", "failed", "unsubscribed", "id"], name: "index_campaign_messages_tenant_stats", using: :btree

  create_table "campaign_messages_trackers", id: false, force: :cascade do |t|
    t.integer "campaign_message_id"
    t.integer "tracker_id"
  end

  add_index "campaign_messages_trackers", ["campaign_message_id"], name: "index_campaign_messages_trackers_on_campaign_message_id", using: :btree
  add_index "campaign_messages_trackers", ["tracker_id"], name: "index_campaign_messages_trackers_on_tracker_id", using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.integer  "tenant_id"
    t.text     "name"
    t.text     "description"
    t.boolean  "global"
    t.integer  "status"
    t.integer  "method"
    t.text     "subject"
    t.text     "body"
    t.datetime "created_at",                  precision: 6,                  null: false
    t.datetime "updated_at",                  precision: 6,                  null: false
    t.integer  "email_template_id"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.boolean  "test",                                      default: false
    t.integer  "identity_id"
    t.boolean  "scheduled",                                 default: false
    t.integer  "schedule_weekday",                          default: 0
    t.datetime "scheduled_at"
    t.integer  "schedule_week",                             default: 1
    t.integer  "schedule_hour",                             default: 10
    t.boolean  "allow_override",                            default: false
    t.boolean  "test_confirmed",                            default: false
    t.boolean  "clear_exclusions",                          default: false
    t.integer  "enterprise_id"
    t.jsonb    "hidden_tenants",                            default: {}
    t.boolean  "enterprise_campaign",                       default: false
    t.integer  "selected_tenants",                          default: [],                  array: true
    t.string   "test_emails",                               default: [],                  array: true
    t.boolean  "global_hide",                               default: false
    t.boolean  "paused",                                    default: false
    t.datetime "schedule_date",                             default: [],                  array: true
    t.string   "schedule_interval_type",                    default: "none"
    t.integer  "schedule_interval",                         default: 1
    t.string   "schedule_day_lock",                         default: "none"
    t.boolean  "schedule_auto_send",                        default: false
    t.integer  "auto_send_tenants",                         default: [],                  array: true
    t.jsonb    "alerts",                                    default: {}
    t.jsonb    "approvals",                                 default: {}
    t.boolean  "auto_send_throttle_override",               default: false
    t.boolean  "auto_approve",                              default: false
    t.jsonb    "skips",                                     default: {}
  end

  add_index "campaigns", ["body"], name: "index_campaigns_body_parent", where: "(parent_id IS NULL)", using: :hash
  add_index "campaigns", ["body"], name: "index_campaigns_body_test", where: "(test = true)", using: :hash
  add_index "campaigns", ["email_template_id"], name: "index_campaigns_on_email_template_id", using: :btree
  add_index "campaigns", ["enterprise_id"], name: "index_campaigns_on_enterprise_id", using: :btree
  add_index "campaigns", ["id", "tenant_id", "test", "paused"], name: "index_campaigns_id_tenant_not_test", where: "(test = false)", using: :btree
  add_index "campaigns", ["parent_id", "test", "tenant_id"], name: "index_campaigns_parent_id_md5_body_test", where: "(test = true)", using: :btree
  add_index "campaigns", ["tenant_id", "parent_id", "test", "created_at"], name: "index_campaigns_on_tenant_parent_created_at_not_test", order: {"created_at"=>:desc}, where: "(test <> false)", using: :btree
  add_index "campaigns", ["tenant_id", "test", "paused", "parent_id", "id"], name: "index_campaigns_tenant_id_test_paused", where: "(NOT test)", using: :btree
  add_index "campaigns", ["tenant_id"], name: "index_campaigns_on_tenant_id", using: :btree
  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id", using: :btree

  create_table "campaigns_contact_lists", id: false, force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "contact_list_id"
  end

  add_index "campaigns_contact_lists", ["campaign_id"], name: "index_campaigns_contact_lists_on_campaign_id", using: :btree
  add_index "campaigns_contact_lists", ["contact_list_id"], name: "index_campaigns_contact_lists_on_contact_list_id", using: :btree

  create_table "cash_drawers", force: :cascade do |t|
    t.decimal  "amount",            precision: 19, scale: 2
    t.decimal  "arbalance",         precision: 19, scale: 2
    t.integer  "cardcount"
    t.decimal  "cardtotal",         precision: 19, scale: 2
    t.decimal  "cashtotal",         precision: 19, scale: 2
    t.decimal  "changefund",        precision: 19, scale: 2
    t.integer  "checkcount"
    t.decimal  "checktotal",        precision: 19, scale: 2
    t.decimal  "fund",              precision: 19, scale: 2
    t.boolean  "held",                                       default: false
    t.boolean  "deleted",                                    default: false
    t.datetime "lastcloseoutdate",  precision: 6
    t.datetime "laststartupdate",   precision: 6
    t.decimal  "paidouts",          precision: 19, scale: 2
    t.decimal  "prevarbalance",     precision: 19, scale: 2
    t.datetime "transactiondate",   precision: 6
    t.datetime "created_at",        precision: 6,                            null: false
    t.datetime "updated_at",        precision: 6,                            null: false
    t.integer  "tenant_id"
    t.integer  "printsmith_id"
    t.boolean  "dirty",                                      default: false
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  create_table "clearbit_quota", force: :cascade do |t|
    t.string   "klass"
    t.integer  "used",       default: 0
    t.integer  "max",        default: 1000
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50,                default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.integer  "user_id"
    t.datetime "created_at",                   precision: 6
    t.datetime "updated_at",                   precision: 6
    t.integer  "tenant_id"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["tenant_id"], name: "index_comments_on_tenant_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",                               limit: 255
    t.integer  "printsmith_id"
    t.datetime "created_at",                                     precision: 6
    t.datetime "updated_at",                                     precision: 6
    t.integer  "tenant_id"
    t.boolean  "exclude_from_analysis"
    t.boolean  "walk_in"
    t.boolean  "dirty"
    t.boolean  "deleted",                                                                 default: false
    t.decimal  "avg_conversion_ratio",                           precision: 19, scale: 2
    t.decimal  "mtd_sales",                                      precision: 19, scale: 2
    t.decimal  "ytd_sales",                                      precision: 19, scale: 2
    t.boolean  "needs_recalc",                                                            default: true
    t.hstore   "sales_hash",                                                              default: {}
    t.integer  "mtd_rank"
    t.integer  "ytd_rank"
    t.integer  "ly_rank"
    t.integer  "rolling_12_month_rank"
    t.decimal  "ly_sales",                                       precision: 19, scale: 2
    t.decimal  "rolling_12_month_sales",                         precision: 19, scale: 2
    t.string   "status"
    t.boolean  "prospect",                                                                default: false
    t.string   "account_type"
    t.integer  "rolling_12_month_rank_ly"
    t.decimal  "rolling_12_month_sales_ly",                      precision: 19, scale: 2
    t.integer  "source_billtoaddress_id"
    t.integer  "source_billtocontact_id"
    t.integer  "source_salesrep_id"
    t.integer  "source_shiptoaddress_id"
    t.integer  "source_contact_id"
    t.integer  "source_shippingmode_id"
    t.integer  "source_taxtable_id"
    t.integer  "sales_rep_user_id"
    t.boolean  "marketing_do_not_mail",                                                   default: false
    t.boolean  "needs_avg_conversion_ratio",                                              default: true
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.datetime "last_clearbit_data_fetch_date"
    t.decimal  "rolling_12_month_cogs"
    t.datetime "last_order_date"
    t.decimal  "growth_percentage",                                                       default: 0.0
    t.integer  "location_user_id"
    t.decimal  "lifetime_value",                                 precision: 19, scale: 2
    t.boolean  "needs_lifetime_value_recalc",                                             default: true
    t.datetime "oldest_interaction"
    t.decimal  "rolling_1_month_sales",                                                   default: 0.0
    t.integer  "order_count",                                                             default: 0
    t.jsonb    "cache_data",                                                              default: {}
    t.datetime "last_viewed"
    t.boolean  "has_clearbit_data",                                                       default: false
    t.jsonb    "clearbit_data",                                                           default: {}
    t.jsonb    "custom_data",                                                             default: {}
    t.integer  "account_payable_id"
    t.string   "phone"
    t.string   "master_account"
    t.string   "lead_source"
    t.string   "lead_source_2"
    t.datetime "last_contact"
    t.datetime "last_email_sent"
    t.datetime "last_email_received"
    t.datetime "last_phone_call"
    t.integer  "rolling_12_month_rank_ly_ly"
    t.decimal  "rolling_12_month_sales_ly_ly",                   precision: 19, scale: 2
    t.integer  "rolling_12_month_rank_ly_previous"
    t.decimal  "rolling_12_month_sales_ly_previous"
    t.string   "account_note"
    t.string   "job_note"
    t.decimal  "credit_limit",                                   precision: 19, scale: 2
    t.datetime "account_created_date"
    t.string   "account_display_id"
    t.string   "business_type_code"
    t.datetime "last_refreshed_at"
    t.integer  "last_refreshed_version"
    t.datetime "company_created_date"
    t.boolean  "web"
    t.decimal  "balance",                                        precision: 19, scale: 2
    t.boolean  "no_notifications",                                                        default: false
    t.boolean  "remote_sales_rep_update"
    t.datetime "last_pickup_date"
    t.datetime "single_sale_only_at"
    t.boolean  "remote_lead_source_update"
    t.boolean  "send_invoice_ap_contact"
    t.integer  "primary_contact_id"
    t.integer  "prospect_status_id"
    t.integer  "prospect_sentiment"
    t.integer  "invoice_address_id"
    t.integer  "statement_address_id"
    t.integer  "est_spend"
    t.integer  "conv_prob"
    t.boolean  "remote_account_update"
    t.integer  "lead_type_id"
    t.boolean  "created_ps"
    t.boolean  "walk_in_lead_transfer_initial"
    t.boolean  "walk_in_lead_transfer_to"
    t.string   "external_id"
    t.datetime "last_meeting"
    t.boolean  "is_lead"
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.jsonb    "meta_data",                                                               default: {}
    t.boolean  "mbe_center",                                                              default: false, null: false
    t.boolean  "b2b",                                                                     default: false, null: false
    t.string   "mbe_id",                                                                  default: ""
    t.boolean  "mbe_privilege",                                                           default: false
    t.datetime "first_sale_at"
    t.string   "sales_rep_platform_id"
    t.jsonb    "tmp_data",                                                                default: {}
  end

  add_index "companies", ["external_id", "tenant_id"], name: "index_companies_on_external_id_and_tenant_id", unique: true, using: :btree
  add_index "companies", ["has_clearbit_data", "rolling_12_month_rank", "rolling_12_month_sales", "rolling_12_month_sales_ly", "tenant_id", "deleted", "walk_in"], name: "index_companies_clearbit", where: "((has_clearbit_data = false) AND (walk_in = false) AND (deleted = false))", using: :btree
  add_index "companies", ["id", "invoice_address_id", "deleted"], name: "companies_invoice_retry", where: "(remote_account_update = true)", using: :btree
  add_index "companies", ["id", "marketing_do_not_mail"], name: "index_companies_id_do_not_mail", using: :btree
  add_index "companies", ["lead_type_id"], name: "index_companies_on_lead_type_id", using: :btree
  add_index "companies", ["location_user_id"], name: "index_companies_on_location_user_id", using: :btree
  add_index "companies", ["prospect_status_id", "prospect", "id", "deleted"], name: "index_companies_prospect_satatus_id", where: "((prospect = true) AND (prospect_status_id IS NOT NULL) AND (deleted = false))", using: :btree
  add_index "companies", ["remote_lead_source_update"], name: "index_companies_on_remote_lead_source_update", using: :btree
  add_index "companies", ["remote_sales_rep_update"], name: "index_companies_on_remote_sales_rep_update", using: :btree
  add_index "companies", ["sales_rep_user_id", "source_salesrep_id"], name: "companies_sales_rep_indexes", using: :btree
  add_index "companies", ["tenant_id", "company_created_date"], name: "index_companies_on_tenant_id_and_company_created_date", using: :btree
  add_index "companies", ["tenant_id", "deleted", "rolling_12_month_sales", "rolling_12_month_sales_ly", "id", "last_order_date", "last_pickup_date", "rolling_12_month_cogs", "growth_percentage", "order_count"], name: "index_companies_stats", where: "((deleted = false) AND ((rolling_12_month_sales > (0)::numeric) OR (rolling_12_month_sales_ly > (0)::numeric)))", using: :btree
  add_index "companies", ["tenant_id", "deleted", "walk_in", "location_user_id", "source_salesrep_id", "printsmith_id", "single_sale_only_at"], name: "index_companies_on_single_sale_only_sales_rep_location", where: "((NOT deleted) AND (printsmith_id IS NOT NULL) AND (single_sale_only_at IS NOT NULL))", using: :btree
  add_index "companies", ["tenant_id", "deleted", "walk_in", "sales_rep_user_id", "source_salesrep_id", "printsmith_id", "single_sale_only_at"], name: "index_companies_on_single_sale_only_sales_rep_user", where: "((NOT deleted) AND (printsmith_id IS NOT NULL) AND (single_sale_only_at IS NOT NULL))", using: :btree
  add_index "companies", ["tenant_id", "deleted"], name: "companies_remote_account_update", where: "(remote_account_update = true)", using: :btree
  add_index "companies", ["tenant_id", "deleted"], name: "index_companies_retry_sales_rep_update", where: "(remote_sales_rep_update = true)", using: :btree
  add_index "companies", ["tenant_id", "id", "marketing_do_not_mail"], name: "index_companies_tenant_do_not_mail", where: "(marketing_do_not_mail = true)", using: :btree
  add_index "companies", ["tenant_id", "last_refreshed_at", "last_refreshed_version"], name: "companies_refresh_index", using: :btree
  add_index "companies", ["tenant_id", "name", "walk_in", "deleted", "id"], name: "index_search_companies", where: "(NOT deleted)", using: :btree
  add_index "companies", ["tenant_id", "printsmith_id", "dirty"], name: "index_companies_on_tenant_id", using: :btree
  add_index "companies", ["tenant_id", "printsmith_id", "id"], name: "index_companies_tenant_printsmith", using: :btree
  add_index "companies", ["tenant_id", "printsmith_id"], name: "companies_tenant_id_printsmith_id_idx", unique: true, using: :btree
  add_index "companies", ["tenant_id", "rolling_12_month_rank", "rolling_12_month_rank_ly", "name", "sales_rep_user_id", "source_salesrep_id"], name: "index_companies_rank_name_sales_rep", where: "(deleted = false)", using: :btree
  add_index "companies", ["tenant_id", "rolling_12_month_rank"], name: "companies_tenant_id_rolling_12_month_rank_idx", where: "((needs_lifetime_value_recalc = true) AND (deleted = false))", using: :btree
  add_index "companies", ["tenant_id", "rolling_12_month_rank"], name: "index_companies_on_tenant_id_and_rolling_12_month_rank", using: :btree
  add_index "companies", ["tenant_id", "rolling_12_month_rank"], name: "index_companies_on_tenant_id_and_rolling_12_month_rank_partial", where: "((NOT deleted) AND (NOT walk_in))", using: :btree
  add_index "companies", ["tenant_id", "rolling_12_month_sales", "deleted", "id"], name: "index_companies_on_rolling_12_deleted", where: "(deleted = false)", using: :btree
  add_index "companies", ["tenant_id", "rolling_12_month_sales", "deleted", "source_shiptoaddress_id", "sales_rep_user_id", "source_salesrep_id", "id"], name: "index_company_sales", where: "(NOT deleted)", using: :btree
  add_index "companies", ["tenant_id", "rolling_12_month_sales"], name: "companies_tenant_id_rolling_12_month_sales_idx", using: :btree
  add_index "companies", ["tenant_id", "source_billtoaddress_id", "source_shiptoaddress_id", "statement_address_id", "invoice_address_id", "id"], name: "index_companies_on_tenant_address_ids", using: :btree
  add_index "companies", ["tenant_id", "source_salesrep_id", "created_at"], name: "corey_july_1", where: "(source_salesrep_id IS NOT NULL)", using: :btree
  add_index "companies", ["tenant_id", "source_salesrep_id", "id", "sales_rep_user_id", "location_user_id"], name: "index_companies_tenant_id_sales_rep", where: "(source_salesrep_id IS NOT NULL)", using: :btree
  add_index "companies", ["tenant_id", "web", "deleted"], name: "companies_web", where: "(web = true)", using: :btree
  add_index "companies", ["tenant_id"], name: "companies_sales_rep_tagger", where: "((source_salesrep_id IS NULL) AND (sales_rep_user_id IS NOT NULL))", using: :btree
  add_index "companies", ["tenant_id"], name: "companies_tenant_id_idx", where: "(dirty = true)", using: :btree
  add_index "companies", ["tenant_id"], name: "companies_tenant_id_idx1", where: "((needs_avg_conversion_ratio = true) AND (deleted = false))", using: :btree

  create_table "contact_groups", force: :cascade do |t|
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "email",          limit: 255
    t.string   "phone",          limit: 255
    t.integer  "estimate_count",                                      default: 0
    t.integer  "invoice_count",                                       default: 0
    t.decimal  "estimate_total",             precision: 19, scale: 2, default: 0.0
    t.decimal  "invoice_total",              precision: 19, scale: 2, default: 0.0
    t.datetime "first_estimate",             precision: 6
    t.datetime "first_invoice",              precision: 6
    t.datetime "last_estimate",              precision: 6
    t.datetime "last_invoice",               precision: 6
    t.datetime "created_at",                 precision: 6
    t.datetime "updated_at",                 precision: 6
    t.integer  "count",                                               default: 0
    t.integer  "company_id"
    t.integer  "tenant_id"
    t.hstore   "sales_total"
  end

  create_table "contact_groups_contacts", id: false, force: :cascade do |t|
    t.integer "contact_id",       null: false
    t.integer "contact_group_id", null: false
  end

  add_index "contact_groups_contacts", ["contact_id"], name: "index_contact_groups_contacts_on_contact_id", using: :btree

  create_table "contact_list_counts", force: :cascade do |t|
    t.integer "tenant_id"
    t.integer "contact_list_id"
    t.integer "total_count"
    t.decimal "generate_duration"
  end

  create_table "contact_list_exclusions", force: :cascade do |t|
    t.integer "contact_list_id"
    t.integer "contact_id"
    t.integer "tenant_id"
  end

  add_index "contact_list_exclusions", ["contact_id"], name: "index_contact_list_exclusions_on_contact_id", using: :btree
  add_index "contact_list_exclusions", ["contact_list_id"], name: "index_contact_list_exclusions_on_contact_list_id", using: :btree

  create_table "contact_list_rules", force: :cascade do |t|
    t.integer "contact_list_id"
    t.text    "category"
    t.text    "operand"
    t.text    "value"
    t.text    "value2"
    t.text    "modifier",          default: ""
    t.text    "modifier_operand",  default: ""
    t.text    "modifier_value",    default: ""
    t.text    "modifier_value2",   default: ""
    t.boolean "negate",            default: false
    t.integer "sales_rep_id"
    t.integer "taken_by_id"
    t.string  "modifier2"
    t.string  "modifier2_operand"
    t.string  "modifier2_value"
    t.string  "modifier2_value2"
  end

  add_index "contact_list_rules", ["contact_list_id"], name: "index_contact_list_rules_on_contact_list_id", using: :btree

  create_table "contact_lists", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",       precision: 6,                     null: false
    t.datetime "updated_at",       precision: 6,                     null: false
    t.string   "icon"
    t.string   "colour"
    t.string   "description"
    t.integer  "tenant_id"
    t.boolean  "global",                         default: true
    t.boolean  "hide_from_tenant",               default: false
    t.integer  "enterprise_id"
    t.string   "account_type",                   default: "account"
  end

  add_index "contact_lists", ["enterprise_id"], name: "index_contact_lists_on_enterprise_id", using: :btree

  create_table "contact_lists_contacts", id: false, force: :cascade do |t|
    t.integer "contact_id"
    t.integer "contact_list_id"
  end

  add_index "contact_lists_contacts", ["contact_id"], name: "index_contact_lists_contacts_on_contact_id", using: :btree
  add_index "contact_lists_contacts", ["contact_list_id"], name: "index_contact_lists_contacts_on_contact_list_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "company_id"
    t.integer  "printsmith_id"
    t.string   "first_name",                      limit: 255
    t.string   "last_name",                       limit: 255
    t.string   "email",                           limit: 255
    t.string   "phone",                           limit: 255
    t.datetime "created_at",                                  precision: 6
    t.datetime "updated_at",                                  precision: 6
    t.boolean  "dirty"
    t.string   "gender",                          limit: 255
    t.boolean  "temp",                                                                 default: false
    t.integer  "source_address_id"
    t.boolean  "deleted",                                                              default: false
    t.boolean  "ready",                                                                default: false
    t.boolean  "associations_complete",                                                default: false
    t.integer  "assocation_checks",                                                    default: 0
    t.integer  "source_account_id"
    t.boolean  "remote_update_required",                                               default: false
    t.boolean  "in_group",                                                             default: false
    t.integer  "parent_contact_id"
    t.string   "mobile"
    t.string   "fax"
    t.string   "home_phone"
    t.string   "twitter"
    t.string   "other"
    t.string   "facebook"
    t.string   "website"
    t.float    "buy_frequency",                                                        default: 0.0
    t.integer  "days_outside_buy_freq",                                                default: 0
    t.boolean  "marketing_do_not_mail",                                                default: false
    t.boolean  "marketing_unsubscribe",                                                default: false
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.integer  "source_salesrep_id"
    t.integer  "sales_rep_user_id"
    t.integer  "location_user_id"
    t.decimal  "rolling_12_month_sales"
    t.decimal  "rolling_12_month_sales_ly"
    t.datetime "latest_order_date"
    t.decimal  "rolling_12_month_cogs"
    t.string   "marketing_unsubscribe_reason"
    t.boolean  "on_suppression_list",                                                  default: false
    t.decimal  "growth_percentage",                                                    default: 0.0
    t.decimal  "rolling_1_month_sales",                                                default: 0.0
    t.integer  "order_count",                                                          default: 0
    t.integer  "address_id"
    t.decimal  "average_invoice",                                                      default: 0.0
    t.boolean  "has_clearbit_data",                                                    default: false
    t.jsonb    "clearbit_data",                                                        default: {}
    t.jsonb    "custom_data",                                                          default: {}
    t.datetime "last_clearbit_data_fetch_date"
    t.datetime "last_viewed"
    t.string   "guessed_gender"
    t.decimal  "guessed_gender_confidence",                                            default: 0.0
    t.string   "bounced_email_addresses",                                              default: [],                 array: true
    t.datetime "last_contact"
    t.datetime "last_email_sent"
    t.datetime "last_email_received"
    t.datetime "last_phone_call"
    t.decimal  "rolling_12_month_sales_ly_ly",                precision: 19, scale: 2
    t.boolean  "remote_sales_rep_update"
    t.datetime "last_pickup_date"
    t.string   "lead_source"
    t.string   "lead_source_2"
    t.string   "prefix"
    t.string   "suffix"
    t.boolean  "needs_email_remap",                                                    default: false
    t.string   "job_title"
    t.integer  "est_spend"
    t.integer  "conv_prob"
    t.date     "next_activity_date"
    t.string   "next_activity_type"
    t.boolean  "use_contact_address"
    t.integer  "prospect_status_id"
    t.boolean  "needs_email_validation",                                               default: true
    t.integer  "source_inquiry_id"
    t.integer  "email_validation_attempts",                                            default: 0
    t.jsonb    "next_activity",                                                        default: {},    null: false
    t.datetime "oldest_rolling_12_invoice"
    t.datetime "oldest_rolling_12_ly_invoice"
    t.datetime "oldest_rolling_12_ly_ly_invoice"
    t.datetime "oldest_rolling_1_invoice"
    t.integer  "lead_type_id"
    t.boolean  "unsubscribed",                                                         default: false
    t.datetime "last_meeting"
    t.integer  "old_prospect_status_id"
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.datetime "lead_created_at"
    t.string   "external_id"
    t.datetime "single_sale_only_at"
    t.datetime "first_sale_at"
    t.string   "sales_rep_platform_id"
    t.jsonb    "tmp_data",                                                             default: {}
  end

  add_index "contacts", ["associations_complete"], name: "contacts_associations_complete_idx", where: "(associations_complete = false)", using: :btree
  add_index "contacts", ["company_id", "id"], name: "index_contacts_on_company_id", using: :btree
  add_index "contacts", ["has_clearbit_data", "rolling_12_month_sales", "rolling_12_month_sales_ly", "tenant_id", "temp"], name: "index_contacts_clearbit", where: "((has_clearbit_data = false) AND (temp = false))", using: :btree
  add_index "contacts", ["lead_type_id"], name: "index_contacts_on_lead_type_id", using: :btree
  add_index "contacts", ["location_user_id"], name: "index_contacts_on_location_user_id", using: :btree
  add_index "contacts", ["parent_contact_id"], name: "index_contacts_on_parent_contact_id", using: :btree
  add_index "contacts", ["prospect_status_id", "tenant_id", "deleted", "company_id"], name: "index_contacts_prospect_satatus_id", where: "((prospect_status_id IS NOT NULL) AND (deleted <> false))", using: :btree
  add_index "contacts", ["remote_sales_rep_update"], name: "index_contacts_on_remote_sales_rep_update", using: :btree
  add_index "contacts", ["rolling_12_month_sales"], name: "index_contacts_with_rolling_12_month_sales", where: "(rolling_12_month_sales > (0)::numeric)", using: :btree
  add_index "contacts", ["sales_rep_user_id"], name: "index_contacts_on_sales_rep_user_id", using: :btree
  add_index "contacts", ["source_salesrep_id"], name: "index_contacts_on_source_salesrep_id", using: :btree
  add_index "contacts", ["tenant_id", "company_id", "first_name", "last_name", "rolling_12_month_sales"], name: "index_search_contacts", order: {"rolling_12_month_sales"=>:desc}, where: "(NOT temp)", using: :btree
  add_index "contacts", ["tenant_id", "company_id", "latest_order_date", "rolling_12_month_sales", "sales_rep_user_id", "deleted", "temp", "id"], name: "index_contacts_in_latest_order_date_rolling_12_month_sales", order: {"rolling_12_month_sales"=>:desc}, where: "((rolling_12_month_sales > (0)::numeric) AND (deleted <> true) AND (temp = false))", using: :btree
  add_index "contacts", ["tenant_id", "company_id", "rolling_12_month_sales", "first_name", "temp", "deleted", "marketing_do_not_mail", "marketing_unsubscribe", "on_suppression_list", "id"], name: "index_contacts_company_sales_name", order: {"rolling_12_month_sales"=>:desc}, where: "((NOT temp) AND (NOT marketing_do_not_mail) AND (NOT marketing_unsubscribe) AND (NOT on_suppression_list))", using: :btree
  add_index "contacts", ["tenant_id", "company_id", "rolling_12_month_sales", "first_name", "temp", "deleted", "unsubscribed", "id"], name: "index_contacts_company_sales_name_not_unsubbed", order: {"rolling_12_month_sales"=>:desc}, where: "((temp = false) AND (deleted = false) AND (unsubscribed = false))", using: :btree
  add_index "contacts", ["tenant_id", "company_id", "rolling_12_month_sales", "rolling_12_month_sales_ly", "id", "deleted", "temp"], name: "index_contacts_tenant_id_company_sales", where: "(deleted <> true)", using: :btree
  add_index "contacts", ["tenant_id", "deleted", "id", "email", "company_id", "latest_order_date", "source_created_at", "marketing_do_not_mail", "on_suppression_list", "marketing_unsubscribe"], name: "index_contacts_tenant_id_deleted_stats", using: :btree
  add_index "contacts", ["tenant_id", "deleted", "id", "email", "company_id", "latest_order_date", "source_created_at", "unsubscribed"], name: "index_contacts_tenant_deleted_stats", using: :btree
  add_index "contacts", ["tenant_id", "deleted", "id"], name: "corey_july_5", where: "(company_id IS NULL)", using: :btree
  add_index "contacts", ["tenant_id", "deleted"], name: "contacts_prospect_status_id", where: "(prospect_status_id IS NOT NULL)", using: :btree
  add_index "contacts", ["tenant_id", "dirty", "printsmith_id", "company_id"], name: "index_company_dirty", using: :btree
  add_index "contacts", ["tenant_id", "email", "id"], name: "index_contacts_tenant_lower_email_id", using: :btree
  add_index "contacts", ["tenant_id", "email", "on_suppression_list", "id"], name: "index_contacts_tenant_trimmed_email", using: :btree
  add_index "contacts", ["tenant_id", "id", "rolling_12_month_sales", "first_name", "company_id", "deleted", "email", "temp", "marketing_do_not_mail", "marketing_unsubscribe", "on_suppression_list"], name: "contacts_tenant_id_where_emailable", order: {"rolling_12_month_sales"=>:desc}, where: "((NOT temp) AND (NOT marketing_do_not_mail) AND (NOT marketing_unsubscribe) AND (NOT on_suppression_list) AND ((email)::text ~~ '%@%'::text))", using: :btree
  add_index "contacts", ["tenant_id", "id", "rolling_12_month_sales", "first_name", "company_id", "deleted", "email", "temp", "unsubscribed"], name: "index_contacts_tenant_not_unsubbed_with_email", order: {"rolling_12_month_sales"=>:desc}, where: "((temp = false) AND (deleted = false) AND (unsubscribed = false) AND ((email)::text ~~ '%@%'::text))", using: :btree
  add_index "contacts", ["tenant_id", "latest_order_date"], name: "contacts_tenant_id_latest_order_date_idx", using: :btree
  add_index "contacts", ["tenant_id", "marketing_do_not_mail", "marketing_unsubscribe", "on_suppression_list", "id"], name: "index_contacts_on_tenant_marketing", where: "((marketing_do_not_mail = false) AND ((marketing_unsubscribe = true) OR (on_suppression_list = true)))", using: :btree
  add_index "contacts", ["tenant_id", "needs_email_validation", "company_id", "tenant_id", "on_suppression_list", "marketing_do_not_mail", "deleted", "temp"], name: "index_contacts_email_validations", where: "((on_suppression_list = false) AND (marketing_do_not_mail = false) AND (deleted = false))", using: :btree
  add_index "contacts", ["tenant_id", "needs_email_validation", "company_id", "tenant_id", "unsubscribed", "deleted", "temp"], name: "index_contacts_email_validations_not_unsubbed", where: "((deleted = false) AND (unsubscribed = false))", using: :btree
  add_index "contacts", ["tenant_id", "oldest_rolling_1_invoice", "oldest_rolling_12_invoice", "oldest_rolling_12_ly_invoice", "oldest_rolling_12_ly_ly_invoice", "id"], name: "index_contacts_rolling_invoices", where: "((oldest_rolling_1_invoice IS NOT NULL) OR (oldest_rolling_12_invoice IS NOT NULL) OR (oldest_rolling_12_ly_invoice IS NOT NULL) OR (oldest_rolling_12_ly_ly_invoice IS NOT NULL))", using: :btree
  add_index "contacts", ["tenant_id", "oldest_rolling_1_invoice", "oldest_rolling_12_invoice", "oldest_rolling_12_ly_invoice", "oldest_rolling_12_ly_ly_invoice", "id"], name: "index_contacts_tenant_oldest_rolling", where: "((oldest_rolling_1_invoice IS NOT NULL) OR (oldest_rolling_12_invoice IS NOT NULL) OR (oldest_rolling_12_ly_invoice IS NOT NULL) OR (oldest_rolling_12_ly_ly_invoice IS NOT NULL))", using: :btree
  add_index "contacts", ["tenant_id", "printsmith_id", "id"], name: "index_contacts_tenant_printsmith", using: :btree
  add_index "contacts", ["tenant_id", "printsmith_id"], name: "contacts_tenant_id_printsmith_id_idx", unique: true, using: :btree
  add_index "contacts", ["tenant_id", "rolling_12_month_sales"], name: "contacts_tenant_id_rolling_12_month_sales_idx1", using: :btree
  add_index "contacts", ["tenant_id", "rolling_12_month_sales"], name: "tmp_fix_10", order: {"rolling_12_month_sales"=>:desc}, where: "(guessed_gender IS NULL)", using: :btree
  add_index "contacts", ["tenant_id", "source_salesrep_id", "id", "sales_rep_user_id", "location_user_id"], name: "index_contacts_tenant_id_sales_rep", where: "(source_salesrep_id IS NOT NULL)", using: :btree
  add_index "contacts", ["tenant_id", "unsubscribed", "deleted", "temp", "needs_email_validation", "company_id"], name: "index_contacts_tenant_unsubscribed", where: "((unsubscribed = false) AND (deleted = false) AND (temp = false))", using: :btree
  add_index "contacts", ["tenant_id", "unsubscribed", "id"], name: "index_contacts_tenant_unsubbed", where: "(unsubscribed = true)", using: :btree
  add_index "contacts", ["tenant_id"], name: "contact_sales_rep_tagger", where: "((source_salesrep_id IS NULL) AND (sales_rep_user_id IS NOT NULL))", using: :btree
  add_index "contacts", ["tenant_id"], name: "contacts_tenant_id_idx", where: "(remote_update_required = true)", using: :btree
  add_index "contacts", ["tenant_id"], name: "contacts_tenant_id_idx1", where: "((rolling_12_month_sales > (1)::numeric) AND (temp = false) AND (deleted = false))", using: :btree
  add_index "contacts", ["tenant_id"], name: "contacts_tenant_id_lower_idx", using: :btree
  add_index "contacts", ["tenant_id"], name: "contacts_tenant_id_where_contactable", where: "((NOT temp) AND (NOT deleted) AND (NOT marketing_do_not_mail) AND (NOT marketing_unsubscribe) AND (NOT on_suppression_list))", using: :btree
  add_index "contacts", ["tenant_id"], name: "corey_july_6", where: "((source_address_id IS NOT NULL) AND (address_id IS NULL))", using: :btree
  add_index "contacts", ["tenant_id"], name: "index_contacts_retry_sales_rep_update", where: "(remote_sales_rep_update = true)", using: :btree
  add_index "contacts", ["tenant_id"], name: "index_contacts_tenant_not_unsubbed", where: "((temp = false) AND (deleted = false) AND (unsubscribed = false))", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "countries_enterprises", id: false, force: :cascade do |t|
    t.integer "country_id",    null: false
    t.integer "enterprise_id", null: false
  end

  add_index "countries_enterprises", ["country_id", "enterprise_id"], name: "index_countries_enterprises", using: :btree

  create_table "country_states", force: :cascade do |t|
    t.integer "country_id"
    t.string  "name"
  end

  add_index "country_states", ["country_id"], name: "index_country_states_on_country_id", using: :btree

  create_table "country_states_holidays", id: false, force: :cascade do |t|
    t.integer "holiday_id",       null: false
    t.integer "country_state_id", null: false
  end

  add_index "country_states_holidays", ["holiday_id", "country_state_id"], name: "index_holidays_country_states", using: :btree

  create_table "deployments", force: :cascade do |t|
    t.text     "name"
    t.text     "os"
    t.text     "checksum"
    t.text     "version"
    t.text     "built_on"
    t.text     "address"
    t.integer  "tenant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "deployments", ["tenant_id"], name: "index_deployments_on_tenant_id", using: :btree

  create_table "email_aliases", force: :cascade do |t|
    t.integer "user_id"
    t.string  "email"
  end

  create_table "email_credentials", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "tenant_id",                  null: false
    t.integer  "enterprise_id",              null: false
    t.string   "platform",                   null: false
    t.jsonb    "credentials",   default: {}
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "email_deliveries", force: :cascade do |t|
    t.jsonb "message", default: {}, null: false
  end

  create_table "email_message_activities", force: :cascade do |t|
    t.integer  "email_inbox_id"
    t.integer  "last_email_message_id"
    t.datetime "last_scan"
    t.integer  "forward_scan_id"
    t.integer  "reverse_scan_id"
  end

  create_table "email_soft_bounces", force: :cascade do |t|
    t.integer "tenant_id"
    t.string  "email_address"
    t.integer "soft_bounce_count", default: 0
  end

  add_index "email_soft_bounces", ["email_address"], name: "index_email_soft_bounces_on_email_address", using: :btree
  add_index "email_soft_bounces", ["tenant_id", "soft_bounce_count", "email_address"], name: "index_email_soft_bounces_count", where: "(soft_bounce_count >= 3)", using: :btree

  create_table "email_statuses", force: :cascade do |t|
    t.string   "email_address"
    t.integer  "status"
    t.text     "info"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "email_tags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.string   "label_id"
    t.string   "name"
    t.string   "label_type"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  add_index "email_tags", ["label_id"], name: "index_email_tags_on_label_id", using: :btree
  add_index "email_tags", ["label_type"], name: "index_email_tags_on_label_type", using: :btree
  add_index "email_tags", ["name"], name: "index_email_tags_on_name", using: :btree
  add_index "email_tags", ["tenant_id"], name: "index_email_tags_on_tenant_id", using: :btree
  add_index "email_tags", ["user_id"], name: "index_email_tags_on_user_id", using: :btree

  create_table "email_tags_emails", id: false, force: :cascade do |t|
    t.integer "email_id",     null: false
    t.integer "email_tag_id", null: false
  end

  add_index "email_tags_emails", ["email_id", "email_tag_id"], name: "index_email_tags_emails_on_email_id_and_email_tag_id", unique: true, using: :btree

  create_table "email_template_categories", force: :cascade do |t|
    t.integer "email_template_id"
    t.integer "category"
  end

  create_table "email_template_fields", force: :cascade do |t|
    t.integer "email_template_id"
    t.text    "name"
    t.boolean "required",          default: false
  end

  create_table "email_template_values", force: :cascade do |t|
    t.integer "email_template_field_id"
    t.integer "element_id"
    t.string  "element_type"
    t.string  "value"
    t.integer "tenant_id"
  end

  create_table "email_templates", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.boolean  "global",                                                  default: false
    t.string   "name",                          limit: 255
    t.string   "subject",                       limit: 255
    t.text     "body"
    t.datetime "created_at",                                precision: 6
    t.datetime "updated_at",                                precision: 6
    t.text     "key"
    t.boolean  "shell",                                                   default: false
    t.integer  "wrapper_id"
    t.boolean  "hidden",                                                  default: false
    t.integer  "enterprise_id"
    t.boolean  "auto_cc",                                                 default: false
    t.boolean  "auto_cc_sales_rep",                                       default: false
    t.boolean  "archived",                                                default: false
    t.integer  "production_location_id"
    t.boolean  "default_attach",                                          default: false
    t.integer  "copied_email_template_id",                                default: 0
    t.integer  "copied_similarity",                                       default: 0
    t.integer  "copied_root_email_template_id",                           default: 0
    t.integer  "copied_depth",                                            default: 0
    t.integer  "root_similarity",                                         default: 0
    t.boolean  "use_roboto"
  end

  add_index "email_templates", ["tenant_id"], name: "index_email_templates_on_tenant_id", using: :btree
  add_index "email_templates", ["user_id"], name: "index_email_templates_on_user_id", using: :btree

  create_table "email_validations", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "enterprise_id"
    t.integer  "contact_id"
    t.string   "address"
    t.string   "code"
    t.integer  "parent_id",      default: 0
    t.boolean  "fixed",          default: false
    t.boolean  "rescan_needed",  default: false
    t.boolean  "pending_rescan", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "email_validations", ["contact_id", "created_at", "tenant_id", "enterprise_id", "code"], name: "index_email_validations_contact_created", order: {"created_at"=>:desc}, using: :btree
  add_index "email_validations", ["tenant_id", "enterprise_id", "contact_id", "created_at", "code"], name: "index_email_validations_tenant_id", order: {"created_at"=>:desc}, using: :btree

  create_table "emails", force: :cascade do |t|
    t.text     "to"
    t.text     "from"
    t.boolean  "read"
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.string   "direction",                       limit: 255
    t.integer  "context_id"
    t.string   "context_type",                    limit: 255
    t.text     "subject"
    t.text     "body"
    t.datetime "created_at",                                  precision: 6
    t.datetime "updated_at",                                  precision: 6
    t.string   "email_id"
    t.string   "thread_id"
    t.boolean  "processed",                                                 default: false
    t.boolean  "deleted",                                                   default: false
    t.text     "labels"
    t.integer  "sending_as_user_id"
    t.string   "cc"
    t.string   "attachment_uuid"
    t.boolean  "test",                                                      default: false
    t.string   "bcc"
    t.string   "failed_reason"
    t.string   "message_id"
    t.datetime "error_backoff"
    t.boolean  "bulk"
    t.integer  "prospect_status_item_contact_id"
  end

  add_index "emails", ["context_id", "context_type"], name: "index_emails_on_context_id_and_context_type", using: :btree
  add_index "emails", ["created_at"], name: "emails_created_at_idx", where: "(processed = false)", using: :btree
  add_index "emails", ["from_user_id"], name: "index_emails_on_from_user_id", using: :btree
  add_index "emails", ["message_id"], name: "emails_message_id_idx", using: :btree
  add_index "emails", ["tenant_id", "email_id"], name: "emails_tenant_id_email_id_idx", using: :btree
  add_index "emails", ["thread_id", "id"], name: "index_emails_on_thread_id_and_id", using: :btree
  add_index "emails", ["to_user_id"], name: "index_emails_on_to_user_id", using: :btree
  add_index "emails", ["user_id"], name: "index_emails_on_user_id", using: :btree

  create_table "emails_trackers", id: false, force: :cascade do |t|
    t.integer "email_id"
    t.integer "tracker_id"
  end

  add_index "emails_trackers", ["tracker_id"], name: "index_email_trackers_tacker", using: :btree

  create_table "enterprise_salestargets", force: :cascade do |t|
    t.integer "prospect_status_id"
    t.integer "enterprise_id"
    t.integer "amount"
    t.integer "items"
    t.integer "lead_type_id"
  end

  add_index "enterprise_salestargets", ["lead_type_id"], name: "index_enterprise_salestargets_on_lead_type_id", using: :btree

  create_table "enterprise_togglefields", force: :cascade do |t|
    t.integer "enterprise_id"
    t.string  "field",         limit: 40
    t.boolean "read_only",                default: false
  end

  create_table "enterprises", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.boolean  "show_eula",                            default: false
    t.text     "eula_body"
    t.string   "setup_user"
    t.string   "setup_password"
    t.string   "campaign_test_address"
    t.text     "unsubscribe_template"
    t.integer  "banner_id"
    t.integer  "default_email_template_id",            default: 0
    t.string   "campaign_approval_address"
    t.string   "intercom_app_id"
    t.string   "freshchat_token"
    t.integer  "portal_estimate_comment_template_id"
    t.integer  "portal_estimate_approved_template_id"
    t.integer  "portal_estimate_canceled_template_id"
    t.text     "portal_estimate_copy"
    t.integer  "default_company_emailt_id"
    t.integer  "default_contact_emailt_id"
    t.integer  "default_estimate_emailt_id"
    t.integer  "default_order_emailt_id"
    t.integer  "default_sale_emailt_id"
    t.string   "currency_locale"
    t.text     "statement_template_name"
    t.text     "statement_template"
    t.text     "pdf_gen_link"
    t.integer  "default_salestarget_amount"
    t.integer  "default_salestarget_number"
    t.datetime "deleted_at"
    t.string   "api_token"
    t.integer  "default_inquiry_emailt_id"
    t.string   "connection_type",                      default: "printsmith"
    t.string   "locale",                               default: "en",         null: false
    t.integer  "portal_proof_comment_template_id"
    t.integer  "portal_proof_approved_template_id"
    t.text     "portal_proof_copy"
    t.jsonb    "brand_colors",                         default: {}
    t.boolean  "default_roboto_font"
    t.string   "platform_type"
    t.boolean  "agi_brand"
    t.boolean  "show_language",                        default: false
    t.integer  "default_shipment_emailt_id"
  end

  create_table "estimate_elements", force: :cascade do |t|
    t.integer  "estimate_id"
    t.integer  "element_id"
    t.string   "element_type", limit: 255
    t.datetime "created_at",               precision: 6
    t.datetime "updated_at",               precision: 6
    t.integer  "tenant_id"
  end

  add_index "estimate_elements", ["element_id", "element_type"], name: "index_estimate_elements_on_element_id_and_element_type", using: :btree
  add_index "estimate_elements", ["estimate_id"], name: "index_estimate_elements_on_estimate_id", using: :btree
  add_index "estimate_elements", ["tenant_id"], name: "index_estimate_elements_on_tenant_id", using: :btree

  create_table "estimates", force: :cascade do |t|
    t.text     "name"
    t.integer  "tenant_id"
    t.datetime "created_at",                           precision: 6
    t.datetime "updated_at",                           precision: 6
    t.decimal  "grand_total",                          precision: 19, scale: 2
    t.integer  "printsmith_id",            limit: 8
    t.integer  "company_id"
    t.string   "status",                   limit: 255
    t.datetime "deleted_at",                           precision: 6
    t.boolean  "on_pending_list"
    t.datetime "wanted_by",                            precision: 6
    t.datetime "off_pending_date",                     precision: 6
    t.datetime "reorder_date",                         precision: 6
    t.integer  "salesrep_id"
    t.integer  "notes_id",                 limit: 8
    t.integer  "special_instructions_id",  limit: 8
    t.integer  "documentlocation_id",      limit: 8
    t.decimal  "total_cost",                           precision: 19, scale: 2
    t.string   "source_taken_by",          limit: 255
    t.string   "created_by",               limit: 255
    t.string   "customer_po",              limit: 255
    t.text     "estimate_notes"
    t.string   "invoice_number",           limit: 255
    t.decimal  "price_sub_total",                      precision: 19, scale: 2
    t.decimal  "price_total",                          precision: 19, scale: 2
    t.boolean  "costed"
    t.boolean  "firm_wanted_by_date"
    t.boolean  "dirty"
    t.integer  "contact_id"
    t.integer  "source_estimate_id",       limit: 8
    t.integer  "source_invoice_id",        limit: 8
    t.boolean  "voided"
    t.integer  "converted_invoice_id",     limit: 8
    t.integer  "converted_invoice_number", limit: 8
    t.integer  "source_estimate_number",   limit: 8
    t.integer  "source_invoice_number",    limit: 8
    t.boolean  "actioned",                                                      default: false
    t.decimal  "tax",                                  precision: 19, scale: 2
    t.decimal  "grand_total_inc_tax",                  precision: 19, scale: 2
    t.boolean  "overdue_actioned",                                              default: false
    t.boolean  "needs_pdf",                                                     default: true
    t.string   "key"
    t.datetime "ordered_date",                         precision: 6
    t.boolean  "deleted",                                                       default: false
    t.boolean  "ready",                                                         default: false
    t.boolean  "associations_complete",                                         default: false
    t.integer  "assocation_checks",                                             default: 0
    t.integer  "source_account_id",        limit: 8
    t.integer  "source_contact_id",        limit: 8
    t.integer  "production_location_id"
    t.string   "public_token"
    t.text     "instructions"
    t.string   "workflow_status"
    t.datetime "follow_up_date",                       precision: 6
    t.integer  "follow_up_count"
    t.boolean  "remote_update_required",                                        default: false
    t.string   "reason"
    t.integer  "pdf_id"
    t.datetime "source_created_at",                    precision: 6
    t.datetime "source_updated_at",                    precision: 6
    t.integer  "taken_by_id"
    t.integer  "contact_group_id"
    t.decimal  "rounded_amount",                       precision: 19, scale: 2
    t.integer  "taken_by_user_id"
    t.integer  "sales_rep_user_id"
    t.integer  "location_user_id"
    t.string   "report_name"
    t.integer  "pdf_error_count",                                               default: 0
    t.boolean  "retry_location_update",                                         default: false
    t.datetime "archived_at"
    t.integer  "archived_user_id"
    t.boolean  "retry_archive",                                                 default: false
    t.integer  "parent_contact_id"
    t.string   "reason_value"
    t.boolean  "dirty_skip_pdf",                                                default: false
    t.text     "job_descriptions"
    t.datetime "last_refreshed_at"
    t.datetime "proof_by"
    t.boolean  "web"
    t.integer  "holdstate_id"
    t.string   "portal_key"
    t.string   "approval_status"
    t.boolean  "remote_sales_rep_update"
    t.boolean  "remote_proof_by_update"
    t.boolean  "retry_convert_update"
    t.integer  "inquiry_id"
    t.boolean  "inquiry_auto"
    t.boolean  "converted",                                                     default: false
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.string   "sales_rep_platform_id"
    t.jsonb    "tmp_data",                                                      default: {}
  end

  add_index "estimates", ["company_id", "id"], name: "index_estimates_on_company_id", using: :btree
  add_index "estimates", ["contact_id"], name: "index_estimates_on_contact_id", using: :btree
  add_index "estimates", ["dirty_skip_pdf"], name: "index_estimates_on_dirty_skip_pdf", using: :btree
  add_index "estimates", ["inquiry_id"], name: "index_estimates_on_inquiry_id", using: :btree
  add_index "estimates", ["location_user_id"], name: "index_estimates_on_location_user_id", using: :btree
  add_index "estimates", ["ordered_date", "tenant_id", "grand_total", "voided", "deleted"], name: "index_estimates_ordered_date_tenant_id", where: "((NOT voided) AND (NOT deleted))", using: :btree
  add_index "estimates", ["portal_key"], name: "index_estimates_portal_key", using: :btree
  add_index "estimates", ["printsmith_id"], name: "index_estimates_on_printsmith_id", using: :btree
  add_index "estimates", ["remote_proof_by_update"], name: "index_estimates_on_remote_proof_by_update", using: :btree
  add_index "estimates", ["remote_sales_rep_update"], name: "index_estimates_on_remote_sales_rep_update", using: :btree
  add_index "estimates", ["sales_rep_user_id"], name: "index_estimates_on_sales_rep_user_id", using: :btree
  add_index "estimates", ["taken_by_user_id"], name: "index_estimates_on_taken_by_user_id", using: :btree
  add_index "estimates", ["tenant_id", "company_id", "contact_id", "id"], name: "index_estimates_id_company_contact", using: :btree
  add_index "estimates", ["tenant_id", "company_id", "source_account_id", "created_at", "id"], name: "index_estimates_tenant_company_source_account", order: {"created_at"=>:desc}, where: "(source_account_id IS NOT NULL)", using: :btree
  add_index "estimates", ["tenant_id", "contact_id", "ordered_date", "grand_total", "voided", "deleted", "id"], name: "index_estimates_tenant_stats", where: "((voided = false) AND (deleted = false))", using: :btree
  add_index "estimates", ["tenant_id", "contact_id", "source_contact_id", "created_at", "id"], name: "index_estimates_tenant_company_source_contact", order: {"created_at"=>:desc}, where: "(source_contact_id IS NOT NULL)", using: :btree
  add_index "estimates", ["tenant_id", "created_at", "associations_complete", "dirty"], name: "estimates_index", using: :btree
  add_index "estimates", ["tenant_id", "created_at"], name: "estimates_tenant_id_created_at_idx", order: {"created_at"=>:desc}, where: "(associations_complete = false)", using: :btree
  add_index "estimates", ["tenant_id", "invoice_number", "deleted", "voided"], name: "estimates_invoice_number", using: :btree
  add_index "estimates", ["tenant_id", "invoice_number", "voided", "deleted", "name", "id"], name: "index_search_estimates", where: "((NOT deleted) AND (NOT voided))", using: :btree
  add_index "estimates", ["tenant_id", "job_descriptions"], name: "estimates_tenant_id_gin_job_desc", using: :gin
  add_index "estimates", ["tenant_id", "name"], name: "estimates_tenant_id_gin_name", using: :gin
  add_index "estimates", ["tenant_id", "off_pending_date"], name: "estimates_tenant_id_off_pending_date_idx", using: :btree
  add_index "estimates", ["tenant_id", "production_location_id", "on_pending_list", "id"], name: "index_estimates_tenant_production_location", where: "(on_pending_list IS TRUE)", using: :btree
  add_index "estimates", ["tenant_id", "salesrep_id", "id", "sales_rep_user_id", "location_user_id"], name: "index_estimates_tenant_id_sales_rep", where: "(salesrep_id IS NOT NULL)", using: :btree
  add_index "estimates", ["tenant_id", "source_taken_by", "id", "taken_by_user_id"], name: "index_estimates_tenant_id_taken_by", where: "(source_taken_by IS NOT NULL)", using: :btree
  add_index "estimates", ["tenant_id", "source_taken_by", "source_created_at"], name: "index_estimates_on_tenant_stakenby_screatedat", using: :btree
  add_index "estimates", ["tenant_id", "source_updated_at"], name: "estimates_tenant_id_source_updated_at_asc", where: "(source_updated_at >= '2014-01-01 00:00:00'::timestamp without time zone)", using: :btree
  add_index "estimates", ["tenant_id", "status", "deleted", "voided"], name: "index_estimates_status", where: "((NOT deleted) AND (NOT voided))", using: :btree
  add_index "estimates", ["tenant_id", "taken_by_user_id", "ordered_date", "status", "deleted", "voided", "id"], name: "index_estimates_tenant_taken_by_ordered_date_status", where: "((voided = false) AND (deleted = false))", using: :btree
  add_index "estimates", ["tenant_id", "updated_at", "voided", "deleted"], name: "estimates_retry_convert", where: "(retry_convert_update = true)", using: :btree
  add_index "estimates", ["tenant_id", "voided", "deleted"], name: "index_estimates_retry_sales_rep_update", where: "(remote_sales_rep_update = true)", using: :btree
  add_index "estimates", ["tenant_id"], name: "corey_july_3", where: "(company_id IS NOT NULL)", using: :btree
  add_index "estimates", ["tenant_id"], name: "estimates_dirty_skip_pdf_index", where: "(dirty_skip_pdf = true)", using: :btree
  add_index "estimates", ["tenant_id"], name: "estimates_retry_archive_index", where: "((voided = false) AND (deleted = false) AND (retry_archive = true))", using: :btree
  add_index "estimates", ["tenant_id"], name: "estimates_tenant_id_idx", where: "(dirty = true)", using: :btree
  add_index "estimates", ["tenant_id"], name: "estimates_tenant_id_idx1", where: "((remote_update_required = true) AND (voided = false) AND (deleted = false))", using: :btree
  add_index "estimates", ["tenant_id"], name: "estimates_tenant_id_idx2", where: "((voided = false) AND (deleted = false) AND (retry_location_update = true))", using: :btree
  add_index "estimates", ["tenant_id"], name: "index_estimates_on_pending_list", where: "(on_pending_list = true)", using: :btree

  create_table "etl_settings", force: :cascade do |t|
    t.integer  "tenant_id"
    t.string   "klass",               limit: 255
    t.string   "last_created_at",     limit: 255
    t.string   "last_updated_at",     limit: 255
    t.datetime "created_at",                      precision: 6
    t.datetime "updated_at",                      precision: 6
    t.integer  "last_created_id",                               default: 0
    t.integer  "last_updated_id",                               default: 0
    t.integer  "last_created_count"
    t.integer  "last_updated_count"
    t.integer  "last_created_offset",                           default: 0
    t.integer  "last_updated_offset",                           default: 0
  end

  add_index "etl_settings", ["tenant_id", "klass"], name: "tenant_id_klass", unique: true, using: :btree

  create_table "event_stats", force: :cascade do |t|
    t.integer  "tenant_id"
    t.string   "event_type"
    t.jsonb    "data"
    t.decimal  "duration"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_stats", ["created_at"], name: "index_event_stats_on_created_at", using: :btree
  add_index "event_stats", ["tenant_id", "event_type", "data", "source", "duration"], name: "index_event_stats_on_tenant_event_data_source_duration", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "tenant_id"
    t.string   "event_type"
    t.string   "status",        default: "queued"
    t.jsonb    "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "schedule_date"
    t.string   "source"
  end

  add_index "events", ["created_at", "status", "id"], name: "index_events_created_status_queued", where: "((status)::text = 'queued'::text)", using: :btree
  add_index "events", ["status", "schedule_date", "id"], name: "index_events_status_scheduled", where: "((status)::text = 'scheduled'::text)", using: :btree
  add_index "events", ["status", "updated_at", "id"], name: "index_events_status_running", where: "((status)::text = 'running'::text)", using: :btree
  add_index "events", ["tenant_id", "event_type", "data", "status", "id"], name: "index_events_tenant_type_data", using: :btree

  create_table "exclusions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "exclusions", ["context_id", "user_id"], name: "exclusions_context_id_user_id_idx", using: :btree

  create_table "filter_defaults", force: :cascade do |t|
    t.integer "user_id"
    t.integer "context_id"
    t.string  "context_type"
    t.string  "section"
    t.integer "tenant_id"
  end

  add_index "filter_defaults", ["tenant_id"], name: "index_filter_defaults_on_tenant_id", using: :btree
  add_index "filter_defaults", ["user_id"], name: "index_filter_defaults_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "group_type",    limit: 255
    t.datetime "created_at",                precision: 6
    t.datetime "updated_at",                precision: 6
    t.boolean  "default",                                 default: false
    t.integer  "enterprise_id"
  end

  add_index "groups", ["enterprise_id"], name: "index_groups_on_enterprise_id", using: :btree

  create_table "groups_tenants", id: false, force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "group_id",  null: false
  end

  add_index "groups_tenants", ["group_id"], name: "index_groups_tenants_on_group_id", using: :btree
  add_index "groups_tenants", ["tenant_id", "group_id"], name: "index_groups_tenants_on_tenant_id_and_group_id", using: :btree

  create_table "hidden_email_templates", force: :cascade do |t|
    t.integer "email_template_id"
    t.integer "tenant_id"
  end

  create_table "hidden_holidays", force: :cascade do |t|
    t.integer "holiday_id"
    t.integer "tenant_id"
  end

  create_table "hidden_lead_types", force: :cascade do |t|
    t.integer "lead_type_id"
    t.integer "tenant_id"
  end

  create_table "hidden_task_types", force: :cascade do |t|
    t.integer "task_type_id"
    t.integer "tenant_id"
  end

  create_table "holiday_dates", force: :cascade do |t|
    t.integer "holiday_id"
    t.date    "date"
  end

  add_index "holiday_dates", ["holiday_id"], name: "index_holiday_dates_on_holiday_id", using: :btree

  create_table "holidays", force: :cascade do |t|
    t.string   "state",         limit: 255
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.string   "name",          limit: 255
    t.datetime "created_at",                precision: 6
    t.datetime "updated_at",                precision: 6
    t.integer  "tenant_id"
    t.boolean  "global",                                  default: false
    t.integer  "user_id"
    t.integer  "enterprise_id"
  end

  add_index "holidays", ["enterprise_id"], name: "index_holidays_on_enterprise_id", using: :btree
  add_index "holidays", ["tenant_id"], name: "index_holidays_on_tenant_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "tenant_id"
    t.string   "email_marketing"
    t.string   "contact_name"
    t.string   "name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.datetime "last_validated"
    t.boolean  "default",           default: false
    t.string   "phone"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "suburb"
    t.string   "state"
    t.string   "postcode"
    t.text     "business_hours"
    t.string   "website"
    t.string   "marketing_name"
    t.string   "holiday_last_day"
    t.string   "holiday_returning"
    t.string   "website_url"
    t.string   "request_quote_url"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "pinterest"
    t.string   "review_url"
    t.string   "number"
    t.string   "blog"
    t.string   "linked_in"
    t.string   "youtube"
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "from_name"
    t.string   "from_email"
    t.text     "description"
    t.integer  "user_id"
    t.boolean  "pinned",                default: false
    t.integer  "priority",              default: 1
    t.integer  "inquiry_type"
    t.integer  "tenant_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "postcode"
    t.string   "phone"
    t.string   "company_name"
    t.integer  "company_id"
    t.datetime "replied"
    t.integer  "contact_id"
    t.integer  "lead_type_id"
    t.string   "lead_source"
    t.boolean  "active_inquiry",        default: false
    t.string   "invoice_number"
    t.integer  "inquiry_status",        default: 0
    t.string   "notification_ids",      default: [],                 array: true
    t.integer  "salesrep_id"
    t.string   "lost_reason"
    t.integer  "unique_id"
    t.integer  "location_user_id"
    t.boolean  "has_asset"
    t.integer  "inquiry_identifier"
    t.string   "sales_rep_platform_id"
    t.jsonb    "tmp_data",              default: {}
  end

  add_index "inquiries", ["tenant_id"], name: "index_inquiries_on_tenant_id", using: :btree
  add_index "inquiries", ["unique_id", "tenant_id"], name: "index_inquiries_on_unique_id_and_tenant_id", unique: true, using: :btree

  create_table "inquiry_attachments", force: :cascade do |t|
    t.integer "inquiry_id"
    t.string  "name"
    t.string  "url"
  end

  add_index "inquiry_attachments", ["inquiry_id"], name: "index_inquiry_attachments_on_inquiry_id", using: :btree

  create_table "interest_categories", force: :cascade do |t|
    t.string  "name"
    t.integer "enterprise_id"
    t.integer "interest_type"
  end

  add_index "interest_categories", ["enterprise_id"], name: "index_interest_categories_on_enterprise_id", using: :btree

  create_table "interest_contexts", force: :cascade do |t|
    t.integer  "interest_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "interest_type"
  end

  add_index "interest_contexts", ["tenant_id"], name: "index_interest_contexts_on_tenant_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
    t.integer "interest_category_id"
  end

  add_index "interests", ["interest_category_id"], name: "index_interests_on_interest_category_id", using: :btree

  create_table "invoice_elements", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "element_id"
    t.integer  "tenant_id"
    t.string   "element_type"
    t.datetime "created_at",   precision: 6
    t.datetime "updated_at",   precision: 6
  end

  add_index "invoice_elements", ["element_id", "element_type"], name: "index_invoice_elements_on_element_id_and_element_type", using: :btree
  add_index "invoice_elements", ["tenant_id"], name: "index_invoice_elements_on_tenant_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.text     "name"
    t.decimal  "grand_total",                            precision: 19, scale: 2
    t.integer  "printsmith_id",              limit: 8
    t.integer  "tenant_id"
    t.integer  "company_id"
    t.datetime "created_at",                             precision: 6
    t.datetime "updated_at",                             precision: 6
    t.datetime "deleted_at",                             precision: 6
    t.boolean  "completed"
    t.datetime "pickup_date",                            precision: 6
    t.datetime "wanted_by",                              precision: 6
    t.datetime "off_pending_date",                       precision: 6
    t.datetime "reorder_date",                           precision: 6
    t.integer  "salesrep_id"
    t.integer  "notes_id",                   limit: 8
    t.integer  "special_instructions_id",    limit: 8
    t.integer  "documentlocation_id",        limit: 8
    t.decimal  "total_cost",                             precision: 19, scale: 2
    t.string   "source_taken_by",            limit: 255
    t.string   "created_by",                 limit: 255
    t.string   "customer_po",                limit: 255
    t.string   "estimate_notes",             limit: 255
    t.string   "invoice_number",             limit: 255
    t.decimal  "price_sub_total",                        precision: 19, scale: 2
    t.decimal  "price_total",                            precision: 19, scale: 2
    t.boolean  "costed"
    t.boolean  "firm_wanted_by_date"
    t.boolean  "on_pending_list"
    t.integer  "production_location_id"
    t.boolean  "dirty"
    t.integer  "contact_id"
    t.integer  "source_invoice_id",          limit: 8
    t.integer  "source_estimate_id",         limit: 8
    t.boolean  "voided"
    t.integer  "converted_invoice_number",   limit: 8
    t.integer  "source_invoice_number",      limit: 8
    t.integer  "source_estimate_number",     limit: 8
    t.decimal  "tax",                                    precision: 19, scale: 2
    t.decimal  "grand_total_inc_tax",                    precision: 19, scale: 2
    t.boolean  "overdue_actioned",                                                default: false
    t.string   "key"
    t.boolean  "needs_pdf",                                                       default: true
    t.datetime "ordered_date",                           precision: 6
    t.boolean  "ready",                                                           default: false
    t.boolean  "associations_complete",                                           default: false
    t.integer  "assocation_checks",                                               default: 0
    t.integer  "source_contact_id",          limit: 8
    t.integer  "source_account_id",          limit: 8
    t.boolean  "deleted",                                                         default: false
    t.string   "public_token"
    t.text     "instructions"
    t.datetime "source_created_at",                      precision: 6
    t.datetime "source_updated_at",                      precision: 6
    t.integer  "pdf_id"
    t.integer  "accounting_month"
    t.integer  "accounting_year"
    t.integer  "sales_summary_id"
    t.integer  "taken_by_id"
    t.integer  "contact_group_id"
    t.decimal  "rounded_amount",                         precision: 19, scale: 2
    t.integer  "daily_accounting_day"
    t.integer  "daily_accounting_month"
    t.integer  "daily_accounting_year"
    t.integer  "daily_sales_summary_id"
    t.integer  "taken_by_user_id"
    t.integer  "sales_rep_user_id"
    t.integer  "location_user_id"
    t.string   "report_name"
    t.boolean  "remote_update_required"
    t.integer  "pdf_error_count",                                                 default: 0
    t.boolean  "retry_location_update",                                           default: false
    t.decimal  "amount_due",                             precision: 19, scale: 2
    t.integer  "parent_contact_id"
    t.boolean  "dirty_skip_pdf",                                                  default: false
    t.text     "job_descriptions"
    t.datetime "last_refreshed_at"
    t.datetime "proof_by"
    t.boolean  "web"
    t.datetime "reorder_followed_up"
    t.integer  "holdstate_id"
    t.boolean  "remote_sales_rep_update"
    t.boolean  "remote_po_update"
    t.boolean  "remote_proof_by_update"
    t.integer  "inquiry_id"
    t.string   "portal_key"
    t.string   "proof_approval_status"
    t.integer  "proof_approved_id"
    t.integer  "proof_id"
    t.boolean  "converted",                                                       default: false
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.string   "external_id"
    t.string   "source_invoice_external_id"
    t.jsonb    "meta_data",                                                       default: {}
    t.integer  "sale_id"
    t.integer  "invoice_type",                                                    default: 0
    t.string   "source_salesrep_id"
    t.string   "sales_rep_platform_id"
    t.jsonb    "tmp_data",                                                        default: {}
  end

  add_index "invoices", ["accounting_year"], name: "index_invoices_on_accounting_year", using: :btree
  add_index "invoices", ["company_id", "id"], name: "index_invoices_on_company_id", using: :btree
  add_index "invoices", ["company_id", "on_pending_list", "deleted", "voided", "id"], name: "index_invoices_company_pending", where: "((on_pending_list = true) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["company_id", "pickup_date", "deleted", "voided", "total_cost", "grand_total_inc_tax"], name: "index_invoices_company_stats", where: "((pickup_date IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["contact_id", "grand_total", "on_pending_list", "pickup_date", "ordered_date", "sales_rep_user_id", "taken_by_user_id", "web", "voided", "deleted"], name: "index_invoices_contact_lists", where: "((NOT deleted) AND (NOT voided))", using: :btree
  add_index "invoices", ["contact_id", "pickup_date", "voided", "deleted", "id"], name: "index_invoices_contact_id_orders", where: "((pickup_date IS NOT NULL) AND (NOT voided) AND (NOT deleted))", using: :btree
  add_index "invoices", ["contact_id", "pickup_date"], name: "invoices_contact_id_pickup_date_idx", using: :btree
  add_index "invoices", ["contact_id", "web", "voided"], name: "index_invoices_contact_id_web_voided", using: :btree
  add_index "invoices", ["daily_sales_summary_id", "grand_total", "rounded_amount"], name: "index_invoices_daily_sales_summary_id_totals", using: :btree
  add_index "invoices", ["dirty_skip_pdf"], name: "index_invoices_on_dirty_skip_pdf", using: :btree
  add_index "invoices", ["external_id", "company_id", "tenant_id"], name: "index_invoices_on_external_id_and_company_id_and_tenant_id", unique: true, using: :btree
  add_index "invoices", ["inquiry_id"], name: "index_invoices_on_inquiry_id", using: :btree
  add_index "invoices", ["key", "ordered_date", "voided", "deleted", "needs_pdf", "tenant_id"], name: "invoices_index", using: :btree
  add_index "invoices", ["location_user_id"], name: "index_invoices_on_location_user_id", using: :btree
  add_index "invoices", ["ordered_date", "tenant_id", "grand_total", "voided", "deleted"], name: "index_invoices_ordered_date_tenant_id", where: "((deleted = false) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["ordered_date"], name: "invoices_ordered_date_index", using: :btree
  add_index "invoices", ["pickup_date", "tenant_id", "voided", "deleted", "sales_rep_user_id", "taken_by_user_id", "location_user_id", "grand_total", "rounded_amount", "accounting_month", "accounting_year"], name: "index_invoices_on_pickup_date_tenant_sales_rep_taken_by", where: "((voided = false) AND (deleted = false))", using: :btree
  add_index "invoices", ["pickup_date"], name: "index_invoices_on_pickup_date", using: :btree
  add_index "invoices", ["portal_key", "id", "deleted", "voided"], name: "index_invoices_portal_key", where: "((portal_key IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["printsmith_id"], name: "index_invoices_on_printsmith_id", using: :btree
  add_index "invoices", ["production_location_id"], name: "index_invoices_on_production_location_id", using: :btree
  add_index "invoices", ["remote_po_update"], name: "index_invoices_on_remote_po_update", using: :btree
  add_index "invoices", ["remote_proof_by_update"], name: "index_invoices_on_remote_proof_by_update", using: :btree
  add_index "invoices", ["remote_sales_rep_update"], name: "index_invoices_on_remote_sales_rep_update", using: :btree
  add_index "invoices", ["remote_update_required"], name: "index_invoices_on_remote_update_required", using: :btree
  add_index "invoices", ["reorder_date", "reorder_followed_up", "tenant_id", "pickup_date", "contact_id", "company_id", "deleted", "voided"], name: "index_invoices_on_reorder", where: "((reorder_followed_up IS NULL) AND (pickup_date IS NOT NULL) AND (voided = false) AND (deleted = false))", using: :btree
  add_index "invoices", ["sale_id"], name: "index_invoices_on_sale_id", using: :btree
  add_index "invoices", ["sales_rep_user_id"], name: "index_invoices_on_sales_rep_user_id", using: :btree
  add_index "invoices", ["sales_summary_id", "grand_total", "rounded_amount"], name: "index_invoices_sales_summary_id_totals", using: :btree
  add_index "invoices", ["sales_summary_id", "pickup_date"], name: "index_invoices_sales_summary_id_pickup_date", where: "(sales_summary_id IS NOT NULL)", using: :btree
  add_index "invoices", ["source_created_at"], name: "index_invoices_on_source_created_at", using: :btree
  add_index "invoices", ["taken_by_user_id", "pickup_date", "total_cost", "deleted", "voided"], name: "index_invoices_taken_by_pickup_date_cost", where: "((pickup_date IS NOT NULL) AND (total_cost IS NOT NULL))", using: :btree
  add_index "invoices", ["taken_by_user_id", "source_taken_by"], name: "invoices_taken_by", using: :btree
  add_index "invoices", ["tenant_id", "accounting_month", "accounting_year", "pickup_date", "grand_total", "rounded_amount", "voided", "deleted"], name: "index_invoices_accounting_month_year", where: "((voided = false) AND (deleted = false))", using: :btree
  add_index "invoices", ["tenant_id", "accounting_year", "accounting_month", "voided"], name: "invoices_accounting_year_month", using: :btree
  add_index "invoices", ["tenant_id", "company_id", "contact_id", "id"], name: "index_invoices_id_company_contact", using: :btree
  add_index "invoices", ["tenant_id", "company_id", "grand_total", "dirty"], name: "index_invoices_on_tenant_id_and_company_id_and_grand_total", using: :btree
  add_index "invoices", ["tenant_id", "company_id", "pickup_date", "voided", "deleted"], name: "index_invoices_tenant_company_pickup", where: "((pickup_date IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["tenant_id", "company_id", "source_account_id", "created_at", "id"], name: "index_invoices_tenant_company_source_account", order: {"created_at"=>:desc}, where: "(source_account_id IS NOT NULL)", using: :btree
  add_index "invoices", ["tenant_id", "contact_id", "company_id"], name: "tmp_fix_1", where: "(company_id IS NOT NULL)", using: :btree
  add_index "invoices", ["tenant_id", "contact_id", "ordered_date", "grand_total", "voided", "deleted", "id"], name: "index_invoices_tenant_stats", where: "((voided = false) AND (deleted = false))", using: :btree
  add_index "invoices", ["tenant_id", "contact_id", "source_contact_id", "created_at", "id"], name: "index_invoices_tenant_contact_source_contact", order: {"created_at"=>:desc}, where: "(source_contact_id IS NOT NULL)", using: :btree
  add_index "invoices", ["tenant_id", "created_at"], name: "invoices_tenant_id_created_at_idx", order: {"created_at"=>:desc}, where: "(associations_complete = false)", using: :btree
  add_index "invoices", ["tenant_id", "id", "printsmith_id", "pickup_date", "deleted", "voided", "accounting_month", "daily_accounting_month"], name: "index_invoices_tenant_accounting", where: "((pickup_date > '2014-12-31 00:00:00'::timestamp without time zone) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)) AND ((accounting_month IS NULL) OR (daily_accounting_month IS NULL)))", using: :btree
  add_index "invoices", ["tenant_id", "invoice_number"], name: "invoices_tenant_id_invoice_number_idx", using: :btree
  add_index "invoices", ["tenant_id", "name"], name: "invoices_tenant_id_gin_name", using: :gin
  add_index "invoices", ["tenant_id", "ordered_date"], name: "index_invoices_on_tenant_id_and_ordered_date", using: :btree
  add_index "invoices", ["tenant_id", "pdf_error_count", "ordered_date"], name: "tmp_fix_8", order: {"ordered_date"=>:desc}, where: "((needs_pdf = true) AND (ordered_date > '2015-07-01 00:00:00'::timestamp without time zone))", using: :btree
  add_index "invoices", ["tenant_id", "pickup_date", "accounting_month", "accounting_year", "voided", "deleted"], name: "index_invoices_tenant_id_pickup_date_sales", where: "((pickup_date IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["tenant_id", "pickup_date", "accounting_year", "accounting_month", "daily_accounting_day", "daily_accounting_month", "daily_accounting_year"], name: "invoices_tenant_id_pickup_date_accounting_year_accounting_m_idx", where: "((voided = false) AND (deleted = false))", using: :btree
  add_index "invoices", ["tenant_id", "pickup_date", "invoice_number", "voided", "deleted", "name", "id"], name: "index_search_sales", where: "((pickup_date IS NOT NULL) AND (NOT deleted) AND (NOT voided))", using: :btree
  add_index "invoices", ["tenant_id", "printsmith_id", "voided", "id"], name: "index_invoices_tenant_printsmith_id_voided", where: "((voided = false) OR (voided IS NULL))", using: :btree
  add_index "invoices", ["tenant_id", "printsmith_id"], name: "invoices_tenant_id_printsmith_id_idx", where: "(dirty = true)", using: :btree
  add_index "invoices", ["tenant_id", "printsmith_id"], name: "invoices_tenant_id_printsmith_id_idx1", using: :btree
  add_index "invoices", ["tenant_id", "printsmith_id"], name: "invoices_unpaid_invoices_checker", where: "((pickup_date IS NOT NULL) AND (amount_due > (0)::numeric) AND (deleted = false) AND ((voided IS NULL) OR (voided = false)))", using: :btree
  add_index "invoices", ["tenant_id", "production_location_id", "voided", "deleted", "on_pending_list", "id"], name: "index_invoices_tenant_production_location", where: "((voided IS FALSE) AND (deleted IS FALSE) AND (on_pending_list IS TRUE))", using: :btree
  add_index "invoices", ["tenant_id", "sales_rep_user_id", "accounting_month", "accounting_year", "pickup_date", "grand_total", "voided", "deleted"], name: "index_invoices_on_sales_rep_accounting_pickup_grand_total", where: "((deleted = false) AND (voided = false) AND (pickup_date IS NOT NULL))", using: :btree
  add_index "invoices", ["tenant_id", "salesrep_id", "id", "sales_rep_user_id", "location_user_id"], name: "index_invoices_tenant_id_sales_rep", where: "(salesrep_id IS NOT NULL)", using: :btree
  add_index "invoices", ["tenant_id", "salesrep_id", "location_user_id", "created_at", "id"], name: "index_invoices_tenant_sales_rep_location_created_at", order: {"created_at"=>:desc}, using: :btree
  add_index "invoices", ["tenant_id", "source_taken_by", "id", "taken_by_user_id"], name: "index_invoices_tenant_id_taken_by", where: "(source_taken_by IS NOT NULL)", using: :btree
  add_index "invoices", ["tenant_id", "source_taken_by", "source_created_at"], name: "index_invoices_on_tenant_stakenby_screatedat", using: :btree
  add_index "invoices", ["tenant_id", "source_updated_at"], name: "invoices_tenant_id_source_updated_at_asc", where: "(source_updated_at >= '2014-01-01 00:00:00'::timestamp without time zone)", using: :btree
  add_index "invoices", ["tenant_id", "taken_by_user_id", "source_taken_by", "id", "created_at"], name: "tmp_fix_3", using: :btree
  add_index "invoices", ["tenant_id", "updated_at", "voided", "deleted", "remote_po_update"], name: "invoices_tenant_id_updated_at_voided_deleted_remote_po_upda_idx", where: "(remote_po_update = true)", using: :btree
  add_index "invoices", ["tenant_id", "updated_at", "voided", "deleted", "remote_proof_by_update"], name: "invoices_tenant_id_updated_at_voided_deleted_remote_proof_b_idx", where: "(remote_proof_by_update = true)", using: :btree
  add_index "invoices", ["tenant_id", "voided", "deleted"], name: "index_invoices_retry_sales_rep_update", where: "(remote_sales_rep_update = true)", using: :btree
  add_index "invoices", ["tenant_id", "wanted_by", "invoice_number", "voided", "deleted", "name", "id"], name: "index_search_orders", where: "((pickup_date IS NULL) AND (NOT deleted) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["tenant_id"], name: "corey_july_4", where: "(company_id IS NOT NULL)", using: :btree
  add_index "invoices", ["tenant_id"], name: "index_invoices_on_pending_list", where: "(on_pending_list = true)", using: :btree
  add_index "invoices", ["tenant_id"], name: "invoices_dirty_skip_pdf_index", where: "(dirty_skip_pdf = true)", using: :btree
  add_index "invoices", ["tenant_id"], name: "invoices_tenant_id_idx1", where: "(dirty = true)", using: :btree
  add_index "invoices", ["tenant_id"], name: "tmp_fix_11", where: "((retry_location_update = true) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))", using: :btree
  add_index "invoices", ["web", "company_id", "voided", "deleted"], name: "invoices_web", where: "((web = true) AND (deleted = false) AND (voided = false))", using: :btree

  create_table "job_stats", force: :cascade do |t|
    t.string   "job_name"
    t.integer  "job_id"
    t.datetime "job_start"
    t.datetime "job_end"
    t.string   "exception_type"
    t.string   "exception_message"
  end

  create_table "lead_types", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.integer "enterprise_id"
    t.integer "lead_status_visibility", default: [],    array: true
    t.integer "active_status_version"
    t.integer "status",                 default: 2
    t.integer "tenant_id"
    t.boolean "global",                 default: false
    t.boolean "is_default",             default: false
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.jsonb    "filter",        default: {},    null: false
    t.integer  "user_id",                       null: false
    t.boolean  "global",        default: false
    t.boolean  "site_wide",     default: false
    t.integer  "tenant_id"
    t.integer  "enterprise_id",                 null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "lists", ["filter"], name: "index_lists_on_filter", using: :gin
  add_index "lists", ["tenant_id"], name: "index_lists_on_tenant_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "tenant_id"
    t.datetime "created_at",  precision: 6,                 null: false
    t.datetime "updated_at",  precision: 6,                 null: false
    t.boolean  "default",                   default: false
    t.integer  "identity_id"
  end

  add_index "locations", ["tenant_id"], name: "index_locations_on_tenant_id", using: :btree

  create_table "marketing_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "email_template_ids",          default: [],              array: true
    t.integer  "campaign_ids",                default: [],              array: true
    t.integer  "excluded_campaign_ids",       default: [],              array: true
    t.integer  "enterprise_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "excluded_email_template_ids", default: [],              array: true
  end

  create_table "meeting_attendees", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "user_id"
    t.integer "contact_id"
    t.text    "email_address"
    t.integer "status"
    t.text    "custom_time_zone"
    t.text    "note"
    t.integer "user_calendar_entry_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.text     "message"
    t.text     "location"
    t.text     "title"
    t.text     "summary"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "status"
    t.text     "note"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "calendar_needs_update",           default: false
    t.string   "user_calendar_entry_id"
    t.boolean  "reminder_sent",                   default: false
    t.integer  "prospect_status_item_contact_id"
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "enterprise_id"
    t.boolean  "global",        default: false
  end

  add_index "news", ["enterprise_id"], name: "index_news_on_enterprise_id", using: :btree

  create_table "next_activities", force: :cascade do |t|
    t.datetime "scheduled"
    t.integer  "contact_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "status"
    t.integer  "tenant_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "next_activities", ["tenant_id"], name: "index_next_activities_on_tenant_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.text     "message"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.text     "title"
    t.boolean  "deleted",                 default: false
    t.integer  "prospect_status_item_id"
  end

  create_table "original_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.string   "uuid"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "pdfs", force: :cascade do |t|
    t.integer  "page_count"
    t.integer  "printsmith_id"
    t.text     "key"
    t.datetime "created_at",    precision: 6, null: false
    t.datetime "updated_at",    precision: 6, null: false
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.string   "external_id"
  end

  add_index "pdfs", ["key", "external_id"], name: "index_pdfs_on_key_and_external_id", using: :btree
  add_index "pdfs", ["key", "printsmith_id"], name: "pdfs_index", using: :btree

  create_table "pending_attachments", force: :cascade do |t|
    t.string   "uuid"
    t.string   "file_name"
    t.string   "path"
    t.boolean  "complete"
    t.boolean  "inline",      default: false
    t.jsonb    "needs_asset", default: {}
    t.integer  "tenant_id"
    t.string   "error"
    t.string   "warn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bulk"
  end

  create_table "phone_calls", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "phoneable_id"
    t.string   "phoneable_type",                  limit: 255
    t.string   "to",                              limit: 255
    t.string   "subject",                         limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                                  precision: 6
    t.datetime "updated_at",                                  precision: 6
    t.datetime "call_date",                                   precision: 6
    t.string   "phone"
    t.integer  "contact_id"
    t.string   "call_type"
    t.string   "twillio_message_sid"
    t.string   "sms_status"
    t.string   "test_number"
    t.integer  "prospect_status_item_contact_id"
    t.string   "twillio_message"
  end

  add_index "phone_calls", ["phoneable_id", "phoneable_type"], name: "index_phone_calls_on_phoneable_id_and_phoneable_type", using: :btree
  add_index "phone_calls", ["tenant_id"], name: "index_phone_calls_on_tenant_id", using: :btree
  add_index "phone_calls", ["user_id"], name: "index_phone_calls_on_user_id", using: :btree

  create_table "portal_comments", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.string   "context_type"
    t.integer  "context_id"
    t.text     "body"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.string   "status"
  end

  create_table "production_locations", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "tenant_id"
    t.integer  "printsmith_id"
    t.datetime "created_at",                    precision: 6
    t.datetime "updated_at",                    precision: 6
    t.boolean  "dirty"
    t.boolean  "deleted",                                     default: false
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.string   "printsmith_key"
    t.integer  "orderby"
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "production_locations", ["tenant_id", "printsmith_key", "deleted", "id", "orderby", "name"], name: "index_production_locations_tenant_key", where: "((NOT deleted) AND (printsmith_key IS NOT NULL))", using: :btree
  add_index "production_locations", ["tenant_id"], name: "index_production_locations_on_tenant_id", using: :btree

  create_table "proofs", force: :cascade do |t|
    t.integer  "tenant_id"
    t.jsonb    "asset_data"
    t.string   "approval_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id"
    t.integer  "user_id"
  end

  create_table "prospect_status_item_contacts", force: :cascade do |t|
    t.integer  "prospect_status_item_id"
    t.integer  "contact_id"
    t.integer  "tenant_id"
    t.datetime "start_date"
    t.datetime "due_date"
    t.datetime "completion_date"
    t.integer  "status"
  end

  add_index "prospect_status_item_contacts", ["prospect_status_item_id", "contact_id", "tenant_id"], name: "prospect_status_item_contact_unique_index", unique: true, using: :btree

  create_table "prospect_status_items", force: :cascade do |t|
    t.string  "name"
    t.integer "prospect_status_id"
    t.integer "lead_type_id"
    t.integer "tenant_id"
    t.integer "enterprise_id"
    t.integer "position"
    t.integer "item_type"
    t.integer "start_after_days"
    t.integer "completion_time",    default: 0
    t.text    "description"
    t.integer "email_template_id"
  end

  add_index "prospect_status_items", ["enterprise_id"], name: "index_prospect_status_items_on_enterprise_id", using: :btree
  add_index "prospect_status_items", ["lead_type_id"], name: "index_prospect_status_items_on_lead_type_id", using: :btree
  add_index "prospect_status_items", ["prospect_status_id"], name: "index_prospect_status_items_on_prospect_status_id", using: :btree
  add_index "prospect_status_items", ["tenant_id"], name: "index_prospect_status_items_on_tenant_id", using: :btree

  create_table "prospect_status_versions", force: :cascade do |t|
    t.integer "lead_type_id"
    t.integer "version_no"
    t.integer "status"
  end

  add_index "prospect_status_versions", ["lead_type_id"], name: "index_prospect_status_versions_on_lead_type_id", using: :btree

  create_table "prospect_statuses", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "enterprise_id",                          null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "position"
    t.integer  "lead_type_id",               default: 0
    t.integer  "tenant_id",                  default: 0
    t.integer  "prospect_status_version_id", default: 0
  end

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id"
    t.string   "readable_type", null: false
    t.integer  "reader_id"
    t.string   "reader_type",   null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", using: :btree

  create_table "region_configs", force: :cascade do |t|
    t.text "option"
    t.text "value"
  end

  create_table "report_rows", force: :cascade do |t|
    t.integer "columns",   default: [], array: true
    t.integer "report_id"
    t.integer "position",  default: 0
  end

  add_index "report_rows", ["report_id"], name: "index_report_rows_on_report_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.string  "name"
    t.integer "tenant_id"
    t.integer "user_id"
    t.boolean "global"
  end

  add_index "reports", ["global"], name: "index_reports_on_global", using: :btree
  add_index "reports", ["tenant_id"], name: "index_reports_on_tenant_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "sales_base_taxes", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "source_type"
    t.boolean  "associations_complete",                          default: false
    t.boolean  "dirty",                                          default: false
    t.boolean  "deleted"
    t.datetime "posted_date",           precision: 6
    t.datetime "source_created_at",     precision: 6
    t.datetime "source_updated_at",     precision: 6
    t.decimal  "total",                 precision: 19, scale: 2
    t.integer  "sales_base_id"
    t.integer  "source_sales_base_id"
    t.integer  "printsmith_id"
    t.decimal  "total_tax",             precision: 19, scale: 2
    t.decimal  "total_non_taxable",     precision: 19, scale: 2
    t.decimal  "total_taxable",         precision: 19, scale: 2
    t.datetime "created_at",            precision: 6,                            null: false
    t.datetime "updated_at",            precision: 6,                            null: false
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "sales_base_taxes", ["printsmith_id", "tenant_id"], name: "sales_base_taxes_printsmith_id_tenant_id_idx", using: :btree
  add_index "sales_base_taxes", ["tenant_id", "deleted", "source_type", "source_sales_base_id", "total_taxable", "total_non_taxable"], name: "index_sales_base_taxes_tenant_id_taxability", using: :btree

  create_table "sales_categories", force: :cascade do |t|
    t.string   "glaccount"
    t.boolean  "interest"
    t.boolean  "deleted",                     default: false
    t.string   "name"
    t.boolean  "nonsale"
    t.integer  "salescatid"
    t.boolean  "shipping"
    t.integer  "printsmith_id"
    t.boolean  "dirty",                       default: false
    t.integer  "tenant_id"
    t.datetime "created_at",    precision: 6
    t.datetime "updated_at",    precision: 6
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "sales_categories", ["tenant_id"], name: "index_sales_categories_on_tenant_id", using: :btree

  create_table "sales_rep_updates", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "sales_rep_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales_reps", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "tenant_id"
    t.integer  "printsmith_id"
    t.datetime "created_at",                      precision: 6
    t.datetime "updated_at",                      precision: 6
    t.boolean  "dirty"
    t.boolean  "deleted",                                       default: false
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.datetime "latest_context_date"
    t.boolean  "auto_mapped",                                   default: false
    t.boolean  "add_in_table_list",                             default: false
    t.string   "external_id"
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "sales_reps", ["location_id", "printsmith_id", "deleted"], name: "index_sales_reps_on_location_printsmith_id", using: :btree
  add_index "sales_reps", ["tenant_id", "printsmith_id", "location_id"], name: "index_sales_reps_tenant_printsmith_id_loction_not_null", where: "(location_id IS NOT NULL)", using: :btree
  add_index "sales_reps", ["tenant_id"], name: "corey_july_2", where: "(user_id IS NOT NULL)", using: :btree
  add_index "sales_reps", ["tenant_id"], name: "index_sales_reps_on_tenant_id", using: :btree
  add_index "sales_reps", ["user_id", "printsmith_id", "deleted"], name: "index_sales_reps_on_user_printsmith_id", using: :btree

  create_table "sales_summaries", force: :cascade do |t|
    t.decimal  "arbalance",              precision: 19, scale: 2
    t.decimal  "arcard",                 precision: 19, scale: 2
    t.decimal  "arcash",                 precision: 19, scale: 2
    t.decimal  "archarge",               precision: 19, scale: 2
    t.decimal  "archeck",                precision: 19, scale: 2
    t.decimal  "bankdeposit",            precision: 19, scale: 2
    t.integer  "cardcount"
    t.datetime "closeoutdate",           precision: 6
    t.boolean  "composite"
    t.boolean  "datarepaired"
    t.decimal  "depositbalance",         precision: 19, scale: 2
    t.decimal  "discounts",              precision: 19, scale: 2
    t.decimal  "draw",                   precision: 19, scale: 2
    t.decimal  "employees",              precision: 19, scale: 2
    t.datetime "enddate",                precision: 6
    t.decimal  "fmaccount",              precision: 19, scale: 2
    t.decimal  "forfeitdeposits",        precision: 19, scale: 2
    t.decimal  "invoicetotal",           precision: 19, scale: 2
    t.boolean  "isdeleted"
    t.decimal  "markups",                precision: 19, scale: 2
    t.decimal  "newdeposits",            precision: 19, scale: 2
    t.decimal  "nontaxreceipts",         precision: 19, scale: 2
    t.decimal  "nontaxsales",            precision: 19, scale: 2
    t.integer  "numperiods"
    t.decimal  "onaccount",              precision: 19, scale: 2
    t.decimal  "onaccountbalance",       precision: 19, scale: 2
    t.decimal  "otherhours",             precision: 19, scale: 2
    t.decimal  "poscard",                precision: 19, scale: 2
    t.decimal  "poscash",                precision: 19, scale: 2
    t.decimal  "poscheck",               precision: 19, scale: 2
    t.decimal  "presshours",             precision: 19, scale: 2
    t.decimal  "productionhours",        precision: 19, scale: 2
    t.decimal  "refundchecks",           precision: 19, scale: 2
    t.decimal  "returndeposits",         precision: 19, scale: 2
    t.boolean  "shiftcloseout"
    t.decimal  "shipping",               precision: 19, scale: 2
    t.integer  "squarefeet"
    t.decimal  "taxonreceipts",          precision: 19, scale: 2
    t.decimal  "taxonsales",             precision: 19, scale: 2
    t.decimal  "taxablereceipts",        precision: 19, scale: 2
    t.decimal  "taxablesales",           precision: 19, scale: 2
    t.decimal  "totaldeletes",           precision: 19, scale: 2
    t.decimal  "totalmemos",             precision: 19, scale: 2
    t.decimal  "totalnosalememos",       precision: 19, scale: 2
    t.decimal  "totalother",             precision: 19, scale: 2
    t.decimal  "totalreceipts",          precision: 19, scale: 2
    t.decimal  "totalsales",             precision: 19, scale: 2
    t.decimal  "totalvoid",              precision: 19, scale: 2
    t.decimal  "variance",               precision: 19, scale: 2
    t.decimal  "wiptotaldone",           precision: 19, scale: 2
    t.decimal  "wiptotalest",            precision: 19, scale: 2
    t.decimal  "wiptotalinv",            precision: 19, scale: 2
    t.boolean  "daily",                                           default: false
    t.boolean  "monthly",                                         default: false
    t.integer  "printsmith_id"
    t.boolean  "dirty",                                           default: false
    t.datetime "created_at",             precision: 6,                            null: false
    t.datetime "updated_at",             precision: 6,                            null: false
    t.integer  "tenant_id"
    t.decimal  "applydeposits",          precision: 19, scale: 2
    t.boolean  "deleted",                                         default: false
    t.integer  "accounting_day"
    t.integer  "accounting_month"
    t.integer  "accounting_year"
    t.integer  "daily_accounting_day"
    t.integer  "daily_accounting_month"
    t.integer  "daily_accounting_year"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.boolean  "complete",                                        default: false
    t.boolean  "accurate",                                        default: false
    t.decimal  "difference",             precision: 19, scale: 2
    t.integer  "invoice_count"
    t.decimal  "avg_sale",               precision: 19, scale: 2
    t.integer  "attempts",                                        default: 0
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "sales_summaries", ["accounting_month"], name: "index_sales_summaries_on_accounting_month", using: :btree
  add_index "sales_summaries", ["accounting_year"], name: "index_sales_summaries_on_accounting_year", using: :btree
  add_index "sales_summaries", ["printsmith_id", "tenant_id"], name: "index_sales_summaries_on_printsmith_id_and_tenant_id", using: :btree
  add_index "sales_summaries", ["tenant_id", "closeoutdate"], name: "sales_summaries_tenant_id_closeoutdate_idx", order: {"closeoutdate"=>:desc}, using: :btree
  add_index "sales_summaries", ["tenant_id", "daily_accounting_year", "daily_accounting_month", "daily_accounting_day"], name: "sales_summaries_tenant_id_daily_accounting_year_daily_accou_idx", using: :btree
  add_index "sales_summaries", ["tenant_id", "printsmith_id", "deleted", "id"], name: "index_sales_summaries_tenant_printsmith_id_not_deleted", where: "(deleted = false)", using: :btree

  create_table "sales_summary_pickups", force: :cascade do |t|
    t.integer  "source_account_history_item_id"
    t.integer  "account_history_item_id"
    t.integer  "source_sales_summary_id"
    t.integer  "sales_summary_id"
    t.datetime "created_at",                     precision: 6,                 null: false
    t.datetime "updated_at",                     precision: 6,                 null: false
    t.integer  "tenant_id"
    t.integer  "printsmith_id"
    t.boolean  "deleted",                                      default: false
    t.boolean  "dirty",                                        default: false
    t.boolean  "ready",                                        default: false
    t.boolean  "boolean",                                      default: false
    t.boolean  "associations_complete",                        default: false
    t.integer  "assocation_checks",                            default: 0
    t.integer  "integer",                                      default: 0
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.string   "platform_id"
    t.jsonb    "platform_data"
  end

  add_index "sales_summary_pickups", ["source_account_history_item_id"], name: "index_sales_summary_pickups_on_source_account_history_item_id", using: :btree
  add_index "sales_summary_pickups", ["source_sales_summary_id"], name: "index_sales_summary_pickups_on_source_sales_summary_id", using: :btree
  add_index "sales_summary_pickups", ["tenant_id", "printsmith_id"], name: "sales_summary_pickups_tenant_id_printsmith_id_idx", using: :btree
  add_index "sales_summary_pickups", ["tenant_id", "source_account_history_item_id", "source_sales_summary_id", "deleted"], name: "index_sales_summary_source_account_history_item", where: "(deleted = false)", using: :btree

  create_table "sales_tag_by_months", force: :cascade do |t|
    t.integer "tenant_id"
    t.integer "total_sales"
    t.integer "total_invoice_count"
    t.integer "total_companies"
    t.jsonb   "tags_data",           default: {},   null: false
    t.date    "month_date"
    t.boolean "update_required",     default: true
  end

  add_index "sales_tag_by_months", ["tenant_id"], name: "index_sales_tag_by_months_on_tenant_id", using: :btree

  create_table "salestargets", force: :cascade do |t|
    t.integer "target_type"
    t.string  "name"
    t.integer "amount"
    t.integer "tenant_id"
    t.integer "user_id"
    t.integer "items"
    t.integer "enterprise_id"
  end

  add_index "salestargets", ["tenant_id"], name: "index_salestargets_on_tenant_id", using: :btree

  create_table "saved_reports", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "enterprise_id"
    t.integer  "tenant_id"
    t.jsonb    "data"
    t.jsonb    "ytd",           default: {}, null: false
    t.string   "report_type"
  end

  create_table "shared_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "shared_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer  "tenant_id"
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.text     "description"
    t.decimal  "grand_total"
    t.decimal  "price_total"
    t.decimal  "price_sub_total"
    t.integer  "contact_id"
    t.integer  "company_id"
    t.boolean  "voided",                     default: false
    t.boolean  "deleted",                    default: false
    t.boolean  "needs_pdf",                  default: false
    t.string   "shipment_type"
    t.string   "mbe_tracking"
    t.string   "courier_tracking"
    t.decimal  "courier_weight"
    t.datetime "shipment_date"
    t.string   "source_account_platform_id"
    t.string   "source_invoice_platform_id"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "pdf_error_count",            default: 0
    t.string   "key"
    t.boolean  "associations_complete",      default: false
    t.integer  "association_checks",         default: 0
    t.integer  "mbe_service_id"
    t.integer  "packge_type_id"
    t.integer  "goods_type_id"
    t.integer  "courier_id"
    t.integer  "courier_service_id"
    t.boolean  "delivered",                  default: false
    t.datetime "delivered_date"
    t.string   "status"
    t.integer  "pdf_id"
    t.boolean  "not_to_invoice",             default: false
    t.boolean  "dirty",                      default: false
    t.decimal  "total_cost",                 default: 0.0
    t.integer  "sales_rep_user_id"
    t.string   "source_salesrep_id"
    t.string   "sales_rep_platform_id"
    t.jsonb    "tmp_data",                   default: {}
    t.integer  "accounting_month"
    t.integer  "accounting_year"
    t.integer  "sales_summary_id"
    t.integer  "daily_accounting_day"
    t.integer  "daily_accounting_month"
    t.integer  "daily_accounting_year"
    t.integer  "daily_sales_summary_id"
  end

  add_index "shipments", ["tenant_id"], name: "shipments_status_index", where: "((status)::text = ANY (ARRAY[('CREATED'::character varying)::text, ('DRAFT_WAYBILL'::character varying)::text, ('INVOICED'::character varying)::text]))", using: :btree

  create_table "sms_template_categories", force: :cascade do |t|
    t.integer "sms_template_id"
    t.integer "category"
  end

  create_table "sms_templates", force: :cascade do |t|
    t.text     "name"
    t.text     "body"
    t.boolean  "global",        default: false
    t.integer  "user_id",                       null: false
    t.integer  "tenant_id"
    t.integer  "enterprise_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wrapper_id"
  end

  add_index "sms_templates", ["tenant_id"], name: "index_sms_templates_on_tenant_id", using: :btree

  create_table "statistics", id: :bigserial, force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "tenant_id"
    t.integer  "month"
    t.integer  "year"
    t.integer  "financial_year"
    t.integer  "rank"
    t.datetime "created_at",            precision: 6
    t.datetime "updated_at",            precision: 6
    t.decimal  "total",                 precision: 19, scale: 2
    t.decimal  "average",               precision: 19, scale: 2
    t.integer  "count"
    t.string   "statistic_for"
    t.boolean  "needs_recalc",                                   default: false
    t.integer  "accounting_year"
    t.integer  "accounting_month"
    t.integer  "accounting_day"
    t.integer  "calendar_year"
    t.integer  "calendar_month"
    t.integer  "calendar_day"
    t.decimal  "total_sales",           precision: 19, scale: 2
    t.decimal  "invoice_sales",         precision: 19, scale: 2
    t.decimal  "cash_sales",            precision: 19, scale: 2
    t.decimal  "adjustments",           precision: 19, scale: 2
    t.integer  "day"
    t.decimal  "markups",               precision: 19, scale: 2
    t.decimal  "department_cash_sales", precision: 19, scale: 2
    t.decimal  "finance_charges",       precision: 19, scale: 2
    t.integer  "user_id"
    t.integer  "location_id"
    t.date     "date"
    t.integer  "sales_rep_user_id"
    t.decimal  "order_intake"
    t.decimal  "shipments"
    t.decimal  "invoiced_sales"
    t.decimal  "deferred_sales"
  end

  add_index "statistics", ["accounting_month"], name: "index_statistics_on_accounting_month", using: :btree
  add_index "statistics", ["accounting_year"], name: "index_statistics_on_accounting_year", using: :btree
  add_index "statistics", ["date", "tenant_id"], name: "statistics_date_tenant_id_idx", using: :btree
  add_index "statistics", ["location_id"], name: "index_statistics_on_location_id", using: :btree
  add_index "statistics", ["statistic_for"], name: "index_statistics_on_statistic_for", using: :btree
  add_index "statistics", ["tenant_id", "accounting_year", "accounting_month", "statistic_for"], name: "statistics_tenant_id_accounting_year_accounting_month_stati_idx", using: :btree
  add_index "statistics", ["user_id"], name: "index_statistics_on_user_id", using: :btree

  create_table "suppressed_addresses", force: :cascade do |t|
    t.integer "tenant_id"
    t.string  "email_address"
    t.string  "date"
    t.string  "reason"
    t.boolean "ignore",        default: false
  end

  add_index "suppressed_addresses", ["tenant_id", "ignore", "email_address", "id"], name: "index_suppressed_addresses_tenant_trimmed_email", where: "(ignore = false)", using: :btree

  create_table "tag_categories", force: :cascade do |t|
    t.integer  "tenant_id"
    t.string   "name"
    t.string   "word_matches",       default: "",    null: false
    t.boolean  "up_to_date",         default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "hidden",             default: false
    t.boolean  "deleted",            default: false
    t.boolean  "performing_cleanup", default: false
    t.text     "description"
    t.jsonb    "hidden_tenants",     default: {}
    t.integer  "enterprise_id"
  end

  add_index "tag_categories", ["tenant_id", "enterprise_id", "name", "hidden_tenants", "hidden", "performing_cleanup", "deleted", "id"], name: "index_tag_categories_tenant", where: "((NOT hidden) AND (NOT performing_cleanup) AND (NOT deleted))", using: :btree

  create_table "tag_category_contexts", force: :cascade do |t|
    t.string   "name"
    t.integer  "tag_category_id"
    t.integer  "last_scanned_id",     default: 0
    t.integer  "last_scanned_offset", default: 0
    t.datetime "last_scanned"
    t.jsonb    "scan_progress",       default: {}
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "tenant_id"
    t.integer "user_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
    t.integer "tag_category_id"
    t.boolean "manual",          default: false
    t.boolean "deleted",         default: false
    t.integer "parent_id"
    t.boolean "bubbled"
  end

  add_index "tags", ["tag_category_id"], name: "index_tags_on_tag_category_id", using: :btree
  add_index "tags", ["taggable_id", "taggable_type", "tag_category_id", "deleted"], name: "index_tags_company", where: "((NOT deleted) AND ((taggable_type)::text = 'Company'::text))", using: :btree
  add_index "tags", ["taggable_id", "taggable_type", "tag_category_id", "deleted"], name: "index_tags_contact", where: "((NOT deleted) AND ((taggable_type)::text = 'Contact'::text))", using: :btree
  add_index "tags", ["taggable_id", "taggable_type", "tag_category_id", "deleted"], name: "index_tags_estimate", where: "((NOT deleted) AND ((taggable_type)::text = 'Estimate'::text))", using: :btree
  add_index "tags", ["taggable_id", "taggable_type", "tag_category_id", "deleted"], name: "index_tags_invoice", where: "((NOT deleted) AND ((taggable_type)::text = 'Invoice'::text))", using: :btree
  add_index "tags", ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id", using: :btree
  add_index "tags", ["tenant_id"], name: "index_tags_on_tenant_id", using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "taken_by_updates", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "taken_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taken_bys", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.string   "name"
    t.datetime "created_at",          precision: 6,                 null: false
    t.datetime "updated_at",          precision: 6,                 null: false
    t.integer  "location_id"
    t.datetime "latest_context_date"
    t.boolean  "auto_mapped",                       default: false
    t.string   "external_id"
  end

  add_index "taken_bys", ["location_id"], name: "index_taken_bys_on_location_id", using: :btree
  add_index "taken_bys", ["tenant_id"], name: "index_taken_bys_on_tenant_id", using: :btree
  add_index "taken_bys", ["user_id"], name: "index_taken_bys_on_user_id", using: :btree

  create_table "targets", force: :cascade do |t|
    t.integer "tenant_id"
    t.integer "location_id"
    t.integer "taken_by_user_id"
    t.integer "sales_rep_user_id"
    t.integer "location_user_id"
    t.integer "month"
    t.integer "year"
    t.integer "total"
    t.integer "klass"
  end

  add_index "targets", ["tenant_id"], name: "index_targets_on_tenant_id", using: :btree

  create_table "task_repeats", force: :cascade do |t|
    t.integer  "task_id"
    t.string   "repeat_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_types", force: :cascade do |t|
    t.string  "name"
    t.integer "tenant_id"
    t.integer "enterprise_id"
    t.integer "user_id"
    t.boolean "global",        default: false
  end

  add_index "task_types", ["enterprise_id"], name: "index_task_types_on_enterprise_id", using: :btree
  add_index "task_types", ["tenant_id"], name: "index_task_types_on_tenant_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.string   "mode"
    t.string   "status"
    t.string   "name"
    t.text     "description"
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.datetime "created_at",                      precision: 6
    t.datetime "updated_at",                      precision: 6
    t.datetime "start_date",                      precision: 6
    t.datetime "end_date",                        precision: 6
    t.integer  "assigned_user_id"
    t.boolean  "add_to_calendar",                               default: false
    t.integer  "position"
    t.boolean  "calendar_needs_update",                         default: false
    t.string   "user_calendar_entry_id"
    t.string   "assigned_user_calendar_entry_id"
    t.text     "final_comment"
    t.datetime "completed_at"
    t.integer  "task_type_id"
    t.boolean  "portal_task",                                   default: false
    t.boolean  "notify_due",                                    default: false
    t.boolean  "notify_due_email_sent",                         default: false
    t.datetime "notify_date"
    t.integer  "task_repeat_id"
    t.string   "notification_ids",                              default: [],    array: true
    t.integer  "inquiry_id"
    t.integer  "prospect_status_item_contact_id"
  end

  add_index "tasks", ["notify_due_email_sent", "notify_due", "notify_date"], name: "index_tasks_on_notify", where: "((notify_due_email_sent = false) AND (notify_due = true))", using: :btree
  add_index "tasks", ["position"], name: "index_tasks_on_position", using: :btree
  add_index "tasks", ["taskable_type", "taskable_id"], name: "index_tasks_on_taskable_type_and_taskable_id", using: :btree
  add_index "tasks", ["tenant_id"], name: "index_tasks_on_tenant_id", using: :btree
  add_index "tasks", ["user_calendar_entry_id", "assigned_user_calendar_entry_id"], name: "index_tasks_on_entry_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "tenants", force: :cascade do |t|
    t.string   "name",                                         limit: 255
    t.string   "number",                                       limit: 255
    t.string   "printsmith_ip",                                limit: 255
    t.string   "printsmith_username",                          limit: 255
    t.string   "printsmith_password",                          limit: 255
    t.datetime "created_at",                                               precision: 6
    t.datetime "updated_at",                                               precision: 6
    t.string   "printsmith_database",                          limit: 255
    t.boolean  "inital_import_complete",                                                            default: false
    t.boolean  "allow_access"
    t.boolean  "disable_import"
    t.string   "time_zone",                                                                         default: "UTC"
    t.string   "state",                                        limit: 255
    t.integer  "connection_success_counter",                                                        default: 0
    t.integer  "connection_failure_counter",                                                        default: 0
    t.datetime "last_connection_failure_at",                               precision: 6
    t.boolean  "connection_status"
    t.integer  "financial_year_start_day",                                                          default: 1
    t.integer  "financial_year_start_month",                                                        default: 1
    t.integer  "financial_year_end_day",                                                            default: 31
    t.integer  "financial_year_end_month",                                                          default: 12
    t.string   "estimate_name"
    t.boolean  "ngrok",                                                                             default: false
    t.integer  "printsmith_port"
    t.string   "report_url"
    t.string   "invoice_name"
    t.string   "ngrok_authtoken"
    t.string   "ngrok_remote_addr"
    t.string   "ngrok_uuid"
    t.text     "s3_region"
    t.text     "s3_bucket"
    t.text     "s3_access_key"
    t.text     "s3_client_secret"
    t.integer  "estimate_views",                                                                    default: 0
    t.integer  "wanted_by_adjustments",                                                             default: 0
    t.boolean  "needs_backup"
    t.boolean  "multi_location",                                                                    default: false
    t.boolean  "taken_by_for_locations",                                                            default: false
    t.boolean  "sales_rep_for_locations",                                                           default: false
    t.boolean  "training",                                                                          default: false
    t.boolean  "beta_tester"
    t.string   "printsmith_version"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "suburb"
    t.string   "postcode"
    t.string   "phone"
    t.string   "email_marketing"
    t.string   "contact_name"
    t.text     "business_hours"
    t.text     "pgdump_path"
    t.text     "backup_path"
    t.text     "local_path"
    t.integer  "last_accounting_month"
    t.integer  "last_accounting_year"
    t.integer  "marketing_unsubscribe_source_id"
    t.boolean  "default_email_to_test_send",                                                        default: true
    t.boolean  "display_month_first",                                                               default: false
    t.integer  "estimate_email_template"
    t.integer  "sale_email_template"
    t.integer  "order_email_template"
    t.integer  "contact_email_template"
    t.integer  "enterprise_id"
    t.boolean  "ngrok_needs_restart"
    t.date     "most_recent_monthly_closeout_date"
    t.integer  "company_email_template"
    t.boolean  "hide_from_ladders",                                                                 default: false
    t.boolean  "show_cogs",                                                                         default: true
    t.integer  "campaign_min_resend_days",                                                          default: 25
    t.decimal  "cog_green_threshold",                                      precision: 19, scale: 2, default: 30.0
    t.decimal  "cog_orange_threshold",                                     precision: 19, scale: 2, default: 70.0
    t.string   "ngrok_version"
    t.boolean  "ngrok_tcp_online",                                                                  default: false
    t.boolean  "ngrok_http_online",                                                                 default: false
    t.boolean  "week_start",                                                                        default: true
    t.boolean  "allow_production_features_on_staging",                                              default: false
    t.text     "campaign_monitor_client_id"
    t.string   "website"
    t.integer  "wanted_days",                                                                       default: 1
    t.text     "email_blacklist"
    t.string   "tenant_picker_name"
    t.string   "marketing_name"
    t.text     "ngrok_crt"
    t.text     "ngrok_key"
    t.boolean  "demo",                                                                              default: false
    t.string   "printsmith_api_token"
    t.boolean  "exclude_non_sales",                                                                 default: true
    t.string   "estimate_name_list"
    t.string   "invoice_name_list"
    t.string   "estimate_name_default"
    t.string   "invoice_name_default"
    t.string   "printsmith_api_version"
    t.boolean  "estimate_name_enforce",                                                             default: false
    t.boolean  "invoice_name_enforce",                                                              default: false
    t.string   "test_email"
    t.boolean  "enforce_old_printsmith_api",                                                        default: false
    t.integer  "banner_id"
    t.string   "holiday_last_day"
    t.string   "holiday_returning"
    t.boolean  "show_company_tags",                                                                 default: true
    t.boolean  "show_contacts_tags",                                                                default: true
    t.boolean  "show_estimates_tags",                                                               default: true
    t.boolean  "show_orders_tags",                                                                  default: true
    t.boolean  "show_sales_tags",                                                                   default: true
    t.string   "website_url"
    t.string   "request_quote_url"
    t.datetime "last_sales_report_start"
    t.datetime "last_sales_report_finish"
    t.jsonb    "monitor_counters",                                                                  default: {}
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "pinterest"
    t.string   "printsmith_local_port",                                                             default: "5432"
    t.string   "review_url"
    t.boolean  "account_history_trigger",                                                           default: true
    t.integer  "portal_estimate_comment_template_id"
    t.integer  "portal_estimate_approved_template_id"
    t.integer  "portal_estimate_canceled_template_id"
    t.datetime "owner_open_date"
    t.boolean  "use_complex_cost",                                                                  default: false
    t.boolean  "use_smtp",                                                                          default: false
    t.string   "lead_sources"
    t.text     "statement_template_name"
    t.text     "statement_template"
    t.string   "pay_url"
    t.boolean  "auto_self_bcc",                                                                     default: false
    t.integer  "reorder_days",                                                                      default: 1
    t.boolean  "use_sms"
    t.string   "sms_send_number"
    t.boolean  "show_sales",                                                                        default: false
    t.string   "job_titles"
    t.boolean  "budget_lock",                                                                       default: false
    t.boolean  "lead_to_psv"
    t.datetime "s3_key_created"
    t.string   "backup_api_key"
    t.boolean  "show_inquiries",                                                                    default: false
    t.integer  "default_inquiry_user_id"
    t.boolean  "allow_email_validation",                                                            default: false
    t.integer  "inquiry_email_template"
    t.string   "blog"
    t.string   "linked_in"
    t.boolean  "inquiry_auto_assign_estimate",                                                      default: true
    t.integer  "portal_proof_comment_template_id"
    t.integer  "portal_proof_approved_template_id"
    t.integer  "portal_proof_approved_production_location_id"
    t.integer  "portal_proof_amended_production_location_id"
    t.boolean  "show_lead_types",                                                                   default: false
    t.boolean  "use_new_lead"
    t.integer  "default_lead_type_id"
    t.string   "mbe_refresh_token"
    t.datetime "mbe_refresh_token_expire_at"
    t.string   "mbe_access_token"
    t.datetime "mbe_access_token_expire_at"
    t.string   "mbe_tenant_id"
    t.string   "mbe_multistore_id"
    t.string   "mbe_store_id"
    t.string   "address_3"
    t.string   "mbe_username"
    t.string   "mbe_password"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.string   "mbe_api_base_url"
    t.string   "mbe_api_basic_auth_token"
    t.integer  "shipment_email_template"
    t.jsonb    "inquiry_notifications"
    t.string   "youtube"
    t.boolean  "show_shipments_tags",                                                               default: true
    t.boolean  "show_inquiries_tags",                                                               default: true
  end

  add_index "tenants", ["enterprise_id"], name: "index_tenants_on_enterprise_id", using: :btree
  add_index "tenants", ["id", "inital_import_complete"], name: "tenant_id", using: :btree

  create_table "tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.string   "access_token",               limit: 255
    t.string   "refresh_token",              limit: 255
    t.datetime "expires_at",                             precision: 6
    t.datetime "created_at",                             precision: 6
    t.datetime "updated_at",                             precision: 6
    t.string   "sync_token"
    t.string   "gmail_sync_token"
    t.string   "gmail_history_id"
    t.string   "encrypted_access_token"
    t.string   "encrypted_access_token_iv"
    t.string   "encrypted_refresh_token"
    t.string   "encrypted_refresh_token_iv"
  end

  add_index "tokens", ["tenant_id"], name: "index_tokens_on_tenant_id", using: :btree
  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id", using: :btree

  create_table "tracker_hits", force: :cascade do |t|
    t.integer  "tracker_id"
    t.datetime "created_at",     precision: 6, null: false
    t.datetime "updated_at",     precision: 6, null: false
    t.text     "user_agent"
    t.text     "referer"
    t.boolean  "bot"
    t.boolean  "browser_modern"
    t.string   "browser"
    t.string   "device"
    t.string   "platform"
  end

  add_index "tracker_hits", ["tracker_id"], name: "index_tracker_hits_on_tracker_id", using: :btree

  create_table "trackers", force: :cascade do |t|
    t.text     "uuid"
    t.integer  "method"
    t.text     "path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "trackers", ["uuid"], name: "index_trackers_on_uuid", using: :btree

  create_table "unsubscribes", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "contact_id"
    t.string   "unsub_type"
    t.string   "email"
    t.jsonb    "data",             default: {}
    t.boolean  "fixed",            default: false
    t.integer  "fixed_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unsubscribes", ["contact_id", "unsub_type", "email"], name: "index_unsubscribes_contact_new_email", where: "((unsub_type)::text = ANY (ARRAY[('hard_bounce'::character varying)::text, ('suppression_list'::character varying)::text]))", using: :btree
  add_index "unsubscribes", ["tenant_id", "contact_id", "unsub_type", "email", "fixed"], name: "index_unsubscribes_tenant_contact_type_email_fixed", where: "(fixed = false)", using: :btree
  add_index "unsubscribes", ["tenant_id", "contact_id", "unsub_type", "email", "fixed"], name: "index_unsubscribes_tenant_contact_type_email_not_fixed", where: "(fixed = true)", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "manual_email",                limit: 255,               default: ""
    t.string   "encrypted_password",          limit: 255,               default: "",    null: false
    t.string   "reset_password_token",        limit: 255
    t.datetime "reset_password_sent_at",                  precision: 6
    t.datetime "remember_created_at",                     precision: 6
    t.integer  "sign_in_count",                                         default: 0
    t.datetime "current_sign_in_at",                      precision: 6
    t.datetime "last_sign_in_at",                         precision: 6
    t.string   "current_sign_in_ip",          limit: 255
    t.string   "last_sign_in_ip",             limit: 255
    t.datetime "created_at",                              precision: 6
    t.datetime "updated_at",                              precision: 6
    t.string   "username",                    limit: 255
    t.string   "first_name",                  limit: 255
    t.string   "last_name",                   limit: 255
    t.integer  "roles_mask"
    t.string   "gmail_username",              limit: 255
    t.string   "gmail_password",              limit: 255
    t.string   "test_email",                  limit: 255
    t.text     "email_signature"
    t.hstore   "settings"
    t.boolean  "hide",                                                  default: false
    t.string   "role"
    t.datetime "deleted_at"
    t.integer  "task_calendar_color"
    t.string   "display_name"
    t.string   "api_token"
    t.string   "ip_whitelist"
    t.integer  "sash_id"
    t.integer  "level",                                                 default: 0
    t.date     "current_date_for_ui"
    t.boolean  "marketing_calendar_events",                             default: false
    t.datetime "eula_accepted_at"
    t.string   "default_alias"
    t.integer  "enterprise_id"
    t.integer  "banner_id"
    t.string   "phone"
    t.boolean  "lock_sales_rep",                                        default: false
    t.boolean  "add_task_to_my_calendar",                               default: false
    t.string   "smtp_server"
    t.integer  "smtp_port"
    t.string   "smtp_username"
    t.string   "smtp_password"
    t.boolean  "hide_reports",                                          default: false
    t.string   "email_notifications"
    t.string   "sms_test_number"
    t.datetime "last_token_refresh_time"
    t.integer  "failed_attempts",                                       default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "external_id"
    t.text     "mbe_access_token"
    t.text     "mbe_refresh_token"
    t.datetime "mbe_refresh_token_expire_at"
    t.string   "platform_id"
    t.jsonb    "platform_data"
    t.boolean  "sso_onboarding"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["enterprise_id"], name: "index_users_on_enterprise_id", using: :btree
  add_index "users", ["external_id"], name: "index_users_on_external_id", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "workflows", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.integer  "user_id",                       null: false
    t.boolean  "global",        default: false
    t.boolean  "site_wide",     default: false
    t.integer  "tenant_id"
    t.integer  "enterprise_id",                 null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "workflows", ["company_id"], name: "index_workflows_on_company_id", using: :btree
  add_index "workflows", ["tenant_id"], name: "index_workflows_on_tenant_id", using: :btree

  add_foreign_key "calendar_entries", "calendars", name: "calendar_entries_calendar_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "enterprise_salestargets", "enterprises"
  add_foreign_key "enterprise_salestargets", "prospect_statuses"
  add_foreign_key "groups", "enterprises"
  add_foreign_key "inquiries", "tenants"
  add_foreign_key "inquiry_attachments", "inquiries"
  add_foreign_key "invoices", "invoices", column: "sale_id"
  add_foreign_key "locations", "tenants"
  add_foreign_key "news", "enterprises"
  add_foreign_key "next_activities", "tenants"
  add_foreign_key "prospect_status_item_contacts", "contacts"
  add_foreign_key "prospect_status_item_contacts", "prospect_status_items"
  add_foreign_key "prospect_status_item_contacts", "tenants"
  add_foreign_key "report_rows", "reports"
  add_foreign_key "sales_tag_by_months", "tenants"
  add_foreign_key "salestargets", "tenants"
  add_foreign_key "tags", "tenants"
  add_foreign_key "tags", "users"
  add_foreign_key "users", "enterprises"
end
