@tables = []

def add_table(table)
  @tables.push(table)
  table
end

def add_index(table, table_name, columns, **opts)
  table[:indexes] = [] if table[:indexes].nil?

  table[:indexes].push(columns: columns).merge(opts)
end

t = add_table({ table: :account_history_data, force: :cascade, columns: [
    { column: :source_account_id                                            , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :balance          ,                     type: :decimal },
    { column: :currentagingbucket                                           , type: :integer },
    { column: :custpo },
    { column: :finalpaychecknumber },
    { column: :finalpaypaymethod },
    { column: :finalpayrefnumber },
    { column: :finalpaytotal          ,               type: :decimal },
    { column: :finalpaymentdate          ,            type: :datetime },
    { column: :financecharge                                            , type: :integer },
    { column: :source_invoice_id                                            , type: :integer },
    { column: :invoice_id                                           , type: :integer },
    { column: :invoicenumber },
    { column: :source_journal_id                                            , type: :integer },
    { column: :adjustment_id                                            , type: :integer },
    { column: :memoforcedtaxadded          ,                                   default: false },
    { column: :memoforcedtaxremoval          ,                                 default: false },
    { column: :name                                       , type: :text },
    { column: :ordernodisplay },
    { column: :partialpayamount          ,            type: :decimal },
    { column: :partialpaychecknumber },
    { column: :partialpaycnt          ,               type: :decimal },
    { column: :partialpaypaymethod },
    { column: :partialpaypaydate          ,           type: :datetime },
    { column: :partialpayrefnumber },
    { column: :partialpaytotal          ,             type: :decimal },
    { column: :paymentduedate          ,              type: :datetime },
    { column: :posteddate          ,                  type: :datetime },
    { column: :recordtype },
    { column: :refundtotal          ,                 type: :decimal },
    { column: :storenum },
    { column: :storenumber },
    { column: :subtotalposted          ,              type: :decimal },
    { column: :total          ,                       type: :decimal },
    { column: :usersalesname },
    { column: :webreferenceid                                           , type: :integer },
    { column: :finalpaycct_id                                           , type: :integer },
    { column: :finalpaymentcreditcard_id                                            , type: :integer },
    { column: :partialpaycct_id                                           , type: :integer },
    { column: :partialpaymentcreditcard_id                                            , type: :integer },
    { column: :totaltax_id                                            , type: :integer },
    { column: :created_at          ,                  type: :datetime          ,                            null: false },
    { column: :updated_at          ,                  type: :datetime          ,                            null: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :deleted          ,                                              default: false },
    { column: :dirty          ,                                                default: false },
    { column: :ready          ,                                                default: false },
    { column: :associations_complete          ,                                default: false },
    { column: :assocation_checks          ,                                    default: 0                                           , type: :integer },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :platform_id },
    { column: :platform_data                                           , type: :jsonb }
    ] })

  add_index(t, "account_history_data"          , ["printsmith_id"]          , name: "index_account_history_data_on_printsmith_id"          , using: :btree)
  add_index(t, "account_history_data"          , ["source_account_id"          , "tenant_id"          , "printsmith_id"          , "deleted"]          , name: "index_account_history_data_tenant_source_account"          , where: "(deleted = false)"          , using: :btree)
  add_index(t, "account_history_data"          , ["source_account_id"]          , name: "index_account_history_data_on_source_account_id"          , using: :btree)
  add_index(t, "account_history_data"          , ["source_journal_id"]          , name: "index_account_history_data_on_source_journal_id"          , using: :btree)
  add_index(t, "account_history_data"          , ["tenant_id"          , "source_invoice_id"          , "printsmith_id"          , "recordtype"]          , name: "index_account_history_data_source_invoice"          , where: "((recordtype)::text = '1'::text)"          , using: :btree)
  add_index(t, "account_history_data"          , ["tenant_id"          , "source_invoice_id"]          , name: "account_history_data_tenant_id_source_invoice_id_idx"          , using: :btree)

  t = add_table({ table: :action_logs, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :user_id                                            , type: :integer },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :location_id                                            , type: :integer },
    { column: :action },
    { column: :created_at          ,        null: false },
    { column: :updated_at          ,        null: false },
    { column: :context_id                                           , type: :integer },
    { column: :context_type }
    ] } )

  add_index(t, "action_logs"          , ["action"]          , name: "index_action_logs_on_action"          , using: :btree)
  add_index(t, "action_logs"          , ["location_id"]          , name: "index_action_logs_on_location_id"          , using: :btree)
  add_index(t, "action_logs"          , ["sales_rep_user_id"]          , name: "index_action_logs_on_sales_rep_user_id"          , using: :btree)
  add_index(t, "action_logs"          , ["tenant_id"]          , name: "index_action_logs_on_tenant_id"          , using: :btree)
  add_index(t, "action_logs"          , ["user_id"]          , name: "index_action_logs_on_user_id"          , using: :btree)

  t = add_table({ table: :activities, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :element_id                                           , type: :integer },
    { column: :element_type          ,        limit: 255 },
    { column: :created_at          ,                      type: :datetime },
    { column: :updated_at          ,                      type: :datetime },
    { column: :contact_id                                           , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :estimate_id                                            , type: :integer },
    { column: :invoice_id                                           , type: :integer },
    { column: :phone_call_id                                            , type: :integer },
    { column: :task_id                                            , type: :integer },
    { column: :email_id                                           , type: :integer },
    { column: :comment_id                                           , type: :integer },
    { column: :order_id                                           , type: :integer },
    { column: :sale_id                                            , type: :integer },
    { column: :tracker_id                                           , type: :integer },
    { column: :email_message_id                                           , type: :integer },
    { column: :note_id                                            , type: :integer },
    { column: :source_created_at },
    { column: :activity_for },
    { column: :hide          ,                                          default: false },
    { column: :campaign_id                                            , type: :integer },
    { column: :campaign_message_id                                            , type: :integer },
    { column: :parent_contact_id                                            , type: :integer },
    { column: :deleted          ,                                       default: false },
    { column: :portal_comment_id                                            , type: :integer },
    { column: :meeting_id                                           , type: :integer },
    { column: :inquiry_id                                           , type: :integer },
    { column: :shipment_id                                            , type: :integer }
    ] } )

  add_index(t, "activities"          , ["activity_for"          , "email_id"          , "tenant_id"          , "company_id"          , "source_created_at"          , "hide"]          , name: "index_activities_for_email_company"          , where: "(((activity_for)::text = 'email'::text) AND (email_id IS NOT NULL) AND (company_id IS NOT NULL) AND (hide = false))"          , using: :btree)
  add_index(t, "activities"          , ["activity_for"          , "email_id"          , "tenant_id"          , "contact_id"          , "source_created_at"          , "hide"]          , name: "index_activities_for_email_contact"          , where: "(((activity_for)::text = 'email'::text) AND (email_id IS NOT NULL) AND (contact_id IS NOT NULL) AND (hide = false))"          , using: :btree)
  add_index(t, "activities"          , ["activity_for"]          , name: "index_activities_on_activity_for"          , using: :btree)
  add_index(t, "activities"          , ["activity_for"]          , name: "index_activities_on_activity_for_email"          , where: "((activity_for)::text = 'email'::text)"          , using: :btree)
  add_index(t, "activities"          , ["activity_for"]          , name: "index_activities_on_activity_for_phone_call"          , where: "((activity_for)::text = 'phone_call'::text)"          , using: :btree)
  add_index(t, "activities"          , ["company_id"]          , name: "index_activities_on_company_id"          , using: :btree)
  add_index(t, "activities"          , ["contact_id"]          , name: "index_activities_on_contact_id"          , using: :btree)
  add_index(t, "activities"          , ["deleted"]          , name: "index_activities_on_deleted"          , using: :btree)
  add_index(t, "activities"          , ["email_id"]          , name: "index_activities_on_email_id"          , using: :btree)
  add_index(t, "activities"          , ["estimate_id"]          , name: "index_activities_on_estimate_id"          , using: :btree)
  add_index(t, "activities"          , ["invoice_id"]          , name: "index_activities_on_invoice_id"          , using: :btree)
  add_index(t, "activities"          , ["phone_call_id"]          , name: "index_activities_on_phone_call_id"          , using: :btree)
  add_index(t, "activities"          , ["source_created_at"]          , name: "index_activities_on_source_created_at"          , order: {"source_created_at"=>:desc}          , using: :btree)
  add_index(t, "activities"          , ["task_id"]          , name: "index_activities_on_task_id"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "activity_for"          , "campaign_id"          , "campaign_message_id"          , "tracker_id"          , "source_created_at"          , "hide"          , "deleted"]          , name: "index_activities_campaign_opened"          , order: {"source_created_at"=>:desc}          , where: "(((activity_for)::text = 'campaign_opened'::text) AND (NOT hide) AND (NOT deleted))"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "activity_for"          , "campaign_id"          , "source_created_at"          , "hide"          , "deleted"]          , name: "index_activities_campaign_opened_aggregated"          , order: {"source_created_at"=>:desc}          , where: "(((activity_for)::text = 'campaign_opened_aggregated'::text) AND (NOT hide) AND (NOT deleted))"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "company_id"          , "contact_id"          , "estimate_id"          , "id"]          , name: "index_activities_tenant_company_contact_estimate"          , where: "(estimate_id IS NOT NULL)"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "company_id"          , "contact_id"          , "invoice_id"          , "id"]          , name: "index_activities_tenant_company_contact_invoice"          , where: "(invoice_id IS NOT NULL)"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "shipment_id"          , "hide"          , "deleted"]          , name: "index_activities_on_shipment_id"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"          , "created_at"          , "deleted"          , "hide"          , "activity_for"]          , name: "index_activities_new"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"          , "estimate_id"          , "invoice_id"          , "company_id"          , "contact_id"          , "id"]          , name: "index_activities_tenant_estiamte_invoice_source_created"          , order: {"source_created_at"=>:desc}          , where: "((estimate_id IS NOT NULL) AND (invoice_id IS NULL))"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"          , "invoice_id"          , "company_id"          , "contact_id"          , "id"]          , name: "index_activities_tenant_invoice_source_created"          , order: {"source_created_at"=>:desc}          , where: "(invoice_id IS NOT NULL)"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"]          , name: "activities_tenant_id_source_created_at_idx"          , order: {"source_created_at"=>:desc}          , where: "((hide = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"]          , name: "activity_test"          , order: {"source_created_at"=>:desc}          , where: "((estimate_id IS NOT NULL) AND (invoice_id IS NULL))"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"]          , name: "activity_test2"          , order: {"source_created_at"=>:desc}          , where: "(invoice_id IS NOT NULL)"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"]          , name: "index_activities_on_tenant_source_created_at_estimate"          , order: {"source_created_at"=>:desc}          , where: "((estimate_id IS NOT NULL) AND (invoice_id IS NULL))"          , using: :btree)
  add_index(t, "activities"          , ["tenant_id"          , "source_created_at"]          , name: "index_activities_on_tenant_source_created_at_invoice"          , order: {"source_created_at"=>:desc}          , where: "(invoice_id IS NOT NULL)"          , using: :btree)
  add_index(t, "activities"          , ["user_id"]          , name: "index_activities_on_user_id"          , using: :btree)

  t = add_table({ table: :addresses, force: :cascade, columns: [
    { column: :city },
    { column: :country },
    { column: :deleted          ,                         default: false },
    { column: :manualchange },
    { column: :name },
    { column: :state },
    { column: :street1 },
    { column: :street2 },
    { column: :street3 },
    { column: :webid },
    { column: :zip },
    { column: :zone },
    { column: :printsmith_id                                            , type: :integer },
    { column: :dirty          ,                           default: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,        type: :datetime },
    { column: :updated_at          ,        type: :datetime },
    { column: :latitude                                            , type: :float },
    { column: :longitude                                          , type: :float },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :company_id                                           , type: :integer },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :external_id }
    ] } )

  add_index(t, "addresses"          , ["company_id"]          , name: "index_addresses_on_company_id"          , using: :btree)
  add_index(t, "addresses"          , ["printsmith_id"          , "tenant_id"]          , name: "printsmith_id"          , using: :btree)

  t = add_table({ table: :adjustments, force: :cascade, columns: [
    { column: :total },
    { column: :invoice_id                                           , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,             type: :datetime },
    { column: :updated_at          ,             type: :datetime },
    { column: :printsmith_id                                            , type: :integer },
    { column: :dirty },
    { column: :deleted          ,                              default: false },
    { column: :ready          ,                                default: false },
    { column: :associations_complete          ,                default: false },
    { column: :assocation_checks          ,                    default: 0                                           , type: :integer },
    { column: :source_account_id                                            , type: :integer },
    { column: :source_invoice_id                                            , type: :integer },
    { column: :affect_sales          ,                         default: false },
    { column: :posted_date          ,            type: :datetime },
    { column: :final_payment_date          ,     type: :datetime },
    { column: :voided          ,                               default: false },
    { column: :accounting_month                                           , type: :integer },
    { column: :accounting_year                                            , type: :integer },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :description },
    { column: :comment },
    { column: :source_sales_rep },
    { column: :reference_number },
    { column: :last_refreshed_at },
    { column: :last_refreshed_version                                           , type: :integer },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :location_user_id                                           , type: :integer },
    { column: :sales_summary_id                                           , type: :integer },
    { column: :daily_accounting_day                                           , type: :integer },
    { column: :daily_accounting_month                                           , type: :integer },
    { column: :daily_accounting_year                                            , type: :integer },
    { column: :daily_sales_summary_id                                           , type: :integer },
    { column: :total_less_non_sales          ,                 default: 0.0 },
    { column: :markups          ,                              default: 0.0 },
    { column: :discounts          ,                            default: 0.0 },
    { column: :shipping          ,                             default: 0.0 },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  add_index(t, "adjustments"          , ["accounting_year"]          , name: "index_adjustments_on_accounting_year"          , using: :btree)
  add_index(t, "adjustments"          , ["affect_sales"          , "deleted"          , "voided"          , "id"]          , name: "index_adjustments_affect_sales"          , where: "((affect_sales = true) AND (deleted = false) AND (voided = false))"          , using: :btree)
  add_index(t, "adjustments"          , ["company_id"]          , name: "index_adjustments_on_company_id"          , using: :btree)
  add_index(t, "adjustments"          , ["daily_sales_summary_id"          , "total"]          , name: "index_adjustments_daily_sales_summary_id_totals"          , using: :btree)
  add_index(t, "adjustments"          , ["posted_date"]          , name: "index_adjustments_on_posted_date"          , using: :btree)
  add_index(t, "adjustments"          , ["sales_summary_id"          , "posted_date"]          , name: "index_adjustments_sales_summary_id_posted_date"          , where: "(sales_summary_id IS NOT NULL)"          , using: :btree)
  add_index(t, "adjustments"          , ["tenant_id"          , "accounting_month"          , "accounting_year"          , "posted_date"          , "total"          , "voided"          , "deleted"]          , name: "index_adjustments_accounting_month_year"          , where: "((voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "adjustments"          , ["tenant_id"          , "company_id"          , "invoice_id"          , "id"]          , name: "index_adjustments_tenant_id_company_invoice"          , using: :btree)
  add_index(t, "adjustments"          , ["tenant_id"          , "last_refreshed_at"          , "last_refreshed_version"]          , name: "adjustments_refresh_index"          , using: :btree)
  add_index(t, "adjustments"          , ["tenant_id"          , "printsmith_id"]          , name: "index_adjustments_on_tenant_id_and_printsmith_id"          , using: :btree)
  add_index(t, "adjustments"          , ["tenant_id"]          , name: "adjustments_dirty_index"          , where: "(dirty = true)"          , using: :btree)

  t = add_table({ table: :affiliations, force: :cascade, columns: [
    { column: :user_id                                           , type: :integer },
    { column: :tenant_id                                           , type: :integer },
    { column: :primary }
    ] } )

  add_index(t, "affiliations"          , ["tenant_id"]          , name: "index_affiliations_on_tenant_id"          , using: :btree)
  add_index(t, "affiliations"          , ["user_id"]          , name: "index_affiliations_on_user_id"          , using: :btree)

  t = add_table({ table: :api_logs, force: :cascade, columns: [
    { column: :url },
    { column: :body                                              , type: :jsonb },
    { column: :response_message },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :user_id                                            , type: :integer },
    { column: :created_at },
    { column: :updated_at },
    { column: :tenant_id                                            , type: :integer },
    { column: :retry_count                                            , type: :integer },
    { column: :status }
    ] } )

  add_index(t, "api_logs"          , ["context_id"          , "context_type"          , "body"]          , name: "api_logs_context_id_context_type_body_idx"          , using: :btree)
  add_index(t, "api_logs"          , ["tenant_id"]          , name: "index_api_logs_on_tenant_id"          , using: :btree)

  t = add_table({ table: :assets, force: :cascade, columns: [
    { column: :category },
    { column: :file_name },
    { column: :file_hash },
    { column: :content_type },
    { column: :created_at          ,                    null: false },
    { column: :updated_at          ,                    null: false },
    { column: :enterprise_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :tracker_id                                           , type: :integer },
    { column: :archived          ,      default: false },
    { column: :meta_data                       ,     default: {}                                , type: :jsonb },
    { column: :global          ,        default: false }
    ] } )

  add_index(t, "assets"          , ["category"]          , name: "index_assets_on_category"          , using: :btree)
  add_index(t, "assets"          , ["context_id"          , "context_type"          , "file_hash"]          , name: "assets_context_id_context_type_file_hash_idx"          , using: :btree)
  add_index(t, "assets"          , ["tenant_id"          , "context_type"          , "file_hash"          , "created_at"]          , name: "index_assets_pending"          , where: "(((context_type)::text = 'PendingAttachment'::text) AND (file_hash IS NOT NULL))"          , using: :btree)

  t = add_table({ table: :background_job_results, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :user_id                                            , type: :integer },
    { column: :job_hash },
    { column: :job_type },
    { column: :name },
    { column: :description },
    { column: :status_view },
    { column: :completed_view },
    { column: :data                                              , type: :jsonb },
    { column: :result                                              , type: :jsonb },
    { column: :expires_at },
    { column: :created_at },
    { column: :updated_at }
    ] } )

  t = add_table({ table: :background_jobs, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :user_id                                            , type: :integer },
    { column: :job_type },
    { column: :name },
    { column: :description },
    { column: :status_view },
    { column: :completed_view },
    { column: :data                                              , type: :jsonb },
    { column: :result                                              , type: :jsonb },
    { column: :complete          ,       default: false },
    { column: :created_at },
    { column: :updated_at },
    { column: :status },
    { column: :completed_at },
    { column: :job_hash }
    ] } )

  t = add_table({ table: :backups, force: :cascade, columns: [
    { column: :tenant_id          ,                               null: false                                           , type: :integer },
    { column: :filename          ,                                null: false },
    { column: :created_at          , type: :datetime          ,                null: false },
    { column: :updated_at          , type: :datetime          ,                null: false },
    { column: :success          ,                  default: true }
    ] } )

  add_index(t, "backups"          , ["tenant_id"]          , name: "index_backups_on_tenant_id"          , using: :btree)

  t = add_table({ table: :badges_sashes, force: :cascade, columns: [
    { column: :badge_id                                           , type: :integer },
    { column: :sash_id                                            , type: :integer },
    { column: :notified_user          , default: false },
    { column: :created_at }
    ] } )

  t = add_table({ table: :bookmarks, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :created_at          ,   null: false },
    { column: :updated_at          ,   null: false }
    ] } )

  add_index(t, "bookmarks"          , ["context_id"          , "user_id"          , "context_type"]          , name: "bookmarks_context_id_user_id_context_type_idx"          , using: :btree)

  t = add_table({ table: :budget_months, force: :cascade, columns: [
    { column: :budget_id          ,                            null: false                                            , type: :integer },
    { column: :total          ,                    default: 0          , null: false                                            , type: :integer },
    { column: :created_at          , type: :datetime },
    { column: :updated_at          , type: :datetime },
    { column: :month_date                   , type: :date }
    ] } )

  t = add_table({ table: :budgets, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :financial_year                                           , type: :integer },
    { column: :created_at          ,     type: :datetime },
    { column: :updated_at          ,     type: :datetime },
    { column: :comp_perc                                            , type: :integer }
    ] } )

  add_index(t, "budgets"          , ["tenant_id"          , "financial_year"]          , name: "index_budgets_on_tenant_id_and_financial_year"          , unique: true          , using: :btree)

  t = add_table({ table: :builds, force: :cascade, columns: [
    { column: :name                                       , type: :text },
    { column: :os                                       , type: :text },
    { column: :checksum                                       , type: :text },
    { column: :created_at          , type: :datetime          , null: false },
    { column: :updated_at          , type: :datetime          , null: false }
    ] } )

  t = add_table({ table: :calendar_entries, force: :cascade, columns: [
    { column: :calendar_id          ,                               null: false                                           , type: :integer },
    { column: :entry_ident          ,                               null: false                                       , type: :text },
    { column: :start_time          ,  type: :datetime },
    { column: :end_time          ,    type: :datetime },
    { column: :summary                                        , type: :text },
    { column: :description                                        , type: :text },
    { column: :updated          ,                   default: false }
    ] } )

  add_index(t, "calendar_entries"          , ["calendar_id"          , "entry_ident"]          , name: "calendar_entries_calendar_id_entry_ident_key"          , unique: true          , using: :btree)
  add_index(t, "calendar_entries"          , ["entry_ident"          , "updated"          , "start_time"          , "id"]          , name: "index_calendar_entries_on_entry_ident"          , where: "(updated = true)"          , using: :btree)
  add_index(t, "calendar_entries"          , ["updated"]          , name: "tmp_fix_6"          , using: :btree)

  t = add_table({ table: :calendar_entry_deletions, force: :cascade, columns: [
    { column: :user_id                                           , type: :integer },
    { column: :calendar_ident },
    { column: :entry_ident },
    { column: :send_updates          ,   default: false }
    ] } )

  t = add_table({ table: :calendars, force: :cascade, columns: [
    { column: :calendar_ident                                       , type: :text },
    { column: :last_sync          ,       type: :datetime },
    { column: :user_id                                            , type: :integer },
    { column: :next_sync_token                                        , type: :text },
    { column: :timezone                                       , type: :text },
    { column: :user_ids          ,                      default: []          , array: true                                            , type: :integer }
    ] } )

  add_index(t, "calendars"          , ["calendar_ident"          , "id"]          , name: "index_calendars_calendar_ident"          , where: "(array_length(user_ids          , 1) > 0)"          , using: :btree)
  add_index(t, "calendars"          , ["user_id"]          , name: "calendar_ids_calendar_ids_user_id_fk_idx"          , using: :btree)
  add_index(t, "calendars"          , ["user_ids"]          , name: "index_calendars_user_ids"          , using: :gin)

  t = add_table({ table: :campaign_calendar_entries, force: :cascade, columns: [
    { column: :campaign_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :user_id                                            , type: :integer },
    { column: :calendar_entry_id },
    { column: :date }
    ] } )

  add_index(t, "campaign_calendar_entries"          , ["campaign_id"          , "tenant_id"]          , name: "index_campaign_calendar_entries_campaign_tenant"          , using: :btree)

  t = add_table({ table: :campaign_counts, force: :cascade, columns: [
    { column: :tenant_id                                           , type: :integer },
    { column: :campaign_id                                           , type: :integer },
    { column: :total_count                                           , type: :integer }
    ] } )

  t = add_table({ table: :campaign_exclusions, force: :cascade, columns: [
    { column: :campaign_id                                           , type: :integer },
    { column: :contact_id                                            , type: :integer }
    ] } )

  add_index(t, "campaign_exclusions"          , ["campaign_id"          , "contact_id"]          , name: "index_campaign_exclusions_on_campaign_id"          , using: :btree)
  add_index(t, "campaign_exclusions"          , ["contact_id"]          , name: "index_campaign_exclusions_on_contact_id"          , using: :btree)

  t = add_table({ table: :campaign_groups, force: :cascade, columns: [
    { column: :name },
    { column: :primary_id          ,    default: 0                                           , type: :integer },
    { column: :campaign_ids          ,  default: []          , array: true                                           , type: :integer },
    { column: :enterprise_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :campaign_messages, force: :cascade, columns: [
    { column: :campaign_id                                            , type: :integer },
    { column: :contact_id                                           , type: :integer },
    { column: :opened },
    { column: :sent },
    { column: :created_at          ,        type: :datetime          ,                 null: false },
    { column: :updated_at          ,        type: :datetime          ,                 null: false },
    { column: :failed          ,                          default: false },
    { column: :note                                       , type: :text },
    { column: :parent_message_id                                            , type: :integer },
    { column: :sent_date },
    { column: :failed_reason },
    { column: :unsubscribed          ,                    default: false },
    { column: :parent_contact_id                                            , type: :integer },
    { column: :sent_message_id },
    { column: :complaint },
    { column: :delivered          ,                       default: false },
    { column: :fixed          ,                           default: false },
    { column: :tenant_id                                            , type: :integer }
    ] } )

  add_index(t, "campaign_messages"          , ["campaign_id"          , "contact_id"          , "sent"          , "failed"          , "sent_date"          , "created_at"          , "id"]          , name: "index_campaign_messages_campaign_contact_status_dates"          , order: {"sent_date"=>:desc          , "created_at"=>:desc}          , using: :btree)
  add_index(t, "campaign_messages"          , ["campaign_id"]          , name: "index_campaign_messages_on_campaign_id"          , using: :btree)
  add_index(t, "campaign_messages"          , ["contact_id"]          , name: "index_campaign_messages_on_contact_id"          , using: :btree)
  add_index(t, "campaign_messages"          , ["parent_contact_id"]          , name: "index_campaign_messages_on_parent_contact_id"          , using: :btree)
  add_index(t, "campaign_messages"          , ["parent_message_id"]          , name: "index_campaign_messages_parent"          , using: :btree)
  add_index(t, "campaign_messages"          , ["sent_message_id"          , "id"]          , name: "index_campaign_messages_sent_message"          , using: :btree)
  add_index(t, "campaign_messages"          , ["tenant_id"          , "contact_id"          , "campaign_id"          , "sent"          , "opened"          , "failed"          , "unsubscribed"          , "id"]          , name: "index_campaign_messages_tenant_stats"          , using: :btree)

  t = add_table({ table: :campaign_messages_trackers, id: false, force: :cascade, columns: [
    { column: :campaign_message_id                                           , type: :integer },
    { column: :tracker_id                                            , type: :integer }
    ] } )

  add_index(t, "campaign_messages_trackers"          , ["campaign_message_id"]          , name: "index_campaign_messages_trackers_on_campaign_message_id"          , using: :btree)
  add_index(t, "campaign_messages_trackers"          , ["tracker_id"]          , name: "index_campaign_messages_trackers_on_tracker_id"          , using: :btree)

  t = add_table({ table: :campaigns, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :name                                       , type: :text },
    { column: :description                                        , type: :text },
    { column: :global },
    { column: :status                                           , type: :integer },
    { column: :method                                           , type: :integer },
    { column: :subject                                        , type: :text },
    { column: :body                                       , type: :text },
    { column: :created_at          ,                  type: :datetime          ,                  null: false },
    { column: :updated_at          ,                  type: :datetime          ,                  null: false },
    { column: :email_template_id                                            , type: :integer },
    { column: :user_id                                            , type: :integer },
    { column: :parent_id                                            , type: :integer },
    { column: :test          ,                                      default: false },
    { column: :identity_id                                            , type: :integer },
    { column: :scheduled          ,                                 default: false },
    { column: :schedule_weekday          ,                          default: 0                                            , type: :integer },
    { column: :scheduled_at },
    { column: :schedule_week          ,                             default: 1                                            , type: :integer },
    { column: :schedule_hour          ,                             default: 10                                           , type: :integer },
    { column: :allow_override          ,                            default: false },
    { column: :test_confirmed          ,                            default: false },
    { column: :clear_exclusions          ,                          default: false },
    { column: :enterprise_id                                            , type: :integer },
    { column: :hidden_tenants                        ,                            default: {}                                , type: :jsonb },
    { column: :enterprise_campaign          ,                       default: false },
    { column: :selected_tenants          ,                          default: []          ,                  array: true                                           , type: :integer },
    { column: :test_emails          ,                               default: []          ,                  array: true },
    { column: :global_hide          ,                               default: false },
    { column: :paused          ,                                    default: false },
    { column: :schedule_date          ,                             default: []          ,                  array: true },
    { column: :schedule_interval_type          ,                    default: "none" },
    { column: :schedule_interval          ,                         default: 1                                            , type: :integer },
    { column: :schedule_day_lock          ,                         default: "none" },
    { column: :schedule_auto_send          ,                        default: false },
    { column: :auto_send_tenants          ,                         default: []          ,                  array: true                                           , type: :integer },
    { column: :alerts                        ,                                    default: {}                                , type: :jsonb },
    { column: :approvals                       ,                                 default: {}                                , type: :jsonb },
    { column: :auto_send_throttle_override          ,               default: false },
    { column: :auto_approve          ,                              default: false },
    { column: :skips                       ,                                     default: {}                                , type: :jsonb }
    ] } )

  add_index(t, "campaigns"          , ["body"]          , name: "index_campaigns_body_parent"          , where: "(parent_id IS NULL)"          , using: :hash)
  add_index(t, "campaigns"          , ["body"]          , name: "index_campaigns_body_test"          , where: "(test = true)"          , using: :hash)
  add_index(t, "campaigns"          , ["email_template_id"]          , name: "index_campaigns_on_email_template_id"          , using: :btree)
  add_index(t, "campaigns"          , ["enterprise_id"]          , name: "index_campaigns_on_enterprise_id"          , using: :btree)
  add_index(t, "campaigns"          , ["id"          , "tenant_id"          , "test"          , "paused"]          , name: "index_campaigns_id_tenant_not_test"          , where: "(test = false)"          , using: :btree)
  add_index(t, "campaigns"          , ["parent_id"          , "test"          , "tenant_id"]          , name: "index_campaigns_parent_id_md5_body_test"          , where: "(test = true)"          , using: :btree)
  add_index(t, "campaigns"          , ["tenant_id"          , "parent_id"          , "test"          , "created_at"]          , name: "index_campaigns_on_tenant_parent_created_at_not_test"          , order: {"created_at"=>:desc}          , where: "(test <> false)"          , using: :btree)
  add_index(t, "campaigns"          , ["tenant_id"          , "test"          , "paused"          , "parent_id"          , "id"]          , name: "index_campaigns_tenant_id_test_paused"          , where: "(NOT test)"          , using: :btree)
  add_index(t, "campaigns"          , ["tenant_id"]          , name: "index_campaigns_on_tenant_id"          , using: :btree)
  add_index(t, "campaigns"          , ["user_id"]          , name: "index_campaigns_on_user_id"          , using: :btree)

  t = add_table({ table: :campaigns_contact_lists, id: false, force: :cascade, columns: [
    { column: :campaign_id                                           , type: :integer },
    { column: :contact_list_id                                           , type: :integer }
    ] } )

  add_index(t, "campaigns_contact_lists"          , ["campaign_id"]          , name: "index_campaigns_contact_lists_on_campaign_id"          , using: :btree)
  add_index(t, "campaigns_contact_lists"          , ["contact_list_id"]          , name: "index_campaigns_contact_lists_on_contact_list_id"          , using: :btree)

  t = add_table({ table: :cash_drawers, force: :cascade, columns: [
    { column: :amount          ,            type: :decimal },
    { column: :arbalance          ,         type: :decimal },
    { column: :cardcount                                            , type: :integer },
    { column: :cardtotal          ,         type: :decimal },
    { column: :cashtotal          ,         type: :decimal },
    { column: :changefund          ,        type: :decimal },
    { column: :checkcount                                           , type: :integer },
    { column: :checktotal          ,        type: :decimal },
    { column: :fund          ,              type: :decimal },
    { column: :held          ,                                       default: false },
    { column: :deleted          ,                                    default: false },
    { column: :lastcloseoutdate          ,  type: :datetime },
    { column: :laststartupdate          ,   type: :datetime },
    { column: :paidouts          ,          type: :decimal },
    { column: :prevarbalance          ,     type: :decimal },
    { column: :transactiondate          ,   type: :datetime },
    { column: :created_at          ,        type: :datetime          ,                            null: false },
    { column: :updated_at          ,        type: :datetime          ,                            null: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :dirty          ,                                      default: false },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  t = add_table({ table: :clearbit_quota, force: :cascade, columns: [
    { column: :klass },
    { column: :used          ,       default: 0                                           , type: :integer },
    { column: :max          ,        default: 1000                                            , type: :integer },
    { column: :start_date },
    { column: :end_date }
    ] } )

  t = add_table({ table: :comments, force: :cascade, columns: [
    { column: :title          ,            limit: 50          ,                default: "" },
    { column: :comment                                        , type: :text },
    { column: :commentable_id                                           ,e: :integer },
    { column: :commentable_type, limit: 255 },
    { column: :user_id                                            , type: :integer },
    { column: :created_at          ,                   type: :datetime },
    { column: :updated_at          ,                   type: :datetime },
    { column: :tenant_id                                            , type: :integer }
    ] } )

  add_index(t, "comments"          , ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree)
  add_index(t, "comments"          , ["commentable_type"]          , name: "index_comments_on_commentable_type"         , using: :btree)
  add_index(t, "comments"          , ["tenant_id"]          , name: "index_comments_on_tenant_id"          , using: :btree)
  add_index(t, "comments"          , ["user_id"]          , name: "index_comments_on_user_id"          , using: :btree)

  t = add_table({ table: :companies, force: :cascade, columns: [
    { column: :name          ,                               limit: 255 },
    { column: :printsmith_id                                            , type: :integer },
    { column: :created_at          ,                                     type: :datetime },
    { column: :updated_at          ,                                     type: :datetime },
    { column: :tenant_id                                            , type: :integer },
    { column: :exclude_from_analysis },
    { column: :walk_in },
    { column: :dirty },
    { column: :deleted          ,                                                                 default: false },
    { column: :avg_conversion_ratio          ,                           type: :decimal },
    { column: :mtd_sales          ,                                      type: :decimal },
    { column: :ytd_sales          ,                                      type: :decimal },
    { column: :needs_recalc          ,                                                            default: true },
    { column: :sales_hash          ,                                                              type: :hstore                   , default: {} },
    { column: :mtd_rank                                           , type: :integer },
    { column: :ytd_rank                                           , type: :integer },
    { column: :ly_rank                                            , type: :integer },
    { column: :rolling_12_month_rank                                            , type: :integer },
    { column: :ly_sales          ,                                       type: :decimal },
    { column: :rolling_12_month_sales          ,                         type: :decimal },
    { column: :status },
    { column: :prospect          ,                                                                default: false },
    { column: :account_type },
    { column: :rolling_12_month_rank_ly                                           , type: :integer },
    { column: :rolling_12_month_sales_ly          ,                      type: :decimal },
    { column: :source_billtoaddress_id                                            , type: :integer },
    { column: :source_billtocontact_id                                            , type: :integer },
    { column: :source_salesrep_id                                           , type: :integer },
    { column: :source_shiptoaddress_id                                            , type: :integer },
    { column: :source_contact_id                                            , type: :integer },
    { column: :source_shippingmode_id                                           , type: :integer },
    { column: :source_taxtable_id                                           ,e: :integer },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :marketing_do_not_mail          ,                                                   default: false },
    { column: :needs_avg_conversion_ratio          ,                                              default: true },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :last_clearbit_data_fetch_date },
    { column: :rolling_12_month_cogs },
    { column: :last_order_date },
    { column: :growth_percentage          ,                                                       default: 0.0 },
    { column: :location_user_id                                           , type: :integer },
    { column: :lifetime_value          ,                                 type: :decimal },
    { column: :needs_lifetime_value_recalc          ,                                             default: true },
    { column: :oldest_interaction },
    { column: :rolling_1_month_sales          ,                                                   default: 0.0 },
    { column: :order_count          ,                                                             default: 0                                            , type: :integer },
    { column: :cache_data                        ,                                                              default: {}                                , type: :jsonb },
    { column: :last_viewed },
    { column: :has_clearbit_data          ,                                                       default: false },
    { column: :clearbit_data                       ,                                                           default: {}                                , type: :jsonb },
    { column: :custom_data                       ,                                                             default: {}                                , type: :jsonb },
    { column: :account_payable_id                                           , type: :integer },
    { column: :phone },
    { column: :master_account },
    { column: :lead_source },
    { column: :lead_source_2 },
    { column: :last_contact },
    { column: :last_email_sent },
    { column: :last_email_received },
    { column: :last_phone_call },
    { column: :rolling_12_month_rank_ly_ly                                            , type: :integer },
    { column: :rolling_12_month_sales_ly_ly          ,                   type: :decimal },
    { column: :rolling_12_month_rank_ly_previous                                            , type: :integer },
    { column: :rolling_12_month_sales_ly_previous },
    { column: :account_note },
    { column: :job_note },
    { column: :credit_limit          ,                                   type: :decimal },
    { column: :account_created_date },
    { column: :account_display_id },
    { column: :business_type_code },
    { column: :last_refreshed_at },
    { column: :last_refreshed_version                                           , type: :integer },
    { column: :company_created_date },
    { column: :web },
    { column: :balance          ,                                        type: :decimal },
    { column: :no_notifications          ,                                                        default: false },
    { column: :remote_sales_rep_update },
    { column: :last_pickup_date },
    { column: :single_sale_only_at },
    { column: :remote_lead_source_update },
    { column: :send_invoice_ap_contact },
    { column: :primary_contact_id                                           , type: :integer },
    { column: :prospect_status_id                                           , type: :integer },
    { column: :prospect_sentiment                                           , type: :integer },
    { column: :invoice_address_id                                           , type: :integer },
    { column: :statement_address_id                                           , type: :integer },
    { column: :est_spend                                            , type: :integer },
    { column: :conv_prob                                            , type: :integer },
    { column: :remote_account_update },
    { column: :lead_type_id                                           , type: :integer },
    { column: :created_ps },
    { column: :walk_in_lead_transfer_initial },
    { column: :walk_in_lead_transfer_to },
    { column: :external_id },
    { column: :last_meeting },
    { column: :is_lead },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :meta_data                       ,                                                               default: {}                                , type: :jsonb },
    { column: :mbe_center          ,                                                              default: false          , null: false },
    { column: :b2b          ,                                                                     default: false          , null: false },
    { column: :mbe_id          ,                                                                  default: "" },
    { column: :mbe_privilege          ,                                                           default: false },
    { column: :first_sale_at },
    { column: :sales_rep_platform_id },
    { column: :tmp_data                        ,                                                                default: {}                                , type: :jsonb }
    ] } )

  add_index(t, "companies"          , ["external_id"          , "tenant_id"]          , name: "index_companies_on_external_id_and_tenant_id"          , unique: true          , using: :btree)
  add_index(t, "companies"          , ["has_clearbit_data"          , "rolling_12_month_rank"          , "rolling_12_month_sales"          , "rolling_12_month_sales_ly"          , "tenant_id"          , "deleted"          , "walk_in"]          , name: "index_companies_clearbit"          , where: "((has_clearbit_data = false) AND (walk_in = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "companies"          , ["id"          , "invoice_address_id"          , "deleted"]          , name: "companies_invoice_retry"          , where: "(remote_account_update = true)"          , using: :btree)
  add_index(t, "companies"          , ["id"          , "marketing_do_not_mail"]          , name: "index_companies_id_do_not_mail"          , using: :btree)
  add_index(t, "companies"          , ["lead_type_id"]          , name: "index_companies_on_lead_type_id"          , using: :btree)
  add_index(t, "companies"          , ["location_user_id"]          , name: "index_companies_on_location_user_id"          , using: :btree)
  add_index(t, "companies"          , ["prospect_status_id"          , "prospect"          , "id"          , "deleted"]          , name: "index_companies_prospect_satatus_id"          , where: "((prospect = true) AND (prospect_status_id IS NOT NULL) AND (deleted = false))"          , using: :btree)
  add_index(t, "companies"          , ["remote_lead_source_update"]          , name: "index_companies_on_remote_lead_source_update"          , using: :btree)
  add_index(t, "companies"          , ["remote_sales_rep_update"]          , name: "index_companies_on_remote_sales_rep_update"          , using: :btree)
  add_index(t, "companies"          , ["sales_rep_user_id"          , "source_salesrep_id"]          , name: "companies_sales_rep_indexes"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "company_created_date"]          , name: "index_companies_on_tenant_id_and_company_created_date"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "deleted"          , "rolling_12_month_sales"          , "rolling_12_month_sales_ly"          , "id"          , "last_order_date"          , "last_pickup_date"          , "rolling_12_month_cogs"          , "growth_percentage"          , "order_count"]          , name: "index_companies_stats"          , where: "((deleted = false) AND ((rolling_12_month_sales > (0)::numeric) OR (rolling_12_month_sales_ly > (0)::numeric)))"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "deleted"          , "walk_in"          , "location_user_id"          , "source_salesrep_id"          , "printsmith_id"          , "single_sale_only_at"]          , name: "index_companies_on_single_sale_only_sales_rep_location"          , where: "((NOT deleted) AND (printsmith_id IS NOT NULL) AND (single_sale_only_at IS NOT NULL))"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "deleted"          , "walk_in"          , "sales_rep_user_id"          , "source_salesrep_id"          , "printsmith_id"          , "single_sale_only_at"]          , name: "index_companies_on_single_sale_only_sales_rep_user"          , where: "((NOT deleted) AND (printsmith_id IS NOT NULL) AND (single_sale_only_at IS NOT NULL))"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "deleted"]          , name: "companies_remote_account_update"          , where: "(remote_account_update = true)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "deleted"]          , name: "index_companies_retry_sales_rep_update"          , where: "(remote_sales_rep_update = true)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "id"          , "marketing_do_not_mail"]          , name: "index_companies_tenant_do_not_mail"          , where: "(marketing_do_not_mail = true)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "last_refreshed_at"          , "last_refreshed_version"]          , name: "companies_refresh_index"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "name"          , "walk_in"          , "deleted"          , "id"]          , name: "index_search_companies"          , where: "(NOT deleted)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "printsmith_id"          , "dirty"]          , name: "index_companies_on_tenant_id"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "printsmith_id"          , "id"]          , name: "index_companies_tenant_printsmith"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "printsmith_id"]          , name: "companies_tenant_id_printsmith_id_idx"          , unique: true          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "rolling_12_month_rank"          , "rolling_12_month_rank_ly"          , "name"          , "sales_rep_user_id"          , "source_salesrep_id"]          , name: "index_companies_rank_name_sales_rep"          , where: "(deleted = false)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "rolling_12_month_rank"]          , name: "companies_tenant_id_rolling_12_month_rank_idx"          , where: "((needs_lifetime_value_recalc = true) AND (deleted = false))"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "rolling_12_month_rank"]          , name: "index_companies_on_tenant_id_and_rolling_12_month_rank"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "rolling_12_month_rank"]          , name: "index_companies_on_tenant_id_and_rolling_12_month_rank_partial"          , where: "((NOT deleted) AND (NOT walk_in))"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "rolling_12_month_sales"          , "deleted"          , "id"]          , name: "index_companies_on_rolling_12_deleted"          , where: "(deleted = false)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "rolling_12_month_sales"          , "deleted"          , "source_shiptoaddress_id"          , "sales_rep_user_id"          , "source_salesrep_id"          , "id"]          , name: "index_company_sales"          , where: "(NOT deleted)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "rolling_12_month_sales"]          , name: "companies_tenant_id_rolling_12_month_sales_idx"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "source_billtoaddress_id"          , "source_shiptoaddress_id"          , "statement_address_id"          , "invoice_address_id"          , "id"]          , name: "index_companies_on_tenant_address_ids"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "source_salesrep_id"          , "created_at"]          , name: "corey_july_1"          , where: "(source_salesrep_id IS NOT NULL)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "source_salesrep_id"          , "id"          , "sales_rep_user_id"          , "location_user_id"]          , name: "index_companies_tenant_id_sales_rep"          , where: "(source_salesrep_id IS NOT NULL)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"          , "web"          , "deleted"]          , name: "companies_web"          , where: "(web = true)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"]          , name: "companies_sales_rep_tagger"          , where: "((source_salesrep_id IS NULL) AND (sales_rep_user_id IS NOT NULL))"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"]          , name: "companies_tenant_id_idx"          , where: "(dirty = true)"          , using: :btree)
  add_index(t, "companies"          , ["tenant_id"]          , name: "companies_tenant_id_idx1"          , where: "((needs_avg_conversion_ratio = true) AND (deleted = false))"          , using: :btree)

  t = add_table({ table: :contact_groups, force: :cascade, columns: [
    { column: :first_name          ,     limit: 255 },
    { column: :last_name          ,      limit: 255 },
    { column: :email          ,          limit: 255 },
    { column: :phone          ,          limit: 255 },
    { column: :estimate_count          ,                                      default: 0                                            , type: :integer },
    { column: :invoice_count          ,                                       default: 0                                            , type: :integer },
    { column: :estimate_total          ,             type: :decimal          , default: 0.0 },
    { column: :invoice_total          ,              type: :decimal          , default: 0.0 },
    { column: :first_estimate          ,             type: :datetime },
    { column: :first_invoice          ,              type: :datetime },
    { column: :last_estimate          ,              type: :datetime },
    { column: :last_invoice          ,               type: :datetime },
    { column: :created_at          ,                 type: :datetime },
    { column: :updated_at          ,                 type: :datetime },
    { column: :count          ,                                               default: 0                                            , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :sales_total              , type: :hstore }
    ] } )

  t = add_table({ table: :contact_groups_contacts, id: false, force: :cascade, columns: [
    { column: :contact_id          ,       null: false                                           , type: :integer },
    { column: :contact_group_id          , null: false                                           , type: :integer }
    ] } )

  add_index(t, "contact_groups_contacts"          , ["contact_id"]          , name: "index_contact_groups_contacts_on_contact_id"          , using: :btree)

  t = add_table({ table: :contact_list_counts, force: :cascade, columns: [
    { column: :tenant_id                                           , type: :integer },
    { column: :contact_list_id                                           , type: :integer },
    { column: :total_count                                           , type: :integer },
    { column: :generate_duration }
    ] } )

  t = add_table({ table: :contact_list_exclusions, force: :cascade, columns: [
    { column: :contact_list_id                                           , type: :integer },
    { column: :contact_id                                            , type: :integer },
    { column: :tenant_id                                           , type: :integer }
    ] } )

  add_index(t, "contact_list_exclusions"          , ["contact_id"]          , name: "index_contact_list_exclusions_on_contact_id"          , using: :btree)
  add_index(t, "contact_list_exclusions"          , ["contact_list_id"]          , name: "index_contact_list_exclusions_on_contact_list_id"          , using: :btree)

  t = add_table({ table: :contact_list_rules, force: :cascade, columns: [
    { column: :contact_list_id                                           , type: :integer },
    { column: :category                                                      , type: :text },
    { column: :operand                                                    , type: :text },
    { column: :value                                                    , type: :text },
    { column: :value2                                                      , type: :text },
    { column: :modifier                        ,          default: ""                                        , type: :text },
    { column: :modifier_operand                        ,  default: ""                                        , type: :text },
    { column: :modifier_value                        ,    default: ""                                        , type: :text },
    { column: :modifier_value2                       ,   default: ""                                        , type: :text },
    { column: :negate          ,            default: false },
    { column: :sales_rep_id                                            , type: :integer },
    { column: :taken_by_id                                           , type: :integer },
    { column: :modifier2 },
    { column: :modifier2_operand },
    { column: :modifier2_value },
    { column: :modifier2_value2 }
    ] } )

  add_index(t, "contact_list_rules"          , ["contact_list_id"]          , name: "index_contact_list_rules_on_contact_list_id"          , using: :btree)

  t = add_table({ table: :contact_lists, force: :cascade, columns: [
    { column: :name                                       , type: :text },
    { column: :created_at          ,       type: :datetime          ,                     null: false },
    { column: :updated_at          ,       type: :datetime          ,                     null: false },
    { column: :icon },
    { column: :colour },
    { column: :description },
    { column: :tenant_id                                            , type: :integer },
    { column: :global          ,                         default: true },
    { column: :hide_from_tenant          ,               default: false },
    { column: :enterprise_id                                            , type: :integer },
    { column: :account_type          ,                   default: "account" }
    ] } )

  add_index(t, "contact_lists"          , ["enterprise_id"]          , name: "index_contact_lists_on_enterprise_id"          , using: :btree)

  t = add_table({ table: :contact_lists_contacts, id: false, force: :cascade, columns: [
    { column: :contact_id                                            , type: :integer },
    { column: :contact_list_id                                           , type: :integer }
    ] } )

  add_index(t, "contact_lists_contacts"          , ["contact_id"]          , name: "index_contact_lists_contacts_on_contact_id"          , using: :btree)
  add_index(t, "contact_lists_contacts"          , ["contact_list_id"]          , name: "index_contact_lists_contacts_on_contact_list_id"          , using: :btree)

  t = add_table({ table: :contacts, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :first_name          ,                      limit: 255 },
    { column: :last_name          ,                       limit: 255 },
    { column: :email          ,                           limit: 255 },
    { column: :phone          ,                           limit: 255 },
    { column: :created_at          ,                                  type: :datetime },
    { column: :updated_at          ,                                  type: :datetime },
    { column: :dirty },
    { column: :gender          ,                          limit: 255 },
    { column: :temp          ,                                                                 default: false },
    { column: :source_address_id                                            , type: :integer },
    { column: :deleted          ,                                                              default: false },
    { column: :ready          ,                                                                default: false },
    { column: :associations_complete          ,                                                default: false },
    { column: :assocation_checks          ,                                                    default: 0                                           , type: :integer },
    { column: :source_account_id                                            , type: :integer },
    { column: :remote_update_required          ,                                               default: false },
    { column: :in_group          ,                                                             default: false },
    { column: :parent_contact_id                                            , type: :integer },
    { column: :mobile },
    { column: :fax },
    { column: :home_phone },
    { column: :twitter },
    { column: :other },
    { column: :facebook },
    { column: :website },
    { column: :buy_frequency                       ,                                                        default: 0.0                              , type: :float },
    { column: :days_outside_buy_freq          ,                                                default: 0                                           , type: :integer },
    { column: :marketing_do_not_mail          ,                                                default: false },
    { column: :marketing_unsubscribe          ,                                                default: false },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :source_salesrep_id                                           , type: :integer },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :location_user_id                                           , type: :integer },
    { column: :rolling_12_month_sales },
    { column: :rolling_12_month_sales_ly },
    { column: :latest_order_date },
    { column: :rolling_12_month_cogs },
    { column: :marketing_unsubscribe_reason },
    { column: :on_suppression_list          ,                                                  default: false },
    { column: :growth_percentage          ,                                                    default: 0.0 },
    { column: :rolling_1_month_sales          ,                                                default: 0.0 },
    { column: :order_count          ,                                                          default: 0                                           , type: :integer },
    { column: :address_id                                           , type: :integer },
    { column: :average_invoice          ,                                                      default: 0.0 },
    { column: :has_clearbit_data          ,                                                    default: false },
    { column: :clearbit_data                       ,                                                        default: {}                               , type: :jsonb },
    { column: :custom_data                       ,                                                          default: {}                               , type: :jsonb },
    { column: :last_clearbit_data_fetch_date },
    { column: :last_viewed },
    { column: :guessed_gender },
    { column: :guessed_gender_confidence          ,                                            default: 0.0 },
    { column: :bounced_email_addresses          ,                                              default: []          ,                 array: true },
    { column: :last_contact },
    { column: :last_email_sent },
    { column: :last_email_received },
    { column: :last_phone_call },
    { column: :rolling_12_month_sales_ly_ly          ,                type: :decimal },
    { column: :remote_sales_rep_update },
    { column: :last_pickup_date },
    { column: :lead_source },
    { column: :lead_source_2 },
    { column: :prefix },
    { column: :suffix },
    { column: :needs_email_remap          ,                                                    default: false },
    { column: :job_title },
    { column: :est_spend                                            , type: :integer },
    { column: :conv_prob                                            , type: :integer },
    { column: :next_activity_date                   , type: :date },
    { column: :next_activity_type },
    { column: :use_contact_address },
    { column: :prospect_status_id                                           , type: :integer },
    { column: :needs_email_validation          ,                                               default: true },
    { column: :source_inquiry_id                                            , type: :integer },
    { column: :email_validation_attempts          ,                                            default: 0                                           , type: :integer },
    { column: :next_activity                       ,                                                        default: {}          ,    null: false                               , type: :jsonb },
    { column: :oldest_rolling_12_invoice },
    { column: :oldest_rolling_12_ly_invoice },
    { column: :oldest_rolling_12_ly_ly_invoice },
    { column: :oldest_rolling_1_invoice },
    { column: :lead_type_id                                           , type: :integer },
    { column: :unsubscribed          ,                                                         default: false },
    { column: :last_meeting },
    { column: :old_prospect_status_id                                           , type: :integer },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :lead_created_at },
    { column: :external_id },
    { column: :single_sale_only_at },
    { column: :first_sale_at },
    { column: :sales_rep_platform_id },
    { column: :tmp_data                        ,                                                             default: {}                               , type: :jsonb }
    ] } )

  add_index(t, "contacts"          , ["associations_complete"]          , name: "contacts_associations_complete_idx"          , where: "(associations_complete = false)"          , using: :btree)
  add_index(t, "contacts"          , ["company_id"          , "id"]          , name: "index_contacts_on_company_id"          , using: :btree)
  add_index(t, "contacts"          , ["has_clearbit_data"          , "rolling_12_month_sales"          , "rolling_12_month_sales_ly"          , "tenant_id"          , "temp"]          , name: "index_contacts_clearbit"          , where: "((has_clearbit_data = false) AND (temp = false))"          , using: :btree)
  add_index(t, "contacts"          , ["lead_type_id"]          , name: "index_contacts_on_lead_type_id"          , using: :btree)
  add_index(t, "contacts"          , ["location_user_id"]          , name: "index_contacts_on_location_user_id"          , using: :btree)
  add_index(t, "contacts"          , ["parent_contact_id"]          , name: "index_contacts_on_parent_contact_id"          , using: :btree)
  add_index(t, "contacts"          , ["prospect_status_id"          , "tenant_id"          , "deleted"          , "company_id"]          , name: "index_contacts_prospect_satatus_id"          , where: "((prospect_status_id IS NOT NULL) AND (deleted <> false))"          , using: :btree)
  add_index(t, "contacts"          , ["remote_sales_rep_update"]          , name: "index_contacts_on_remote_sales_rep_update"          , using: :btree)
  add_index(t, "contacts"          , ["rolling_12_month_sales"]          , name: "index_contacts_with_rolling_12_month_sales"          , where: "(rolling_12_month_sales > (0)::numeric)"          , using: :btree)
  add_index(t, "contacts"          , ["sales_rep_user_id"]          , name: "index_contacts_on_sales_rep_user_id"          , using: :btree)
  add_index(t, "contacts"          , ["source_salesrep_id"]          , name: "index_contacts_on_source_salesrep_id"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "company_id"          , "first_name"          , "last_name"          , "rolling_12_month_sales"]          , name: "index_search_contacts"          , order: {"rolling_12_month_sales"=>:desc}          , where: "(NOT temp)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "company_id"          , "latest_order_date"          , "rolling_12_month_sales"          , "sales_rep_user_id"          , "deleted"          , "temp"          , "id"]          , name: "index_contacts_in_latest_order_date_rolling_12_month_sales"          , order: {"rolling_12_month_sales"=>:desc}          , where: "((rolling_12_month_sales > (0)::numeric) AND (deleted <> true) AND (temp = false))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "company_id"          , "rolling_12_month_sales"          , "first_name"          , "temp"          , "deleted"          , "marketing_do_not_mail"          , "marketing_unsubscribe"          , "on_suppression_list"          , "id"]          , name: "index_contacts_company_sales_name"          , order: {"rolling_12_month_sales"=>:desc}          , where: "((NOT temp) AND (NOT marketing_do_not_mail) AND (NOT marketing_unsubscribe) AND (NOT on_suppression_list))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "company_id"          , "rolling_12_month_sales"          , "first_name"          , "temp"          , "deleted"          , "unsubscribed"          , "id"]          , name: "index_contacts_company_sales_name_not_unsubbed"          , order: {"rolling_12_month_sales"=>:desc}          , where: "((temp = false) AND (deleted = false) AND (unsubscribed = false))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "company_id"          , "rolling_12_month_sales"          , "rolling_12_month_sales_ly"          , "id"          , "deleted"          , "temp"]          , name: "index_contacts_tenant_id_company_sales"          , where: "(deleted <> true)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "deleted"          , "id"          , "email"          , "company_id"          , "latest_order_date"          , "source_created_at"          , "marketing_do_not_mail"          , "on_suppression_list"          , "marketing_unsubscribe"]          , name: "index_contacts_tenant_id_deleted_stats"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "deleted"          , "id"          , "email"          , "company_id"          , "latest_order_date"          , "source_created_at"          , "unsubscribed"]          , name: "index_contacts_tenant_deleted_stats"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "deleted"          , "id"]          , name: "corey_july_5"          , where: "(company_id IS NULL)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "deleted"]          , name: "contacts_prospect_status_id"          , where: "(prospect_status_id IS NOT NULL)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "dirty"          , "printsmith_id"          , "company_id"]          , name: "index_company_dirty"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "email"          , "id"]          , name: "index_contacts_tenant_lower_email_id"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "email"          , "on_suppression_list"          , "id"]          , name: "index_contacts_tenant_trimmed_email"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "id"          , "rolling_12_month_sales"          , "first_name"          , "company_id"          , "deleted"          , "email"          , "temp"          , "marketing_do_not_mail"          , "marketing_unsubscribe"          , "on_suppression_list"]          , name: "contacts_tenant_id_where_emailable"          , order: {"rolling_12_month_sales"=>:desc}          , where: "((NOT temp) AND (NOT marketing_do_not_mail) AND (NOT marketing_unsubscribe) AND (NOT on_suppression_list) AND ((email)::text ~~ '%@%'::text))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "id"          , "rolling_12_month_sales"          , "first_name"          , "company_id"          , "deleted"          , "email"          , "temp"          , "unsubscribed"]          , name: "index_contacts_tenant_not_unsubbed_with_email"          , order: {"rolling_12_month_sales"=>:desc}          , where: "((temp = false) AND (deleted = false) AND (unsubscribed = false) AND ((email)::text ~~ '%@%'::text))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "latest_order_date"]          , name: "contacts_tenant_id_latest_order_date_idx"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "marketing_do_not_mail"          , "marketing_unsubscribe"          , "on_suppression_list"          , "id"]          , name: "index_contacts_on_tenant_marketing"          , where: "((marketing_do_not_mail = false) AND ((marketing_unsubscribe = true) OR (on_suppression_list = true)))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "needs_email_validation"          , "company_id"          , "tenant_id"          , "on_suppression_list"          , "marketing_do_not_mail"          , "deleted"          , "temp"]          , name: "index_contacts_email_validations"          , where: "((on_suppression_list = false) AND (marketing_do_not_mail = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "needs_email_validation"          , "company_id"          , "tenant_id"          , "unsubscribed"          , "deleted"          , "temp"]          , name: "index_contacts_email_validations_not_unsubbed"          , where: "((deleted = false) AND (unsubscribed = false))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "oldest_rolling_1_invoice"          , "oldest_rolling_12_invoice"          , "oldest_rolling_12_ly_invoice"          , "oldest_rolling_12_ly_ly_invoice"          , "id"]          , name: "index_contacts_rolling_invoices"          , where: "((oldest_rolling_1_invoice IS NOT NULL) OR (oldest_rolling_12_invoice IS NOT NULL) OR (oldest_rolling_12_ly_invoice IS NOT NULL) OR (oldest_rolling_12_ly_ly_invoice IS NOT NULL))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "oldest_rolling_1_invoice"          , "oldest_rolling_12_invoice"          , "oldest_rolling_12_ly_invoice"          , "oldest_rolling_12_ly_ly_invoice"          , "id"]          , name: "index_contacts_tenant_oldest_rolling"          , where: "((oldest_rolling_1_invoice IS NOT NULL) OR (oldest_rolling_12_invoice IS NOT NULL) OR (oldest_rolling_12_ly_invoice IS NOT NULL) OR (oldest_rolling_12_ly_ly_invoice IS NOT NULL))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "printsmith_id"          , "id"]          , name: "index_contacts_tenant_printsmith"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "printsmith_id"]          , name: "contacts_tenant_id_printsmith_id_idx"          , unique: true          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "rolling_12_month_sales"]          , name: "contacts_tenant_id_rolling_12_month_sales_idx1"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "rolling_12_month_sales"]          , name: "tmp_fix_10"          , order: {"rolling_12_month_sales"=>:desc}          , where: "(guessed_gender IS NULL)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "source_salesrep_id"          , "id"          , "sales_rep_user_id"          , "location_user_id"]          , name: "index_contacts_tenant_id_sales_rep"          , where: "(source_salesrep_id IS NOT NULL)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "unsubscribed"          , "deleted"          , "temp"          , "needs_email_validation"          , "company_id"]          , name: "index_contacts_tenant_unsubscribed"          , where: "((unsubscribed = false) AND (deleted = false) AND (temp = false))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"          , "unsubscribed"          , "id"]          , name: "index_contacts_tenant_unsubbed"          , where: "(unsubscribed = true)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "contact_sales_rep_tagger"          , where: "((source_salesrep_id IS NULL) AND (sales_rep_user_id IS NOT NULL))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "contacts_tenant_id_idx"          , where: "(remote_update_required = true)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "contacts_tenant_id_idx1"          , where: "((rolling_12_month_sales > (1)::numeric) AND (temp = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "contacts_tenant_id_lower_idx"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "contacts_tenant_id_where_contactable"          ,e: "((NOT temp) AND (NOT deleted) AND (NOT marketing_do_not_mail) AND (NOT marketing_unsubscribe) AND (NOT on_suppression_list))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "corey_july_6"          , where: "((source_address_id IS NOT NULL) AND (address_id IS NULL))"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "index_contacts_retry_sales_rep_update"          , where: "(remote_sales_rep_update = true)"          , using: :btree)
  add_index(t, "contacts"          , ["tenant_id"]          , name: "index_contacts_tenant_not_unsubbed"          , where: "((temp = false) AND (deleted = false) AND (unsubscribed = false))"          , using: :btree)

  t = add_table({ table: :countries, force: :cascade, columns: [
    { column: :name }
    ] } )

  t = add_table({ table: :countries_enterprises, id: false, force: :cascade, columns: [
    { column: :country_id          ,    null: false                                            , type: :integer },
    { column: :enterprise_id          , null: false                                            , type: :integer }
    ] } )

  add_index(t, "countries_enterprises"          , ["country_id"          , "enterprise_id"]          , name: "index_countries_enterprises"          , using: :btree)

  t = add_table({ table: :country_states, force: :cascade, columns: [
    { column: :country_id                                            , type: :integer },
    { column: :name }
    ] } )

  add_index(t, "country_states"          , ["country_id"]          , name: "index_country_states_on_country_id"          , using: :btree)

  t = add_table({ table: :country_states_holidays, id: false, force: :cascade, columns: [
    { column: :holiday_id          ,       null: false                                           , type: :integer },
    { column: :country_state_id          , null: false                                           , type: :integer }
    ] } )

  add_index(t, "country_states_holidays"          , ["holiday_id"          , "country_state_id"]          , name: "index_holidays_country_states"          , using: :btree)

  t = add_table({ table: :deployments, force: :cascade, columns: [
    { column: :name                                       , type: :text },
    { column: :os                                       , type: :text },
    { column: :checksum                                       , type: :text },
    { column: :version                                        , type: :text },
    { column: :built_on                                       , type: :text },
    { column: :address                                        , type: :text },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          , type: :datetime          , null: false },
    { column: :updated_at          , type: :datetime          , null: false }
    ] } )

  add_index(t, "deployments"          , ["tenant_id"]          , name: "index_deployments_on_tenant_id"          , using: :btree)

  t = add_table({ table: :email_aliases, force: :cascade, columns: [
    { column: :user_id                                           , type: :integer },
    { column: :email }
    ] } )

  t = add_table({ table: :email_credentials, force: :cascade, columns: [
    { column: :user_id          ,                    null: false                                            , type: :integer },
    { column: :tenant_id          ,                  null: false                                            , type: :integer },
    { column: :enterprise_id          ,              null: false                                            , type: :integer },
    { column: :platform          ,                   null: false },
    { column: :credentials                       ,   default: {}                                , type: :jsonb },
    { column: :created_at          ,                 null: false },
    { column: :updated_at          ,                 null: false }
    ] } )

  t = add_table({ table: :email_deliveries, force: :cascade, columns: [
    { column: :message          , default: {}          , null: false                                , type: :jsonb }
    ] } )

  t = add_table({ table: :email_message_activities, force: :cascade, columns: [
    { column: :email_inbox_id                                           , type: :integer },
    { column: :last_email_message_id                                            , type: :integer },
    { column: :last_scan },
    { column: :forward_scan_id                                            , type: :integer },
    { column: :reverse_scan_id                                            , type: :integer }
    ] } )

  t = add_table({ table: :email_soft_bounces, force: :cascade, columns: [
    { column: :tenant_id                                           , type: :integer },
    { column: :email_address },
    { column: :soft_bounce_count          , default: 0                                           , type: :integer }
    ] } )

  add_index(t, "email_soft_bounces"          , ["email_address"]          , name: "index_email_soft_bounces_on_email_address"          , using: :btree)
  add_index(t, "email_soft_bounces"          , ["tenant_id"          , "soft_bounce_count"          , "email_address"]          , name: "index_email_soft_bounces_count"          , where: "(soft_bounce_count >= 3)"          , using: :btree)

  t = add_table({ table: :email_statuses, force: :cascade, columns: [
    { column: :email_address },
    { column: :status                                           , type: :integer },
    { column: :info                                       , type: :text },
    { column: :created_at          ,    null: false },
    { column: :updated_at          ,    null: false }
    ] } )

  t = add_table({ table: :email_tags, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :label_id },
    { column: :name },
    { column: :label_type },
    { column: :created_at          , type: :datetime },
    { column: :updated_at          , type: :datetime }
    ] } )

  add_index(t, "email_tags"          , ["label_id"]          , name: "index_email_tags_on_label_id"          , using: :btree)
  add_index(t, "email_tags"          , ["label_type"]          , name: "index_email_tags_on_label_type"          , using: :btree)
  add_index(t, "email_tags"          , ["name"]          , name: "index_email_tags_on_name"          , using: :btree)
  add_index(t, "email_tags"          , ["tenant_id"]          , name: "index_email_tags_on_tenant_id"          , using: :btree)
  add_index(t, "email_tags"          , ["user_id"]          , name: "index_email_tags_on_user_id"          , using: :btree)

  t = add_table({ table: :email_tags_emails, id: false, force: :cascade, columns: [
    { column: :email_id          ,     null: false                                           , type: :integer },
    { column: :email_tag_id          , null: false                                           , type: :integer }
    ] } )

  add_index(t, "email_tags_emails"          , ["email_id"          , "email_tag_id"]          , name: "index_email_tags_emails_on_email_id_and_email_tag_id"          , unique: true          , using: :btree)

  t = add_table({ table: :email_template_categories, force: :cascade, columns: [
    { column: :email_template_id                                           , type: :integer },
    { column: :category                                            , type: :integer }
    ] } )

  t = add_table({ table: :email_template_fields, force: :cascade, columns: [
    { column: :email_template_id                                           , type: :integer },
    { column: :name                                                      , type: :text },
    { column: :required          ,          default: false }
    ] } )

  t = add_table({ table: :email_template_values, force: :cascade, columns: [
    { column: :email_template_field_id                                           , type: :integer },
    { column: :element_id                                            , type: :integer },
    { column: :element_type },
    { column: :value },
    { column: :tenant_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :email_templates, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :user_id                                            , type: :integer },
    { column: :global          ,                                                  default: false },
    { column: :name          ,                          limit: 255 },
    { column: :subject          ,                       limit: 255 },
    { column: :body                                       , type: :text },
    { column: :created_at          ,                                type: :datetime },
    { column: :updated_at          ,                                type: :datetime },
    { column: :key                                        , type: :text },
    { column: :shell          ,                                                   default: false },
    { column: :wrapper_id                                           , type: :integer },
    { column: :hidden          ,                                                  default: false },
    { column: :enterprise_id                                            , type: :integer },
    { column: :auto_cc          ,                                                 default: false },
    { column: :auto_cc_sales_rep          ,                                       default: false },
    { column: :archived          ,                                                default: false },
    { column: :production_location_id                                           , type: :integer },
    { column: :default_attach          ,                                          default: false },
    { column: :copied_email_template_id          ,                                default: 0                                            , type: :integer },
    { column: :copied_similarity          ,                                       default: 0                                            , type: :integer },
    { column: :copied_root_email_template_id          ,                           default: 0                                            , type: :integer },
    { column: :copied_depth          ,                                            default: 0                                            , type: :integer },
    { column: :root_similarity          ,                                         default: 0                                            , type: :integer },
    { column: :use_roboto }
    ] } )

  add_index(t, "email_templates"          , ["tenant_id"]          , name: "index_email_templates_on_tenant_id"          , using: :btree)
  add_index(t, "email_templates"          , ["user_id"]          , name: "index_email_templates_on_user_id"          , using: :btree)

  t = add_table({ table: :email_validations, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :enterprise_id                                            , type: :integer },
    { column: :contact_id                                           , type: :integer },
    { column: :address },
    { column: :code },
    { column: :parent_id          ,      default: 0                                           , type: :integer },
    { column: :fixed          ,          default: false },
    { column: :rescan_needed          ,  default: false },
    { column: :pending_rescan          , default: false },
    { column: :created_at          ,                     null: false },
    { column: :updated_at          ,                     null: false }
    ] } )

  add_index(t, "email_validations"          , ["contact_id"          , "created_at"          , "tenant_id"          , "enterprise_id"          , "code"]          , name: "index_email_validations_contact_created"          , order: {"created_at"=>:desc}          , using: :btree)
  add_index(t, "email_validations"          , ["tenant_id"          , "enterprise_id"          , "contact_id"          , "created_at"          , "code"]          , name: "index_email_validations_tenant_id"          , order: {"created_at"=>:desc}          , using: :btree)

  t = add_table({ table: :emails, force: :cascade, columns: [
    { column: :to                                       , type: :text },
    { column: :from                                       , type: :text },
    { column: :read },
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :from_user_id                                           , type: :integer },
    { column: :to_user_id                                           , type: :integer },
    { column: :direction          ,                       limit: 255 },
    { column: :context_id                                           , type: :integer },
    { column: :context_type          ,                    limit: 255 },
    { column: :subject                                        , type: :text },
    { column: :body                                       , type: :text },
    { column: :created_at          ,                                  type: :datetime },
    { column: :updated_at          ,                                  type: :datetime },
    { column: :email_id },
    { column: :thread_id },
    { column: :processed          ,                                                 default: false },
    { column: :deleted          ,                                                   default: false },
    { column: :labels                                       , type: :text },
    { column: :sending_as_user_id                                           , type: :integer },
    { column: :cc },
    { column: :attachment_uuid },
    { column: :test          ,                                                      default: false },
    { column: :bcc },
    { column: :failed_reason },
    { column: :message_id },
    { column: :error_backoff },
    { column: :bulk },
    { column: :prospect_status_item_contact_id                                            , type: :integer }
    ] } )

  add_index(t, "emails"          , ["context_id"          , "context_type"]          , name: "index_emails_on_context_id_and_context_type"          , using: :btree)
  add_index(t, "emails"          , ["created_at"]          , name: "emails_created_at_idx"          , where: "(processed = false)"          , using: :btree)
  add_index(t, "emails"          , ["from_user_id"]          , name: "index_emails_on_from_user_id"          , using: :btree)
  add_index(t, "emails"          , ["message_id"]          , name: "emails_message_id_idx"          , using: :btree)
  add_index(t, "emails"          , ["tenant_id"          , "email_id"]          , name: "emails_tenant_id_email_id_idx"          , using: :btree)
  add_index(t, "emails"          , ["thread_id"          , "id"]          , name: "index_emails_on_thread_id_and_id"          , using: :btree)
  add_index(t, "emails"          , ["to_user_id"]          , name: "index_emails_on_to_user_id"          , using: :btree)
  add_index(t, "emails"          , ["user_id"]          , name: "index_emails_on_user_id"          , using: :btree)

  t = add_table({ table: :emails_trackers, id: false, force: :cascade, columns: [
    { column: :email_id                                            , type: :integer },
    { column: :tracker_id                                            , type: :integer }
    ] } )

  add_index(t, "emails_trackers"          , ["tracker_id"]          , name: "index_email_trackers_tacker"          , using: :btree)

  t = add_table({ table: :enterprise_salestargets, force: :cascade, columns: [
    { column: :prospect_status_id                                            , type: :integer },
    { column: :enterprise_id                                           , type: :integer },
    { column: :amount                                            , type: :integer },
    { column: :items                                           , type: :integer },
    { column: :lead_type_id                                            , type: :integer }
    ] } )

  add_index(t, "enterprise_salestargets"          , ["lead_type_id"]          , name: "index_enterprise_salestargets_on_lead_type_id"          , using: :btree)

  t = add_table({ table: :enterprise_togglefields, force: :cascade, columns: [
    { column: :enterprise_id                                           , type: :integer },
    { column: :field          ,         limit: 40 },
    { column: :read_only          ,                default: false }
    ] } )

  t = add_table({ table: :enterprises, force: :cascade, columns: [
    { column: :name },
    { column: :created_at          ,                                                  null: false },
    { column: :updated_at          ,                                                  null: false },
    { column: :show_eula          ,                            default: false },
    { column: :eula_body                                        , type: :text },
    { column: :setup_user },
    { column: :setup_password },
    { column: :campaign_test_address },
    { column: :unsubscribe_template                                       , type: :text },
    { column: :banner_id                                            , type: :integer },
    { column: :default_email_template_id          ,            default: 0                                           , type: :integer },
    { column: :campaign_approval_address },
    { column: :intercom_app_id },
    { column: :freshchat_token },
    { column: :portal_estimate_comment_template_id                                            , type: :integer },
    { column: :portal_estimate_approved_template_id                                           , type: :integer },
    { column: :portal_estimate_canceled_template_id                                           , type: :integer },
    { column: :portal_estimate_copy                                       , type: :text },
    { column: :default_company_emailt_id                                            , type: :integer },
    { column: :default_contact_emailt_id                                            , type: :integer },
    { column: :default_estimate_emailt_id                                           , type: :integer },
    { column: :default_order_emailt_id                                            , type: :integer },
    { column: :default_sale_emailt_id                                           , type: :integer },
    { column: :currency_locale },
    { column: :statement_template_name                                        , type: :text },
    { column: :statement_template                                       , type: :text },
    { column: :pdf_gen_link                                       , type: :text },
    { column: :default_salestarget_amount                                           , type: :integer },
    { column: :default_salestarget_number                                           , type: :integer },
    { column: :deleted_at },
    { column: :api_token },
    { column: :default_inquiry_emailt_id                                            , type: :integer },
    { column: :connection_type          ,                      default: "printsmith" },
    { column: :locale          ,                               default: "en"          ,         null: false },
    { column: :portal_proof_comment_template_id                                           , type: :integer },
    { column: :portal_proof_approved_template_id                                            , type: :integer },
    { column: :portal_proof_copy                                        , type: :text },
    { column: :brand_colors                        ,                         default: {}                               , type: :jsonb },
    { column: :default_roboto_font },
    { column: :platform_type },
    { column: :agi_brand },
    { column: :show_language          ,                        default: false },
    { column: :default_shipment_emailt_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :estimate_elements, force: :cascade, columns: [
    { column: :estimate_id                                            , type: :integer },
    { column: :element_id                                           , type: :integer },
    { column: :element_type          , limit: 255 },
    { column: :created_at          ,               type: :datetime },
    { column: :updated_at          ,               type: :datetime },
    { column: :tenant_id                                            , type: :integer }
    ] } )

  add_index(t, "estimate_elements"          , ["element_id"          , "element_type"]          , name: "index_estimate_elements_on_element_id_and_element_type"          , using: :btree)
  add_index(t, "estimate_elements"          , ["estimate_id"]          , name: "index_estimate_elements_on_estimate_id"          , using: :btree)
  add_index(t, "estimate_elements"          , ["tenant_id"]          , name: "index_estimate_elements_on_tenant_id"          , using: :btree)

  t = add_table({ table: :estimates, force: :cascade, columns: [
    { column: :name                                       , type: :text },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,                           type: :datetime },
    { column: :updated_at          ,                           type: :datetime },
    { column: :grand_total          ,                          type: :decimal },
    { column: :printsmith_id          ,            limit: 8                                           , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :status          ,                   limit: 255 },
    { column: :deleted_at          ,                           type: :datetime },
    { column: :on_pending_list },
    { column: :wanted_by          ,                            type: :datetime },
    { column: :off_pending_date          ,                     type: :datetime },
    { column: :reorder_date          ,                         type: :datetime },
    { column: :salesrep_id                                            , type: :integer },
    { column: :notes_id          ,                 limit: 8                                           , type: :integer },
    { column: :special_instructions_id          ,  limit: 8                                           , type: :integer },
    { column: :documentlocation_id          ,      limit: 8                                           , type: :integer },
    { column: :total_cost          ,                           type: :decimal },
    { column: :source_taken_by          ,          limit: 255 },
    { column: :created_by          ,               limit: 255 },
    { column: :customer_po          ,              limit: 255 },
    { column: :estimate_notes                                       , type: :text },
    { column: :invoice_number          ,           limit: 255 },
    { column: :price_sub_total          ,                      type: :decimal },
    { column: :price_total          ,                          type: :decimal },
    { column: :costed },
    { column: :firm_wanted_by_date },
    { column: :dirty },
    { column: :contact_id                                           , type: :integer },
    { column: :source_estimate_id          ,       limit: 8                                           , type: :integer },
    { column: :source_invoice_id          ,        limit: 8                                           , type: :integer },
    { column: :voided },
    { column: :converted_invoice_id          ,     limit: 8                                           , type: :integer },
    { column: :converted_invoice_number          , limit: 8                                           , type: :integer },
    { column: :source_estimate_number          ,   limit: 8                                           , type: :integer },
    { column: :source_invoice_number          ,    limit: 8                                           , type: :integer },
    { column: :actioned          ,                                                      default: false },
    { column: :tax          ,                                  type: :decimal },
    { column: :grand_total_inc_tax          ,                  type: :decimal },
    { column: :overdue_actioned          ,                                              default: false },
    { column: :needs_pdf          ,                                                     default: true },
    { column: :key },
    { column: :ordered_date          ,                         type: :datetime },
    { column: :deleted          ,                                                       default: false },
    { column: :ready          ,                                                         default: false },
    { column: :associations_complete          ,                                         default: false },
    { column: :assocation_checks          ,                                             default: 0                                            , type: :integer },
    { column: :source_account_id          ,        limit: 8                                           , type: :integer },
    { column: :source_contact_id          ,        limit: 8                                           , type: :integer },
    { column: :production_location_id                                           , type: :integer },
    { column: :public_token },
    { column: :instructions                                       , type: :text },
    { column: :workflow_status },
    { column: :follow_up_date          ,                       type: :datetime },
    { column: :follow_up_count                                            , type: :integer },
    { column: :remote_update_required          ,                                        default: false },
    { column: :reason },
    { column: :pdf_id                                           , type: :integer },
    { column: :source_created_at          ,                    type: :datetime },
    { column: :source_updated_at          ,                    type: :datetime },
    { column: :taken_by_id                                            , type: :integer },
    { column: :contact_group_id                                           , type: :integer },
    { column: :rounded_amount          ,                       type: :decimal },
    { column: :taken_by_user_id                                           , type: :integer },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :location_user_id                                           , type: :integer },
    { column: :report_name },
    { column: :pdf_error_count          ,                                               default: 0                                            , type: :integer },
    { column: :retry_location_update          ,                                         default: false },
    { column: :archived_at },
    { column: :archived_user_id                                           , type: :integer },
    { column: :retry_archive          ,                                                 default: false },
    { column: :parent_contact_id                                            , type: :integer },
    { column: :reason_value },
    { column: :dirty_skip_pdf          ,                                                default: false },
    { column: :job_descriptions                                       , type: :text },
    { column: :last_refreshed_at },
    { column: :proof_by },
    { column: :web },
    { column: :holdstate_id                                           , type: :integer },
    { column: :portal_key },
    { column: :approval_status },
    { column: :remote_sales_rep_update },
    { column: :remote_proof_by_update },
    { column: :retry_convert_update },
    { column: :inquiry_id                                           , type: :integer },
    { column: :inquiry_auto },
    { column: :converted          ,                                                     default: false },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :sales_rep_platform_id },
    { column: :tmp_data                        ,                                                      default: {}                                , type: :jsonb }
    ] } )

  add_index(t, "estimates"          , ["company_id"          , "id"]          , name: "index_estimates_on_company_id"          , using: :btree)
  add_index(t, "estimates"          , ["contact_id"]          , name: "index_estimates_on_contact_id"          , using: :btree)
  add_index(t, "estimates"          , ["dirty_skip_pdf"]          , name: "index_estimates_on_dirty_skip_pdf"          , using: :btree)
  add_index(t, "estimates"          , ["inquiry_id"]          , name: "index_estimates_on_inquiry_id"          , using: :btree)
  add_index(t, "estimates"          , ["location_user_id"]          , name: "index_estimates_on_location_user_id"          , using: :btree)
  add_index(t, "estimates"          , ["ordered_date"          , "tenant_id"          , "grand_total"          , "voided"          , "deleted"]          , name: "index_estimates_ordered_date_tenant_id"          , where: "((NOT voided) AND (NOT deleted))"          , using: :btree)
  add_index(t, "estimates"          , ["portal_key"]          , name: "index_estimates_portal_key"          , using: :btree)
  add_index(t, "estimates"          , ["printsmith_id"]          , name: "index_estimates_on_printsmith_id"          , using: :btree)
  add_index(t, "estimates"          , ["remote_proof_by_update"]          , name: "index_estimates_on_remote_proof_by_update"          , using: :btree)
  add_index(t, "estimates"          , ["remote_sales_rep_update"]          , name: "index_estimates_on_remote_sales_rep_update"          , using: :btree)
  add_index(t, "estimates"          , ["sales_rep_user_id"]          , name: "index_estimates_on_sales_rep_user_id"          , using: :btree)
  add_index(t, "estimates"          , ["taken_by_user_id"]          , name: "index_estimates_on_taken_by_user_id"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "company_id"          , "contact_id"          , "id"]          , name: "index_estimates_id_company_contact"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "company_id"          , "source_account_id"          , "created_at"          , "id"]          , name: "index_estimates_tenant_company_source_account"          , order: {"created_at"=>:desc}          , where: "(source_account_id IS NOT NULL)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "contact_id"          , "ordered_date"          , "grand_total"          , "voided"          , "deleted"          , "id"]          , name: "index_estimates_tenant_stats"          , where: "((voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "contact_id"          , "source_contact_id"          , "created_at"          , "id"]          , name: "index_estimates_tenant_company_source_contact"          , order: {"created_at"=>:desc}          , where: "(source_contact_id IS NOT NULL)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "created_at"          , "associations_complete"          , "dirty"]          , name: "estimates_index"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "created_at"]          , name: "estimates_tenant_id_created_at_idx"          , order: {"created_at"=>:desc}          , where: "(associations_complete = false)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "invoice_number"          , "deleted"          , "voided"]          , name: "estimates_invoice_number"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "invoice_number"          , "voided"          , "deleted"          , "name"          , "id"]          , name: "index_search_estimates"          , where: "((NOT deleted) AND (NOT voided))"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "job_descriptions"]          , name: "estimates_tenant_id_gin_job_desc"          , using: :gin)
  add_index(t, "estimates"          , ["tenant_id"          , "name"]          , name: "estimates_tenant_id_gin_name"          , using: :gin)
  add_index(t, "estimates"          , ["tenant_id"          , "off_pending_date"]          , name: "estimates_tenant_id_off_pending_date_idx"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "production_location_id"          , "on_pending_list"          , "id"]          , name: "index_estimates_tenant_production_location"          , where: "(on_pending_list IS TRUE)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "salesrep_id"          , "id"          , "sales_rep_user_id"          , "location_user_id"]          , name: "index_estimates_tenant_id_sales_rep"          , where: "(salesrep_id IS NOT NULL)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "source_taken_by"          , "id"          , "taken_by_user_id"]          , name: "index_estimates_tenant_id_taken_by"          , where: "(source_taken_by IS NOT NULL)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "source_taken_by"          , "source_created_at"]          , name: "index_estimates_on_tenant_stakenby_screatedat"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "source_updated_at"]          , name: "estimates_tenant_id_source_updated_at_asc"          , where: "(source_updated_at >= '2014-01-01 00:00:00'::timestamp without time zone)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "status"          , "deleted"          , "voided"]          , name: "index_estimates_status"          , where: "((NOT deleted) AND (NOT voided))"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "taken_by_user_id"          , "ordered_date"          , "status"          , "deleted"          , "voided"          , "id"]          , name: "index_estimates_tenant_taken_by_ordered_date_status"          , where: "((voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "updated_at"          , "voided"          , "deleted"]          , name: "estimates_retry_convert"          , where: "(retry_convert_update = true)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"          , "voided"          , "deleted"]          , name: "index_estimates_retry_sales_rep_update"          , where: "(remote_sales_rep_update = true)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"]          , name: "corey_july_3"          , where: "(company_id IS NOT NULL)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"]          , name: "estimates_dirty_skip_pdf_index"          , where: "(dirty_skip_pdf = true)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"]          , name: "estimates_retry_archive_index"          , where: "((voided = false) AND (deleted = false) AND (retry_archive = true))"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"]          , name: "estimates_tenant_id_idx"          , where: "(dirty = true)"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"]          , name: "estimates_tenant_id_idx1"          , where: "((remote_update_required = true) AND (voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"]          , name: "estimates_tenant_id_idx2"          , where: "((voided = false) AND (deleted = false) AND (retry_location_update = true))"          , using: :btree)
  add_index(t, "estimates"          , ["tenant_id"]          , name: "index_estimates_on_pending_list"          , where: "(on_pending_list = true)"          , using: :btree)

  t = add_table({ table: :etl_settings, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :klass          ,               limit: 255 },
    { column: :last_created_at          ,     limit: 255 },
    { column: :last_updated_at          ,     limit: 255 },
    { column: :created_at          ,                      type: :datetime },
    { column: :updated_at          ,                      type: :datetime },
    { column: :last_created_id          ,                               default: 0                                            , type: :integer },
    { column: :last_updated_id          ,                               default: 0                                            , type: :integer },
    { column: :last_created_count                                           , type: :integer },
    { column: :last_updated_count                                           , type: :integer },
    { column: :last_created_offset          ,                           default: 0                                            , type: :integer },
    { column: :last_updated_offset          ,                           default: 0                                            , type: :integer }
    ] } )

  add_index(t, "etl_settings"          , ["tenant_id"          , "klass"]          , name: "tenant_id_klass"          , unique: true          , using: :btree)

  t = add_table({ table: :event_stats, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :event_type },
    { column: :data                                              , type: :jsonb },
    { column: :duration },
    { column: :source },
    { column: :created_at },
    { column: :updated_at }
    ] } )

  add_index(t, "event_stats"          , ["created_at"]          , name: "index_event_stats_on_created_at"          , using: :btree)
  add_index(t, "event_stats"          , ["tenant_id"          , "event_type"          , "data"          , "source"          , "duration"]          , name: "index_event_stats_on_tenant_event_data_source_duration"          , using: :btree)

  t = add_table({ table: :events, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :event_type },
    { column: :status          ,        default: "queued" },
    { column: :data                                              , type: :jsonb },
    { column: :created_at },
    { column: :updated_at },
    { column: :schedule_date },
    { column: :source }
    ] } )

  add_index(t, "events"          , ["created_at"          , "status"          , "id"]          , name: "index_events_created_status_queued"          , where: "((status)::text = 'queued'::text)"          , using: :btree)
  add_index(t, "events"          , ["status"          , "schedule_date"          , "id"]          , name: "index_events_status_scheduled"          , where: "((status)::text = 'scheduled'::text)"          , using: :btree)
  add_index(t, "events"          , ["status"          , "updated_at"          , "id"]          , name: "index_events_status_running"          , where: "((status)::text = 'running'::text)"          , using: :btree)
  add_index(t, "events"          , ["tenant_id"          , "event_type"          , "data"          , "status"          , "id"]          , name: "index_events_tenant_type_data"          , using: :btree)

  t = add_table({ table: :exclusions, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :created_at          ,   null: false },
    { column: :updated_at          ,   null: false }
    ] } )

  add_index(t, "exclusions"          , ["context_id"          , "user_id"]          , name: "exclusions_context_id_user_id_idx"          , using: :btree)

  t = add_table({ table: :filter_defaults, force: :cascade, columns: [
    { column: :user_id                                           , type: :integer },
    { column: :context_id                                            , type: :integer },
    { column: :context_type },
    { column: :section },
    { column: :tenant_id                                           , type: :integer }
    ] } )

  add_index(t, "filter_defaults"          , ["tenant_id"]          , name: "index_filter_defaults_on_tenant_id"          , using: :btree)
  add_index(t, "filter_defaults"          , ["user_id"]          , name: "index_filter_defaults_on_user_id"          , using: :btree)

  t = add_table({ table: :groups, force: :cascade, columns: [
    { column: :name          ,          limit: 255 },
    { column: :group_type          ,    limit: 255 },
    { column: :created_at          ,                type: :datetime },
    { column: :updated_at          ,                type: :datetime },
    { column: :default          ,                                 default: false },
    { column: :enterprise_id                                            , type: :integer }
    ] } )

  add_index(t, "groups"          , ["enterprise_id"]          , name: "index_groups_on_enterprise_id"          , using: :btree)

  t = add_table({ table: :groups_tenants, id: false, force: :cascade, columns: [
    { column: :tenant_id          , null: false                                            , type: :integer },
    { column: :group_id          ,  null: false                                            , type: :integer }
    ] } )

  add_index(t, "groups_tenants"          , ["group_id"]          , name: "index_groups_tenants_on_group_id"          , using: :btree)
  add_index(t, "groups_tenants"          , ["tenant_id"          , "group_id"]          , name: "index_groups_tenants_on_tenant_id_and_group_id"          , using: :btree)

  t = add_table({ table: :hidden_email_templates, force: :cascade, columns: [
    { column: :email_template_id                                           , type: :integer },
    { column: :tenant_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :hidden_holidays, force: :cascade, columns: [
    { column: :holiday_id                                            , type: :integer },
    { column: :tenant_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :hidden_lead_types, force: :cascade, columns: [
    { column: :lead_type_id                                            , type: :integer },
    { column: :tenant_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :hidden_task_types, force: :cascade, columns: [
    { column: :task_type_id                                            , type: :integer },
    { column: :tenant_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :holiday_dates, force: :cascade, columns: [
    { column: :holiday_id                                            , type: :integer },
    { column: :date                                  , type: :date }
    ] } )

  add_index(t, "holiday_dates"          , ["holiday_id"]          , name: "index_holiday_dates_on_holiday_id"          , using: :btree)

  t = add_table({ table: :holidays, force: :cascade, columns: [
    { column: :state          ,         limit: 255 },
    { column: :year                                           , type: :integer },
    { column: :month                                            , type: :integer },
    { column: :day                                            , type: :integer },
    { column: :name          ,          limit: 255 },
    { column: :created_at          ,                type: :datetime },
    { column: :updated_at          ,                type: :datetime },
    { column: :tenant_id                                            , type: :integer },
    { column: :global          ,                                  default: false },
    { column: :user_id                                            , type: :integer },
    { column: :enterprise_id                                            , type: :integer }
    ] } )

  add_index(t, "holidays"          , ["enterprise_id"]          , name: "index_holidays_on_enterprise_id"          , using: :btree)
  add_index(t, "holidays"          , ["tenant_id"]          , name: "index_holidays_on_tenant_id"          , using: :btree)

  t = add_table({ table: :identities, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :email_marketing },
    { column: :contact_name },
    { column: :name },
    { column: :created_at          ,                        null: false },
    { column: :updated_at          ,                        null: false },
    { column: :last_validated },
    { column: :default          ,           default: false },
    { column: :phone },
    { column: :address_1 },
    { column: :address_2 },
    { column: :suburb },
    { column: :state },
    { column: :postcode },
    { column: :business_hours                                       , type: :text },
    { column: :website },
    { column: :marketing_name },
    { column: :holiday_last_day },
    { column: :holiday_returning },
    { column: :website_url },
    { column: :request_quote_url },
    { column: :facebook },
    { column: :twitter },
    { column: :instagram },
    { column: :pinterest },
    { column: :review_url },
    { column: :number },
    { column: :blog },
    { column: :linked_in },
    { column: :youtube }
    ] } )

  t = add_table({ table: :inquiries, force: :cascade, columns: [
    { column: :from_name },
    { column: :from_email },
    { column: :description                                        , type: :text },
    { column: :user_id                                            , type: :integer },
    { column: :pinned          ,                default: false },
    { column: :priority          ,              default: 1                                            , type: :integer },
    { column: :inquiry_type                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,                            null: false },
    { column: :updated_at          ,                            null: false },
    { column: :first_name },
    { column: :last_name },
    { column: :postcode },
    { column: :phone },
    { column: :company_name },
    { column: :company_id                                           , type: :integer },
    { column: :replied },
    { column: :contact_id                                           , type: :integer },
    { column: :lead_type_id                                           , type: :integer },
    { column: :lead_source },
    { column: :active_inquiry          ,        default: false },
    { column: :invoice_number },
    { column: :inquiry_status          ,        default: 0                                            , type: :integer },
    { column: :notification_ids          ,      default: []          ,                 array: true },
    { column: :salesrep_id                                            , type: :integer },
    { column: :lost_reason },
    { column: :unique_id                                            , type: :integer },
    { column: :location_user_id                                           , type: :integer },
    { column: :has_asset },
    { column: :inquiry_identifier                                           , type: :integer },
    { column: :sales_rep_platform_id },
    { column: :tmp_data                        ,              default: {}                                , type: :jsonb }
    ] } )

  add_index(t, "inquiries"          , ["tenant_id"]          , name: "index_inquiries_on_tenant_id"          , using: :btree)
  add_index(t, "inquiries"          , ["unique_id"          , "tenant_id"]          , name: "index_inquiries_on_unique_id_and_tenant_id"          , unique: true          , using: :btree)

  t = add_table({ table: :inquiry_attachments, force: :cascade, columns: [
    { column: :inquiry_id                                            , type: :integer },
    { column: :name },
    { column: :url }
    ] } )

  add_index(t, "inquiry_attachments"          , ["inquiry_id"]          , name: "index_inquiry_attachments_on_inquiry_id"          , using: :btree)

  t = add_table({ table: :interest_categories, force: :cascade, columns: [
    { column: :name },
    { column: :enterprise_id                                           , type: :integer },
    { column: :interest_type                                           , type: :integer }
    ] } )

  add_index(t, "interest_categories"          , ["enterprise_id"]          , name: "index_interest_categories_on_enterprise_id"          , using: :btree)

  t = add_table({ table: :interest_contexts, force: :cascade, columns: [
    { column: :interest_id                                            , type: :integer },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,    null: false },
    { column: :updated_at          ,    null: false },
    { column: :interest_type                                            , type: :integer }
    ] } )

  add_index(t, "interest_contexts"          , ["tenant_id"]          , name: "index_interest_contexts_on_tenant_id"          , using: :btree)

  t = add_table({ table: :interests, force: :cascade, columns: [
    { column: :name },
    { column: :user_id                                           , type: :integer },
    { column: :interest_category_id                                            , type: :integer }
    ] } )

  add_index(t, "interests"          , ["interest_category_id"]          , name: "index_interests_on_interest_category_id"          , using: :btree)

  t = add_table({ table: :invoice_elements, force: :cascade, columns: [
    { column: :invoice_id                                           , type: :integer },
    { column: :element_id                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :element_type },
    { column: :created_at          ,   type: :datetime },
    { column: :updated_at          ,   type: :datetime }
    ] } )

  add_index(t, "invoice_elements"          , ["element_id"          , "element_type"]          , name: "index_invoice_elements_on_element_id_and_element_type"          , using: :btree)
  add_index(t, "invoice_elements"          , ["tenant_id"]          , name: "index_invoice_elements_on_tenant_id"          , using: :btree)

  t = add_table({ table: :invoices, force: :cascade, columns: [
    { column: :name                                       , type: :text },
    { column: :grand_total          ,                            type: :decimal },
    { column: :printsmith_id          ,              limit: 8                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :created_at          ,                             type: :datetime },
    { column: :updated_at          ,                             type: :datetime },
    { column: :deleted_at          ,                             type: :datetime },
    { column: :completed },
    { column: :pickup_date          ,                            type: :datetime },
    { column: :wanted_by          ,                              type: :datetime },
    { column: :off_pending_date          ,                       type: :datetime },
    { column: :reorder_date          ,                           type: :datetime },
    { column: :salesrep_id                                            , type: :integer },
    { column: :notes_id          ,                   limit: 8                                           , type: :integer },
    { column: :special_instructions_id          ,    limit: 8                                           , type: :integer },
    { column: :documentlocation_id          ,        limit: 8                                           , type: :integer },
    { column: :total_cost          ,                             type: :decimal },
    { column: :source_taken_by          ,            limit: 255 },
    { column: :created_by          ,                 limit: 255 },
    { column: :customer_po          ,                limit: 255 },
    { column: :estimate_notes          ,             limit: 255 },
    { column: :invoice_number          ,             limit: 255 },
    { column: :price_sub_total          ,                        type: :decimal },
    { column: :price_total          ,                            type: :decimal },
    { column: :costed },
    { column: :firm_wanted_by_date },
    { column: :on_pending_list },
    { column: :production_location_id                                           , type: :integer },
    { column: :dirty },
    { column: :contact_id                                           , type: :integer },
    { column: :source_invoice_id          ,          limit: 8                                           , type: :integer },
    { column: :source_estimate_id          ,         limit: 8                                           , type: :integer },
    { column: :voided },
    { column: :converted_invoice_number          ,   limit: 8                                           , type: :integer },
    { column: :source_invoice_number          ,      limit: 8                                           , type: :integer },
    { column: :source_estimate_number          ,     limit: 8                                           , type: :integer },
    { column: :tax          ,                                    type: :decimal },
    { column: :grand_total_inc_tax          ,                    type: :decimal },
    { column: :overdue_actioned          ,                                                default: false },
    { column: :key },
    { column: :needs_pdf          ,                                                       default: true },
    { column: :ordered_date          ,                           type: :datetime },
    { column: :ready          ,                                                           default: false },
    { column: :associations_complete          ,                                           default: false },
    { column: :assocation_checks          ,                                               default: 0                                            , type: :integer },
    { column: :source_contact_id          ,          limit: 8                                           , type: :integer },
    { column: :source_account_id          ,          limit: 8                                           , type: :integer },
    { column: :deleted          ,                                                         default: false },
    { column: :public_token },
    { column: :instructions                                       , type: :text },
    { column: :source_created_at          ,                      type: :datetime },
    { column: :source_updated_at          ,                      type: :datetime },
    { column: :pdf_id                                           , type: :integer },
    { column: :accounting_month                                           , type: :integer },
    { column: :accounting_year                                            , type: :integer },
    { column: :sales_summary_id                                           , type: :integer },
    { column: :taken_by_id                                            , type: :integer },
    { column: :contact_group_id                                           , type: :integer },
    { column: :rounded_amount          ,                         type: :decimal },
    { column: :daily_accounting_day                                           , type: :integer },
    { column: :daily_accounting_month                                           , type: :integer },
    { column: :daily_accounting_year                                            , type: :integer },
    { column: :daily_sales_summary_id                                           , type: :integer },
    { column: :taken_by_user_id                                           , type: :integer },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :location_user_id                                           , type: :integer },
    { column: :report_name },
    { column: :remote_update_required },
    { column: :pdf_error_count          ,                                                 default: 0                                            , type: :integer },
    { column: :retry_location_update          ,                                           default: false },
    { column: :amount_due          ,                             type: :decimal },
    { column: :parent_contact_id                                            , type: :integer },
    { column: :dirty_skip_pdf          ,                                                  default: false },
    { column: :job_descriptions                                       , type: :text },
    { column: :last_refreshed_at },
    { column: :proof_by },
    { column: :web },
    { column: :reorder_followed_up },
    { column: :holdstate_id                                           , type: :integer },
    { column: :remote_sales_rep_update },
    { column: :remote_po_update },
    { column: :remote_proof_by_update },
    { column: :inquiry_id                                           , type: :integer },
    { column: :portal_key },
    { column: :proof_approval_status },
    { column: :proof_approved_id                                            , type: :integer },
    { column: :proof_id                                           , type: :integer },
    { column: :converted          ,                                                       default: false },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :external_id },
    { column: :source_invoice_external_id },
    { column: :meta_data                       ,                                                       default: {}                                , type: :jsonb },
    { column: :sale_id                                            , type: :integer },
    { column: :invoice_type          ,                                                    default: 0                                            , type: :integer },
    { column: :source_salesrep_id },
    { column: :sales_rep_platform_id },
    { column: :tmp_data                        ,                                                        default: {}                                , type: :jsonb }
    ] } )

  add_index(t, "invoices"          , ["accounting_year"]          , name: "index_invoices_on_accounting_year"          , using: :btree)
  add_index(t, "invoices"          , ["company_id"          , "id"]          , name: "index_invoices_on_company_id"          , using: :btree)
  add_index(t, "invoices"          , ["company_id"          , "on_pending_list"          , "deleted"          , "voided"          , "id"]          , name: "index_invoices_company_pending"          , where: "((on_pending_list = true) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["company_id"          , "pickup_date"          , "deleted"          , "voided"          , "total_cost"          , "grand_total_inc_tax"]          , name: "index_invoices_company_stats"          , where: "((pickup_date IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["contact_id"          , "grand_total"          , "on_pending_list"          , "pickup_date"          , "ordered_date"          , "sales_rep_user_id"          , "taken_by_user_id"          , "web"          , "voided"          , "deleted"]          , name: "index_invoices_contact_lists"          , where: "((NOT deleted) AND (NOT voided))"          , using: :btree)
  add_index(t, "invoices"          , ["contact_id"          , "pickup_date"          , "voided"          , "deleted"          , "id"]          , name: "index_invoices_contact_id_orders"          , where: "((pickup_date IS NOT NULL) AND (NOT voided) AND (NOT deleted))"          , using: :btree)
  add_index(t, "invoices"          , ["contact_id"          , "pickup_date"]          , name: "invoices_contact_id_pickup_date_idx"          , using: :btree)
  add_index(t, "invoices"          , ["contact_id"          , "web"          , "voided"]          , name: "index_invoices_contact_id_web_voided"          , using: :btree)
  add_index(t, "invoices"          , ["daily_sales_summary_id"          , "grand_total"          , "rounded_amount"]          , name: "index_invoices_daily_sales_summary_id_totals"          , using: :btree)
  add_index(t, "invoices"          , ["dirty_skip_pdf"]          , name: "index_invoices_on_dirty_skip_pdf"          , using: :btree)
  add_index(t, "invoices"          , ["external_id"          , "company_id"          , "tenant_id"]          , name: "index_invoices_on_external_id_and_company_id_and_tenant_id"          , unique: true          , using: :btree)
  add_index(t, "invoices"          , ["inquiry_id"]          , name: "index_invoices_on_inquiry_id"          , using: :btree)
  add_index(t, "invoices"          , ["key"          , "ordered_date"          , "voided"          , "deleted"          , "needs_pdf"          , "tenant_id"]          , name: "invoices_index"          , using: :btree)
  add_index(t, "invoices"          , ["location_user_id"]          , name: "index_invoices_on_location_user_id"          , using: :btree)
  add_index(t, "invoices"          , ["ordered_date"          , "tenant_id"          , "grand_total"          , "voided"          , "deleted"]          , name: "index_invoices_ordered_date_tenant_id"          , where: "((deleted = false) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["ordered_date"]          , name: "invoices_ordered_date_index"          , using: :btree)
  add_index(t, "invoices"          , ["pickup_date"          , "tenant_id"          , "voided"          , "deleted"          , "sales_rep_user_id"          , "taken_by_user_id"          , "location_user_id"          , "grand_total"          , "rounded_amount"          , "accounting_month"          , "accounting_year"]          , name: "index_invoices_on_pickup_date_tenant_sales_rep_taken_by"          , where: "((voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "invoices"          , ["pickup_date"]          , name: "index_invoices_on_pickup_date"          , using: :btree)
  add_index(t, "invoices"          , ["portal_key"          , "id"          , "deleted"          , "voided"]          , name: "index_invoices_portal_key"          , where: "((portal_key IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["printsmith_id"]          , name: "index_invoices_on_printsmith_id"          , using: :btree)
  add_index(t, "invoices"          , ["production_location_id"]          , name: "index_invoices_on_production_location_id"          , using: :btree)
  add_index(t, "invoices"          , ["remote_po_update"]          , name: "index_invoices_on_remote_po_update"          , using: :btree)
  add_index(t, "invoices"          , ["remote_proof_by_update"]          , name: "index_invoices_on_remote_proof_by_update"          , using: :btree)
  add_index(t, "invoices"          , ["remote_sales_rep_update"]          , name: "index_invoices_on_remote_sales_rep_update"          , using: :btree)
  add_index(t, "invoices"          , ["remote_update_required"]          , name: "index_invoices_on_remote_update_required"          , using: :btree)
  add_index(t, "invoices"          , ["reorder_date"          , "reorder_followed_up"          , "tenant_id"          , "pickup_date"          , "contact_id"          , "company_id"          , "deleted"          , "voided"]          , name: "index_invoices_on_reorder"          , where: "((reorder_followed_up IS NULL) AND (pickup_date IS NOT NULL) AND (voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "invoices"          , ["sale_id"]          , name: "index_invoices_on_sale_id"          , using: :btree)
  add_index(t, "invoices"          , ["sales_rep_user_id"]          , name: "index_invoices_on_sales_rep_user_id"          , using: :btree)
  add_index(t, "invoices"          , ["sales_summary_id"          , "grand_total"          , "rounded_amount"]          , name: "index_invoices_sales_summary_id_totals"          , using: :btree)
  add_index(t, "invoices"          , ["sales_summary_id"          , "pickup_date"]          , name: "index_invoices_sales_summary_id_pickup_date"          , where: "(sales_summary_id IS NOT NULL)"          , using: :btree)
  add_index(t, "invoices"          , ["source_created_at"]          , name: "index_invoices_on_source_created_at"          , using: :btree)
  add_index(t, "invoices"          , ["taken_by_user_id"          , "pickup_date"          , "total_cost"          , "deleted"          , "voided"]          , name: "index_invoices_taken_by_pickup_date_cost"          , where: "((pickup_date IS NOT NULL) AND (total_cost IS NOT NULL))"          , using: :btree)
  add_index(t, "invoices"          , ["taken_by_user_id"          , "source_taken_by"]          , name: "invoices_taken_by"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "accounting_month"          , "accounting_year"          , "pickup_date"          , "grand_total"          , "rounded_amount"          , "voided"          , "deleted"]          , name: "index_invoices_accounting_month_year"          , where: "((voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "accounting_year"          , "accounting_month"          , "voided"]          , name: "invoices_accounting_year_month"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "company_id"          , "contact_id"          , "id"]          , name: "index_invoices_id_company_contact"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "company_id"          , "grand_total"          , "dirty"]          , name: "index_invoices_on_tenant_id_and_company_id_and_grand_total"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "company_id"          , "pickup_date"          , "voided"          , "deleted"]          , name: "index_invoices_tenant_company_pickup"          , where: "((pickup_date IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "company_id"          , "source_account_id"          , "created_at"          , "id"]          , name: "index_invoices_tenant_company_source_account"          , order: {"created_at"=>:desc}          , where: "(source_account_id IS NOT NULL)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "contact_id"          , "company_id"]          , name: "tmp_fix_1"          , where: "(company_id IS NOT NULL)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "contact_id"          , "ordered_date"          , "grand_total"          , "voided"          , "deleted"          , "id"]          , name: "index_invoices_tenant_stats"          , where: "((voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "contact_id"          , "source_contact_id"          , "created_at"          , "id"]          , name: "index_invoices_tenant_contact_source_contact"          , order: {"created_at"=>:desc}          , where: "(source_contact_id IS NOT NULL)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "created_at"]          , name: "invoices_tenant_id_created_at_idx"          , order: {"created_at"=>:desc}          , where: "(associations_complete = false)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "id"          , "printsmith_id"          , "pickup_date"          , "deleted"          , "voided"          , "accounting_month"          , "daily_accounting_month"]          , name: "index_invoices_tenant_accounting"          , where: "((pickup_date > '2014-12-31 00:00:00'::timestamp without time zone) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)) AND ((accounting_month IS NULL) OR (daily_accounting_month IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "invoice_number"]          , name: "invoices_tenant_id_invoice_number_idx"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "name"]          , name: "invoices_tenant_id_gin_name"          , using: :gin)
  add_index(t, "invoices"          , ["tenant_id"          , "ordered_date"]          , name: "index_invoices_on_tenant_id_and_ordered_date"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "pdf_error_count"          , "ordered_date"]          , name: "tmp_fix_8"          , order: {"ordered_date"=>:desc}          , where: "((needs_pdf = true) AND (ordered_date > '2015-07-01 00:00:00'::timestamp without time zone))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "pickup_date"          , "accounting_month"          , "accounting_year"          , "voided"          , "deleted"]          , name: "index_invoices_tenant_id_pickup_date_sales"          , where: "((pickup_date IS NOT NULL) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "pickup_date"          , "accounting_year"          , "accounting_month"          , "daily_accounting_day"          , "daily_accounting_month"          , "daily_accounting_year"]          , name: "invoices_tenant_id_pickup_date_accounting_year_accounting_m_idx"          , where: "((voided = false) AND (deleted = false))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "pickup_date"          , "invoice_number"          , "voided"          , "deleted"          , "name"          , "id"]          , name: "index_search_sales"          , where: "((pickup_date IS NOT NULL) AND (NOT deleted) AND (NOT voided))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "printsmith_id"          , "voided"          , "id"]          , name: "index_invoices_tenant_printsmith_id_voided"          , where: "((voided = false) OR (voided IS NULL))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "printsmith_id"]          , name: "invoices_tenant_id_printsmith_id_idx"          , where: "(dirty = true)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "printsmith_id"]          , name: "invoices_tenant_id_printsmith_id_idx1"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "printsmith_id"]          , name: "invoices_unpaid_invoices_checker"          , where: "((pickup_date IS NOT NULL) AND (amount_due > (0)::numeric) AND (deleted = false) AND ((voided IS NULL) OR (voided = false)))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "production_location_id"          , "voided"          , "deleted"          , "on_pending_list"          , "id"]          , name: "index_invoices_tenant_production_location"          , where: "((voided IS FALSE) AND (deleted IS FALSE) AND (on_pending_list IS TRUE))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "sales_rep_user_id"          , "accounting_month"          , "accounting_year"          , "pickup_date"          , "grand_total"          , "voided"          , "deleted"]          , name: "index_invoices_on_sales_rep_accounting_pickup_grand_total"          , where: "((deleted = false) AND (voided = false) AND (pickup_date IS NOT NULL))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "salesrep_id"          , "id"          , "sales_rep_user_id"          , "location_user_id"]          , name: "index_invoices_tenant_id_sales_rep"          , where: "(salesrep_id IS NOT NULL)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "salesrep_id"          , "location_user_id"          , "created_at"          , "id"]          , name: "index_invoices_tenant_sales_rep_location_created_at"          , order: {"created_at"=>:desc}          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "source_taken_by"          , "id"          , "taken_by_user_id"]          , name: "index_invoices_tenant_id_taken_by"          , where: "(source_taken_by IS NOT NULL)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "source_taken_by"          , "source_created_at"]          , name: "index_invoices_on_tenant_stakenby_screatedat"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "source_updated_at"]          , name: "invoices_tenant_id_source_updated_at_asc"          , where: "(source_updated_at >= '2014-01-01 00:00:00'::timestamp without time zone)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "taken_by_user_id"          , "source_taken_by"          , "id"          , "created_at"]          , name: "tmp_fix_3"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "updated_at"          , "voided"          , "deleted"          , "remote_po_update"]          , name: "invoices_tenant_id_updated_at_voided_deleted_remote_po_upda_idx"          , where: "(remote_po_update = true)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "updated_at"          , "voided"          , "deleted"          , "remote_proof_by_update"]          , name: "invoices_tenant_id_updated_at_voided_deleted_remote_proof_b_idx"          , where: "(remote_proof_by_update = true)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "voided"          , "deleted"]          , name: "index_invoices_retry_sales_rep_update"          , where: "(remote_sales_rep_update = true)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"          , "wanted_by"          , "invoice_number"          , "voided"          , "deleted"          , "name"          , "id"]          , name: "index_search_orders"          , where: "((pickup_date IS NULL) AND (NOT deleted) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"]          , name: "corey_july_4"          , where: "(company_id IS NOT NULL)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"]          , name: "index_invoices_on_pending_list"          , where: "(on_pending_list = true)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"]          , name: "invoices_dirty_skip_pdf_index"          , where: "(dirty_skip_pdf = true)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"]          , name: "invoices_tenant_id_idx1"          , where: "(dirty = true)"          , using: :btree)
  add_index(t, "invoices"          , ["tenant_id"]          , name: "tmp_fix_11"          , where: "((retry_location_update = true) AND (deleted = false) AND ((voided = false) OR (voided IS NULL)))"          , using: :btree)
  add_index(t, "invoices"          , ["web"          , "company_id"          , "voided"          , "deleted"]          , name: "invoices_web"          , where: "((web = true) AND (deleted = false) AND (voided = false))"          , using: :btree)

  t = add_table({ table: :job_stats, force: :cascade, columns: [
    { column: :job_name },
    { column: :job_id                                           , type: :integer },
    { column: :job_start },
    { column: :job_end },
    { column: :exception_type },
    { column: :exception_message }
    ] } )

  t = add_table({ table: :lead_types, force: :cascade, columns: [
    { column: :name },
    { column: :description },
    { column: :enterprise_id                                           , type: :integer },
    { column: :lead_status_visibility          , default: []          ,    array: true                                           , type: :integer },
    { column: :active_status_version                                           , type: :integer },
    { column: :status          ,                 default: 2                                            , type: :integer },
    { column: :tenant_id                                           , type: :integer },
    { column: :global          ,                 default: false },
    { column: :is_default          ,             default: false }
    ] } )

  t = add_table({ table: :lists, force: :cascade, columns: [
    { column: :name },
    { column: :description                                        , type: :text },
    { column: :filter                        ,        default: {}          ,    null: false                                , type: :jsonb },
    { column: :user_id          ,                       null: false                                           , type: :integer },
    { column: :global          ,        default: false },
    { column: :site_wide          ,     default: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :enterprise_id          ,                 null: false                                           , type: :integer },
    { column: :created_at          ,                    null: false },
    { column: :updated_at          ,                    null: false }
    ] } )

  add_index(t, "lists"          , ["filter"]          , name: "index_lists_on_filter"          , using: :gin)
  add_index(t, "lists"          , ["tenant_id"]          , name: "index_lists_on_tenant_id"          , using: :btree)

  t = add_table({ table: :locations, force: :cascade, columns: [
    { column: :name },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,  type: :datetime          ,                 null: false },
    { column: :updated_at          ,  type: :datetime          ,                 null: false },
    { column: :default          ,                   default: false },
    { column: :identity_id                                            , type: :integer }
    ] } )

  add_index(t, "locations"          , ["tenant_id"]          , name: "index_locations_on_tenant_id"          , using: :btree)

  t = add_table({ table: :marketing_groups, force: :cascade, columns: [
    { column: :name },
    { column: :email_template_ids          ,          default: []          ,              array: true                                           , type: :integer },
    { column: :campaign_ids          ,                default: []          ,              array: true                                           , type: :integer },
    { column: :excluded_campaign_ids          ,       default: []          ,              array: true                                           , type: :integer },
    { column: :enterprise_id                                            , type: :integer },
    { column: :created_at          ,                               null: false },
    { column: :updated_at          ,                               null: false },
    { column: :excluded_email_template_ids          , default: []          ,              array: true                                           , type: :integer }
    ] } )

  t = add_table({ table: :meeting_attendees, force: :cascade, columns: [
    { column: :meeting_id                                            , type: :integer },
    { column: :user_id                                           , type: :integer },
    { column: :contact_id                                            , type: :integer },
    { column: :email_address                                                    , type: :text },
    { column: :status                                            , type: :integer },
    { column: :custom_time_zone                                                      , type: :text },
    { column: :note                                                      , type: :text },
    { column: :user_calendar_entry_id                                            , type: :integer }
    ] } )

  t = add_table({ table: :meetings, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :message                                        , type: :text },
    { column: :location                                       , type: :text },
    { column: :title                                        , type: :text },
    { column: :summary                                        , type: :text },
    { column: :start_date },
    { column: :end_date },
    { column: :status                                       , type: :text },
    { column: :note                                       , type: :text },
    { column: :created_at          ,                                      null: false },
    { column: :updated_at          ,                                      null: false },
    { column: :calendar_needs_update          ,           default: false },
    { column: :user_calendar_entry_id },
    { column: :reminder_sent          ,                   default: false },
    { column: :prospect_status_item_contact_id                                            , type: :integer }
    ] } )

  t = add_table({ table: :news, force: :cascade, columns: [
    { column: :title },
    { column: :body                                       , type: :text },
    { column: :created_at          ,                    null: false },
    { column: :updated_at          ,                    null: false },
    { column: :enterprise_id                                            , type: :integer },
    { column: :global          ,        default: false }
    ] } )

  add_index(t, "news"          , ["enterprise_id"]          , name: "index_news_on_enterprise_id"          , using: :btree)

  t = add_table({ table: :next_activities, force: :cascade, columns: [
    { column: :scheduled },
    { column: :contact_id                                           , type: :integer },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :status },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,   null: false },
    { column: :updated_at          ,   null: false }
    ] } )

  add_index(t, "next_activities"          , ["tenant_id"]          , name: "index_next_activities_on_tenant_id"          , using: :btree)

  t = add_table({ table: :notes, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :context_id                                           , type: :integer },
    { column: :context_type },
    { column: :message                                        , type: :text },
    { column: :created_at          ,                              null: false },
    { column: :updated_at          ,                              null: false },
    { column: :title                                        , type: :text },
    { column: :deleted          ,                 default: false },
    { column: :prospect_status_item_id                                            , type: :integer }
    ] } )

  t = add_table({ table: :original_users, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :target_user_id                                           , type: :integer },
    { column: :uuid },
    { column: :created_at          ,     null: false },
    { column: :updated_at          ,     null: false }
    ] } )

  t = add_table({ table: :pdfs, force: :cascade, columns: [
    { column: :page_count                                           , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :key                                        , type: :text },
    { column: :created_at          ,    type: :datetime          , null: false },
    { column: :updated_at          ,    type: :datetime          , null: false },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :external_id }
    ] } )

  add_index(t, "pdfs"          , ["key"          , "external_id"]          , name: "index_pdfs_on_key_and_external_id"          , using: :btree)
  add_index(t, "pdfs"          , ["key"          , "printsmith_id"]          , name: "pdfs_index"          , using: :btree)

  t = add_table({ table: :pending_attachments, force: :cascade, columns: [
    { column: :uuid },
    { column: :file_name },
    { column: :path },
    { column: :complete },
    { column: :inline          ,      default: false },
    { column: :needs_asset                       , default: {}                                , type: :jsonb },
    { column: :tenant_id                                            , type: :integer },
    { column: :error },
    { column: :warn },
    { column: :created_at },
    { column: :updated_at },
    { column: :bulk }
    ] } )

  t = add_table({ table: :phone_calls, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :phoneable_id                                           , type: :integer },
    { column: :phoneable_type          ,                  limit: 255 },
    { column: :to          ,                              limit: 255 },
    { column: :subject          ,                         limit: 255 },
    { column: :body                                       , type: :text },
    { column: :user_id                                            , type: :integer },
    { column: :created_at          ,                                  type: :datetime },
    { column: :updated_at          ,                                  type: :datetime },
    { column: :call_date          ,                                   type: :datetime },
    { column: :phone },
    { column: :contact_id                                           , type: :integer },
    { column: :call_type },
    { column: :twillio_message_sid },
    { column: :sms_status },
    { column: :test_number },
    { column: :prospect_status_item_contact_id                                            , type: :integer },
    { column: :twillio_message }
    ] } )

  add_index(t, "phone_calls"          , ["phoneable_id"          , "phoneable_type"]          , name: "index_phone_calls_on_phoneable_id_and_phoneable_type"          , using: :btree)
  add_index(t, "phone_calls"          , ["tenant_id"]          , name: "index_phone_calls_on_tenant_id"          , using: :btree)
  add_index(t, "phone_calls"          , ["user_id"]          , name: "index_phone_calls_on_user_id"          , using: :btree)

  t = add_table({ table: :portal_comments, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :user_id                                            , type: :integer },
    { column: :context_type },
    { column: :context_id                                           , type: :integer },
    { column: :body                                       , type: :text },
    { column: :created_at          ,   null: false },
    { column: :updated_at          ,   null: false },
    { column: :name },
    { column: :status }
    ] } )

  t = add_table({ table: :production_locations, force: :cascade, columns: [
    { column: :name          ,              limit: 255 },
    { column: :tenant_id                                            , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :created_at          ,                    type: :datetime },
    { column: :updated_at          ,                    type: :datetime },
    { column: :dirty },
    { column: :deleted          ,                                     default: false },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :printsmith_key },
    { column: :orderby                                            , type: :integer },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  add_index(t, "production_locations"          , ["tenant_id"          , "printsmith_key"          , "deleted"          , "id"          , "orderby"          , "name"]          , name: "index_production_locations_tenant_key"          , where: "((NOT deleted) AND (printsmith_key IS NOT NULL))"          , using: :btree)
  add_index(t, "production_locations"          , ["tenant_id"]          , name: "index_production_locations_on_tenant_id"          , using: :btree)

  t = add_table({ table: :proofs, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :asset_data                                              , type: :jsonb },
    { column: :approval_status },
    { column: :created_at },
    { column: :updated_at },
    { column: :invoice_id                                           , type: :integer },
    { column: :user_id                                            , type: :integer }
    ] } )

  t = add_table({ table: :prospect_status_item_contacts, force: :cascade, columns: [
    { column: :prospect_status_item_id                                            , type: :integer },
    { column: :contact_id                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :start_date },
    { column: :due_date },
    { column: :completion_date },
    { column: :status                                           , type: :integer }
    ] } )

  add_index(t, "prospect_status_item_contacts"          , ["prospect_status_item_id"          , "contact_id"          , "tenant_id"]          , name: "prospect_status_item_contact_unique_index"          , unique: true          , using: :btree)

  t = add_table({ table: :prospect_status_items, force: :cascade, columns: [
    { column: :name },
    { column: :prospect_status_id                                            , type: :integer },
    { column: :lead_type_id                                            , type: :integer },
    { column: :tenant_id                                           , type: :integer },
    { column: :enterprise_id                                           , type: :integer },
    { column: :position                                            , type: :integer },
    { column: :item_type                                           , type: :integer },
    { column: :start_after_days                                            , type: :integer },
    { column: :completion_time          ,    default: 0                                            , type: :integer },
    { column: :description                                                    , type: :text },
    { column: :email_template_id                                           , type: :integer }
    ] } )

  add_index(t, "prospect_status_items"          , ["enterprise_id"]          , name: "index_prospect_status_items_on_enterprise_id"          , using: :btree)
  add_index(t, "prospect_status_items"          , ["lead_type_id"]          , name: "index_prospect_status_items_on_lead_type_id"          , using: :btree)
  add_index(t, "prospect_status_items"          , ["prospect_status_id"]          , name: "index_prospect_status_items_on_prospect_status_id"          , using: :btree)
  add_index(t, "prospect_status_items"          , ["tenant_id"]          , name: "index_prospect_status_items_on_tenant_id"          , using: :btree)

  t = add_table({ table: :prospect_status_versions, force: :cascade, columns: [
    { column: :lead_type_id                                            , type: :integer },
    { column: :version_no                                            , type: :integer },
    { column: :status                                            , type: :integer }
    ] } )

  add_index(t, "prospect_status_versions"          , ["lead_type_id"]          , name: "index_prospect_status_versions_on_lead_type_id"          , using: :btree)

  t = add_table({ table: :prospect_statuses, force: :cascade, columns: [
    { column: :name },
    { column: :user_id                                            , type: :integer },
    { column: :enterprise_id          ,                          null: false                                            , type: :integer },
    { column: :created_at          ,                             null: false },
    { column: :updated_at          ,                             null: false },
    { column: :position                                           , type: :integer },
    { column: :lead_type_id          ,               default: 0                                           , type: :integer },
    { column: :tenant_id          ,                  default: 0                                           , type: :integer },
    { column: :prospect_status_version_id          , default: 0                                           , type: :integer }
    ] } )

  t = add_table({ table: :read_marks, force: :cascade, columns: [
    { column: :readable_id                                            , type: :integer },
    { column: :readable_type          , null: false },
    { column: :reader_id                                            , type: :integer },
    { column: :reader_type          ,   null: false },
    { column: :timestamp }
    ] } )

  add_index(t, "read_marks"          , ["reader_id"          , "reader_type"          , "readable_type"          , "readable_id"]          , name: "read_marks_reader_readable_index"          , using: :btree)

  t = add_table({ table: :region_configs, force: :cascade, columns: [
    { column: :option                                       , type: :text },
    { column: :value                                        , type: :text }
    ] } )

  t = add_table({ table: :report_rows, force: :cascade, columns: [
    { column: :columns          ,   default: []          , array: true                                           , type: :integer },
    { column: :report_id                                           , type: :integer },
    { column: :position          ,  default: 0                                           , type: :integer }
    ] } )

  add_index(t, "report_rows"          , ["report_id"]          , name: "index_report_rows_on_report_id"          , using: :btree)

  t = add_table({ table: :reports, force: :cascade, columns: [
    { column: :name },
    { column: :tenant_id                                           , type: :integer },
    { column: :user_id                                           , type: :integer },
    { column: :global }
    ] } )

  add_index(t, "reports"          , ["global"]          , name: "index_reports_on_global"          , using: :btree)
  add_index(t, "reports"          , ["tenant_id"]          , name: "index_reports_on_tenant_id"          , using: :btree)
  add_index(t, "reports"          , ["user_id"]          , name: "index_reports_on_user_id"          , using: :btree)

  t = add_table({ table: :sales_base_taxes, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :source_type                                            , type: :integer },
    { column: :associations_complete          ,                          default: false },
    { column: :dirty          ,                                          default: false },
    { column: :deleted },
    { column: :posted_date          ,           type: :datetime },
    { column: :source_created_at          ,     type: :datetime },
    { column: :source_updated_at          ,     type: :datetime },
    { column: :total          ,                 type: :decimal },
    { column: :sales_base_id                                            , type: :integer },
    { column: :source_sales_base_id                                           , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :total_tax          ,             type: :decimal },
    { column: :total_non_taxable          ,     type: :decimal },
    { column: :total_taxable          ,         type: :decimal },
    { column: :created_at          ,            type: :datetime          ,                            null: false },
    { column: :updated_at          ,            type: :datetime          ,                            null: false },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  add_index(t, "sales_base_taxes"          , ["printsmith_id"          , "tenant_id"]          , name: "sales_base_taxes_printsmith_id_tenant_id_idx"          , using: :btree)
  add_index(t, "sales_base_taxes"          , ["tenant_id"          , "deleted"          , "source_type"          , "source_sales_base_id"          , "total_taxable"          , "total_non_taxable"]          , name: "index_sales_base_taxes_tenant_id_taxability"          , using: :btree)

  t = add_table({ table: :sales_categories, force: :cascade, columns: [
    { column: :glaccount },
    { column: :interest },
    { column: :deleted          ,                     default: false },
    { column: :name },
    { column: :nonsale },
    { column: :salescatid                                           , type: :integer },
    { column: :shipping },
    { column: :printsmith_id                                            , type: :integer },
    { column: :dirty          ,                       default: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :created_at          ,    type: :datetime },
    { column: :updated_at          ,    type: :datetime },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  add_index(t, "sales_categories"          , ["tenant_id"]          , name: "index_sales_categories_on_tenant_id"          , using: :btree)

  t = add_table({ table: :sales_rep_updates, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :sales_rep_id                                           , type: :integer },
    { column: :created_at },
    { column: :updated_at }
    ] } )

  t = add_table({ table: :sales_reps, force: :cascade, columns: [
    { column: :name          ,                limit: 255 },
    { column: :tenant_id                                            , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :created_at          ,                      type: :datetime },
    { column: :updated_at          ,                      type: :datetime },
    { column: :dirty },
    { column: :deleted          ,                                       default: false },
    { column: :user_id                                            , type: :integer },
    { column: :location_id                                            , type: :integer },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :latest_context_date },
    { column: :auto_mapped          ,                                   default: false },
    { column: :add_in_table_list,                             default: false },
    { column: :external_id },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  add_index(t, "sales_reps"          , ["location_id"          , "printsmith_id"          , "deleted"]          , name: "index_sales_reps_on_location_printsmith_id"          , using: :btree)
  add_index(t, "sales_reps"          , ["tenant_id"          , "printsmith_id"          , "location_id"]          , name: "index_sales_reps_tenant_printsmith_id_loction_not_null"          , where: "(location_id IS NOT NULL)"          , using: :btree)
  add_index(t, "sales_reps"          , ["tenant_id"]          , name: "corey_july_2"          , where: "(user_id IS NOT NULL)"          , using: :btree)
  add_index(t, "sales_reps"          , ["tenant_id"]          , name: "index_sales_reps_on_tenant_id"          , using: :btree)
  add_index(t, "sales_reps"          , ["user_id"          , "printsmith_id"          , "deleted"]          , name: "index_sales_reps_on_user_printsmith_id"          , using: :btree)

  t = add_table({ table: :sales_summaries, force: :cascade, columns: [
    { column: :arbalance          ,              type: :decimal },
    { column: :arcard          ,                 type: :decimal },
    { column: :arcash          ,                 type: :decimal },
    { column: :archarge          ,               type: :decimal },
    { column: :archeck          ,                type: :decimal },
    { column: :bankdeposit          ,            type: :decimal },
    { column: :cardcount                                            , type: :integer },
    { column: :closeoutdate          ,           type: :datetime },
    { column: :composite },
    { column: :datarepaired },
    { column: :depositbalance          ,         type: :decimal },
    { column: :discounts          ,              type: :decimal },
    { column: :draw          ,                   type: :decimal },
    { column: :employees          ,              type: :decimal },
    { column: :enddate          ,                type: :datetime },
    { column: :fmaccount          ,              type: :decimal },
    { column: :forfeitdeposits          ,        type: :decimal },
    { column: :invoicetotal          ,           type: :decimal },
    { column: :isdeleted },
    { column: :markups          ,                type: :decimal },
    { column: :newdeposits          ,            type: :decimal },
    { column: :nontaxreceipts          ,         type: :decimal },
    { column: :nontaxsales          ,            type: :decimal },
    { column: :numperiods                                           , type: :integer },
    { column: :onaccount          ,              type: :decimal },
    { column: :onaccountbalance          ,       type: :decimal },
    { column: :otherhours          ,             type: :decimal },
    { column: :poscard          ,                type: :decimal },
    { column: :poscash          ,                type: :decimal },
    { column: :poscheck          ,               type: :decimal },
    { column: :presshours          ,             type: :decimal },
    { column: :productionhours          ,        type: :decimal },
    { column: :refundchecks          ,           type: :decimal },
    { column: :returndeposits          ,         type: :decimal },
    { column: :shiftcloseout },
    { column: :shipping          ,               type: :decimal },
    { column: :squarefeet                                           , type: :integer },
    { column: :taxonreceipts          ,          type: :decimal },
    { column: :taxonsales          ,             type: :decimal },
    { column: :taxablereceipts          ,        type: :decimal },
    { column: :taxablesales          ,           type: :decimal },
    { column: :totaldeletes          ,           type: :decimal },
    { column: :totalmemos          ,             type: :decimal },
    { column: :totalnosalememos          ,       type: :decimal },
    { column: :totalother          ,             type: :decimal },
    { column: :totalreceipts          ,          type: :decimal },
    { column: :totalsales          ,             type: :decimal },
    { column: :totalvoid          ,              type: :decimal },
    { column: :variance          ,               type: :decimal },
    { column: :wiptotaldone          ,           type: :decimal },
    { column: :wiptotalest          ,            type: :decimal },
    { column: :wiptotalinv          ,            type: :decimal },
    { column: :daily          ,                                           default: false },
    { column: :monthly          ,                                         default: false },
    { column: :printsmith_id                                            , type: :integer },
    { column: :dirty          ,                                           default: false },
    { column: :created_at          ,             type: :datetime          ,                            null: false },
    { column: :updated_at          ,             type: :datetime          ,                            null: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :applydeposits          ,          type: :decimal },
    { column: :deleted          ,                                         default: false },
    { column: :accounting_day                                           , type: :integer },
    { column: :accounting_month                                           , type: :integer },
    { column: :accounting_year                                            , type: :integer },
    { column: :daily_accounting_day                                           , type: :integer },
    { column: :daily_accounting_month                                           , type: :integer },
    { column: :daily_accounting_year                                            , type: :integer },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :complete          ,                                        default: false },
    { column: :accurate          ,                                        default: false },
    { column: :difference          ,             type: :decimal },
    { column: :invoice_count                                            , type: :integer },
    { column: :avg_sale          ,               type: :decimal },
    { column: :attempts          ,                                        default: 0                                            , type: :integer },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  add_index(t, "sales_summaries"          , ["accounting_month"]          , name: "index_sales_summaries_on_accounting_month"          , using: :btree)
  add_index(t, "sales_summaries"          , ["accounting_year"]          , name: "index_sales_summaries_on_accounting_year"          , using: :btree)
  add_index(t, "sales_summaries"          , ["printsmith_id"          , "tenant_id"]          , name: "index_sales_summaries_on_printsmith_id_and_tenant_id"          , using: :btree)
  add_index(t, "sales_summaries"          , ["tenant_id"          , "closeoutdate"]          , name: "sales_summaries_tenant_id_closeoutdate_idx"          , order: {"closeoutdate"=>:desc}          , using: :btree)
  add_index(t, "sales_summaries"          , ["tenant_id"          , "daily_accounting_year"          , "daily_accounting_month"          , "daily_accounting_day"]          , name: "sales_summaries_tenant_id_daily_accounting_year_daily_accou_idx"          , using: :btree)
  add_index(t, "sales_summaries"          , ["tenant_id"          , "printsmith_id"          , "deleted"          , "id"]          , name: "index_sales_summaries_tenant_printsmith_id_not_deleted"          , where: "(deleted = false)"          , using: :btree)

  t = add_table({ table: :sales_summary_pickups, force: :cascade, columns: [
    { column: :source_account_history_item_id                                           , type: :integer },
    { column: :account_history_item_id                                            , type: :integer },
    { column: :source_sales_summary_id                                            , type: :integer },
    { column: :sales_summary_id                                           , type: :integer },
    { column: :created_at          ,                     type: :datetime          ,                 null: false },
    { column: :updated_at          ,                     type: :datetime          ,                 null: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :printsmith_id                                            , type: :integer },
    { column: :deleted          ,                                      default: false },
    { column: :dirty          ,                                        default: false },
    { column: :ready          ,                                        default: false },
    { column: :boolean          ,                                      default: false },
    { column: :associations_complete          ,                        default: false },
    { column: :assocation_checks          ,                            default: 0                                           , type: :integer },
    { column: :integer          ,                                      default: 0                                           , type: :integer },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb }
    ] } )

  add_index(t, "sales_summary_pickups"          , ["source_account_history_item_id"]          , name: "index_sales_summary_pickups_on_source_account_history_item_id"          , using: :btree)
  add_index(t, "sales_summary_pickups"          , ["source_sales_summary_id"]          , name: "index_sales_summary_pickups_on_source_sales_summary_id"          , using: :btree)
  add_index(t, "sales_summary_pickups"          , ["tenant_id"          , "printsmith_id"]          , name: "sales_summary_pickups_tenant_id_printsmith_id_idx"          , using: :btree)
  add_index(t, "sales_summary_pickups"          , ["tenant_id"          , "source_account_history_item_id"          , "source_sales_summary_id"          , "deleted"]          , name: "index_sales_summary_source_account_history_item"          , where: "(deleted = false)"          , using: :btree)

  t = add_table({ table: :sales_tag_by_months, force: :cascade, columns: [
    { column: :tenant_id                                           , type: :integer },
    { column: :total_sales                                           , type: :integer },
    { column: :total_invoice_count                                           , type: :integer },
    { column: :total_companies                                           , type: :integer },
    { column: :tags_data          ,           default: {}          ,   null: false                                , type: :jsonb },
    { column: :month_date                                  , type: :date },
    { column: :update_required          ,     default: true }
    ] } )

  add_index(t, "sales_tag_by_months"          , ["tenant_id"]          , name: "index_sales_tag_by_months_on_tenant_id"          , using: :btree)

  t = add_table({ table: :salestargets, force: :cascade, columns: [
    { column: :target_type                                           , type: :integer },
    { column: :name },
    { column: :amount                                            , type: :integer },
    { column: :tenant_id                                           , type: :integer },
    { column: :user_id                                           , type: :integer },
    { column: :items                                           , type: :integer },
    { column: :enterprise_id                                           , type: :integer }
    ] } )

  add_index(t, "salestargets"          , ["tenant_id"]          , name: "index_salestargets_on_tenant_id"          , using: :btree)

  t = add_table({ table: :saved_reports, force: :cascade, columns: [
    { column: :created_at },
    { column: :updated_at },
    { column: :name },
    { column: :enterprise_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :data                                              , type: :jsonb },
    { column: :ytd                       ,           default: {}          , null: false                               , type: :jsonb },
    { column: :report_type }
    ] } )

  t = add_table({ table: :shared_users, force: :cascade, columns: [
    { column: :user_id                                           , type: :integer },
    { column: :shared_id                                           , type: :integer }
    ] } )

  t = add_table({ table: :shipments, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :description                                        , type: :text },
    { column: :grand_total },
    { column: :price_total },
    { column: :price_sub_total },
    { column: :contact_id                                           , type: :integer },
    { column: :company_id                                           , type: :integer },
    { column: :voided          ,                     default: false },
    { column: :deleted          ,                    default: false },
    { column: :needs_pdf          ,                  default: false },
    { column: :shipment_type },
    { column: :mbe_tracking },
    { column: :courier_tracking },
    { column: :courier_weight },
    { column: :shipment_date },
    { column: :source_account_platform_id },
    { column: :source_invoice_platform_id },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :created_at          ,                                 null: false },
    { column: :updated_at          ,                                 null: false },
    { column: :pdf_error_count          ,            default: 0                                           , type: :integer },
    { column: :key },
    { column: :associations_complete          ,      default: false },
    { column: :association_checks          ,         default: 0                                           , type: :integer },
    { column: :mbe_service_id                                           , type: :integer },
    { column: :packge_type_id                                           , type: :integer },
    { column: :goods_type_id                                            , type: :integer },
    { column: :courier_id                                           , type: :integer },
    { column: :courier_service_id                                           , type: :integer },
    { column: :delivered          ,                  default: false },
    { column: :delivered_date },
    { column: :status },
    { column: :pdf_id                                           , type: :integer },
    { column: :not_to_invoice          ,             default: false },
    { column: :dirty          ,                      default: false },
    { column: :total_cost          ,                 default: 0.0 },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :source_salesrep_id },
    { column: :sales_rep_platform_id },
    { column: :tmp_data                        ,                   default: {}                               , type: :jsonb },
    { column: :accounting_month                                           , type: :integer },
    { column: :accounting_year                                            , type: :integer },
    { column: :sales_summary_id                                           , type: :integer },
    { column: :daily_accounting_day                                           , type: :integer },
    { column: :daily_accounting_month                                           , type: :integer },
    { column: :daily_accounting_year                                            , type: :integer },
    { column: :daily_sales_summary_id                                           , type: :integer }
    ] } )

  add_index(t, "shipments"          , ["tenant_id"]          , name: "shipments_status_index"          , where: "((status)::text = ANY (ARRAY[('CREATED'::character varying)::text          , ('DRAFT_WAYBILL'::character varying)::text          , ('INVOICED'::character varying)::text]))"          , using: :btree)

  t = add_table({ table: :sms_template_categories, force: :cascade, columns: [
    { column: :sms_template_id                                           , type: :integer },
    { column: :category                                            , type: :integer }
    ] } )

  t = add_table({ table: :sms_templates, force: :cascade, columns: [
    { column: :name                                       , type: :text },
    { column: :body                                       , type: :text },
    { column: :global          ,        default: false },
    { column: :user_id          ,                       null: false                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :enterprise_id          ,                 null: false                                           , type: :integer },
    { column: :created_at },
    { column: :updated_at },
    { column: :wrapper_id                                           , type: :integer }
    ] } )

  add_index(t, "sms_templates"          , ["tenant_id"]          , name: "index_sms_templates_on_tenant_id"          , using: :btree)

  t = add_table({ table: :statistics, id: :bigserial, force: :cascade, columns: [
    { column: :company_id                                           , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :month                                            , type: :integer },
    { column: :year                                           , type: :integer },
    { column: :financial_year                                           , type: :integer },
    { column: :rank                                           , type: :integer },
    { column: :created_at          ,            type: :datetime },
    { column: :updated_at          ,            type: :datetime },
    { column: :total          ,                 type: :decimal },
    { column: :average          ,               type: :decimal },
    { column: :count                                            , type: :integer },
    { column: :statistic_for },
    { column: :needs_recalc          ,                                   default: false },
    { column: :accounting_year                                            , type: :integer },
    { column: :accounting_month                                           , type: :integer },
    { column: :accounting_day                                           , type: :integer },
    { column: :calendar_year                                            , type: :integer },
    { column: :calendar_month                                           , type: :integer },
    { column: :calendar_day                                           , type: :integer },
    { column: :total_sales          ,           type: :decimal },
    { column: :invoice_sales          ,         type: :decimal },
    { column: :cash_sales          ,            type: :decimal },
    { column: :adjustments          ,           type: :decimal },
    { column: :day                                            , type: :integer },
    { column: :markups          ,               type: :decimal },
    { column: :department_cash_sales          , type: :decimal },
    { column: :finance_charges          ,       type: :decimal },
    { column: :user_id                                            , type: :integer },
    { column: :location_id                                            , type: :integer },
    { column: :date                   , type: :date },
    { column: :sales_rep_user_id                                            , type: :integer },
    { column: :order_intake },
    { column: :shipments },
    { column: :invoiced_sales },
    { column: :deferred_sales }
    ] } )

  add_index(t, "statistics"          , ["accounting_month"]          , name: "index_statistics_on_accounting_month"          , using: :btree)
  add_index(t, "statistics"          , ["accounting_year"]          , name: "index_statistics_on_accounting_year"          , using: :btree)
  add_index(t, "statistics"          , ["date"          , "tenant_id"]          , name: "statistics_date_tenant_id_idx"          , using: :btree)
  add_index(t, "statistics"          , ["location_id"]          , name: "index_statistics_on_location_id"          , using: :btree)
  add_index(t, "statistics"          , ["statistic_for"]          , name: "index_statistics_on_statistic_for"          , using: :btree)
  add_index(t, "statistics"          , ["tenant_id"          , "accounting_year"          , "accounting_month"          , "statistic_for"]          , name: "statistics_tenant_id_accounting_year_accounting_month_stati_idx"          , using: :btree)
  add_index(t, "statistics"          , ["user_id"]          , name: "index_statistics_on_user_id"          , using: :btree)

  t = add_table({ table: :suppressed_addresses, force: :cascade, columns: [
    { column: :tenant_id                                           , type: :integer },
    { column: :email_address },
    { column: :date },
    { column: :reason },
    { column: :ignore          ,        default: false }
    ] } )

  add_index(t, "suppressed_addresses"          , ["tenant_id"          , "ignore"          , "email_address"          , "id"]          , name: "index_suppressed_addresses_tenant_trimmed_email"          , where: "(ignore = false)"          , using: :btree)

  t = add_table({ table: :tag_categories, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :name },
    { column: :word_matches          ,       default: ""          ,    null: false },
    { column: :up_to_date          ,         default: false },
    { column: :created_at          ,                         null: false },
    { column: :updated_at          ,                         null: false },
    { column: :hidden          ,             default: false },
    { column: :deleted          ,            default: false },
    { column: :performing_cleanup          , default: false },
    { column: :description                                        , type: :text },
    { column: :hidden_tenants                        ,     default: {}                               , type: :jsonb },
    { column: :enterprise_id                                            , type: :integer }
    ] } )

  add_index(t, "tag_categories"          , ["tenant_id"          , "enterprise_id"          , "name"          , "hidden_tenants"          , "hidden"          , "performing_cleanup"          , "deleted"          , "id"]          , name: "index_tag_categories_tenant"          , where: "((NOT hidden) AND (NOT performing_cleanup) AND (NOT deleted))"          , using: :btree)

  t = add_table({ table: :tag_category_contexts, force: :cascade, columns: [
    { column: :name },
    { column: :tag_category_id                                            , type: :integer },
    { column: :last_scanned_id          ,     default: 0                                            , type: :integer },
    { column: :last_scanned_offset          , default: 0                                            , type: :integer },
    { column: :last_scanned },
    { column: :scan_progress                       ,       default: {}                                , type: :jsonb }
    ] } )

  t = add_table({ table: :tags, force: :cascade, columns: [
    { column: :name },
    { column: :tenant_id                                           , type: :integer },
    { column: :user_id                                           , type: :integer },
    { column: :taggable_id                                           , type: :integer },
    { column: :taggable_type },
    { column: :tag_category_id                                           , type: :integer },
    { column: :manual          ,          default: false },
    { column: :deleted          ,         default: false },
    { column: :parent_id                                           , type: :integer },
    { column: :bubbled }
    ] } )

  add_index(t, "tags"          , ["tag_category_id"]          , name: "index_tags_on_tag_category_id"          , using: :btree)
  add_index(t, "tags"          , ["taggable_id"          , "taggable_type"          , "tag_category_id"          , "deleted"]          , name: "index_tags_company"          , where: "((NOT deleted) AND ((taggable_type)::text = 'Company'::text))"          , using: :btree)
  add_index(t, "tags"          , ["taggable_id"          , "taggable_type"          , "tag_category_id"          , "deleted"]          , name: "index_tags_contact"          , where: "((NOT deleted) AND ((taggable_type)::text = 'Contact'::text))"          , using: :btree)
  add_index(t, "tags"          , ["taggable_id"          , "taggable_type"          , "tag_category_id"          , "deleted"]          , name: "index_tags_estimate"          , where: "((NOT deleted) AND ((taggable_type)::text = 'Estimate'::text))"          , using: :btree)
  add_index(t, "tags"          , ["taggable_id"          , "taggable_type"          , "tag_category_id"          , "deleted"]          , name: "index_tags_invoice"          , where: "((NOT deleted) AND ((taggable_type)::text = 'Invoice'::text))"          , using: :btree)
  add_index(t, "tags"          , ["taggable_type"          , "taggable_id"]          , name: "index_tags_on_taggable_type_and_taggable_id"          , using: :btree)
  add_index(t, "tags"          , ["tenant_id"]          , name: "index_tags_on_tenant_id"          , using: :btree)
  add_index(t, "tags"          , ["user_id"]          , name: "index_tags_on_user_id"          , using: :btree)

  t = add_table({ table: :taken_by_updates, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :taken_by_id                                            , type: :integer },
    { column: :created_at },
    { column: :updated_at }
    ] } )

  t = add_table({ table: :taken_bys, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :name },
    { column: :created_at          ,          type: :datetime          ,                 null: false },
    { column: :updated_at          ,          type: :datetime          ,                 null: false },
    { column: :location_id                                            , type: :integer },
    { column: :latest_context_date },
    { column: :auto_mapped          ,                       default: false },
    { column: :external_id }
    ] } )

  add_index(t, "taken_bys"          , ["location_id"]          , name: "index_taken_bys_on_location_id"          , using: :btree)
  add_index(t, "taken_bys"          , ["tenant_id"]          , name: "index_taken_bys_on_tenant_id"          , using: :btree)
  add_index(t, "taken_bys"          , ["user_id"]          , name: "index_taken_bys_on_user_id"          , using: :btree)

  t = add_table({ table: :targets, force: :cascade, columns: [
    { column: :tenant_id                                           , type: :integer },
    { column: :location_id                                           , type: :integer },
    { column: :taken_by_user_id                                            , type: :integer },
    { column: :sales_rep_user_id                                           , type: :integer },
    { column: :location_user_id                                            , type: :integer },
    { column: :month                                           , type: :integer },
    { column: :year                                            , type: :integer },
    { column: :total                                           , type: :integer },
    { column: :klass                                           , type: :integer }
    ] } )

  add_index(t, "targets"          , ["tenant_id"]          , name: "index_targets_on_tenant_id"          , using: :btree)

  t = add_table({ table: :task_repeats, force: :cascade, columns: [
    { column: :task_id                                            , type: :integer },
    { column: :repeat_type },
    { column: :created_at },
    { column: :updated_at }
    ] } )

  t = add_table({ table: :task_types, force: :cascade, columns: [
    { column: :name },
    { column: :tenant_id                                           , type: :integer },
    { column: :enterprise_id                                           , type: :integer },
    { column: :user_id                                           , type: :integer },
    { column: :global          ,        default: false }
    ] } )

  add_index(t, "task_types"          , ["enterprise_id"]          , name: "index_task_types_on_enterprise_id"          , using: :btree)
  add_index(t, "task_types"          , ["tenant_id"]          , name: "index_task_types_on_tenant_id"          , using: :btree)

  t = add_table({ table: :tasks, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :mode },
    { column: :status },
    { column: :name },
    { column: :description                                        , type: :text },
    { column: :taskable_id                                            , type: :integer },
    { column: :taskable_type },
    { column: :created_at          ,                      type: :datetime },
    { column: :updated_at          ,                      type: :datetime },
    { column: :start_date          ,                      type: :datetime },
    { column: :end_date          ,                        type: :datetime },
    { column: :assigned_user_id                                           , type: :integer },
    { column: :add_to_calendar          ,                               default: false },
    { column: :position                                           , type: :integer },
    { column: :calendar_needs_update          ,                         default: false },
    { column: :user_calendar_entry_id },
    { column: :assigned_user_calendar_entry_id },
    { column: :final_comment                                        , type: :text },
    { column: :completed_at },
    { column: :task_type_id                                           , type: :integer },
    { column: :portal_task          ,                                   default: false },
    { column: :notify_due          ,                                    default: false },
    { column: :notify_due_email_sent          ,                         default: false },
    { column: :notify_date },
    { column: :task_repeat_id                                           , type: :integer },
    { column: :notification_ids          ,                              default: []          ,    array: true },
    { column: :inquiry_id                                           , type: :integer },
    { column: :prospect_status_item_contact_id                                            , type: :integer }
    ] } )

  add_index(t, "tasks"          , ["notify_due_email_sent"          , "notify_due"          , "notify_date"]          , name: "index_tasks_on_notify"          , where: "((notify_due_email_sent = false) AND (notify_due = true))"          , using: :btree)
  add_index(t, "tasks"          , ["position"]          , name: "index_tasks_on_position"          , using: :btree)
  add_index(t, "tasks"          , ["taskable_type"          , "taskable_id"]          , name: "index_tasks_on_taskable_type_and_taskable_id"          , using: :btree)
  add_index(t, "tasks"          , ["tenant_id"]          , name: "index_tasks_on_tenant_id"          , using: :btree)
  add_index(t, "tasks"          , ["user_calendar_entry_id"          , "assigned_user_calendar_entry_id"]          , name: "index_tasks_on_entry_id"          , using: :btree)
  add_index(t, "tasks"          , ["user_id"]          , name: "index_tasks_on_user_id"          , using: :btree)

  t = add_table({ table: :tenants, force: :cascade, columns: [
    { column: :name          ,                                         limit: 255 },
    { column: :number          ,                                       limit: 255 },
    { column: :printsmith_ip          ,                                limit: 255 },
    { column: :printsmith_username          ,                          limit: 255 },
    { column: :printsmith_password          ,                          limit: 255 },
    { column: :created_at          ,                                               type: :datetime },
    { column: :updated_at          ,                                               type: :datetime },
    { column: :printsmith_database          ,                          limit: 255 },
    { column: :inital_import_complete          ,                                                            default: false },
    { column: :allow_access },
    { column: :disable_import },
    { column: :time_zone          ,                                                                         default: "UTC" },
    { column: :state          ,                                        limit: 255 },
    { column: :connection_success_counter          ,                                                        default: 0                                            , type: :integer },
    { column: :connection_failure_counter          ,                                                        default: 0                                            , type: :integer },
    { column: :last_connection_failure_at          ,                               type: :datetime },
    { column: :connection_status },
    { column: :financial_year_start_day          ,                                                          default: 1                                            , type: :integer },
    { column: :financial_year_start_month          ,                                                        default: 1                                            , type: :integer },
    { column: :financial_year_end_day          ,                                                            default: 31                                           , type: :integer },
    { column: :financial_year_end_month          ,                                                          default: 12                                           , type: :integer },
    { column: :estimate_name },
    { column: :ngrok          ,                                                                             default: false },
    { column: :printsmith_port                                            , type: :integer },
    { column: :report_url },
    { column: :invoice_name },
    { column: :ngrok_authtoken },
    { column: :ngrok_remote_addr },
    { column: :ngrok_uuid },
    { column: :s3_region                                        , type: :text },
    { column: :s3_bucket                                        , type: :text },
    { column: :s3_access_key                                        , type: :text },
    { column: :s3_client_secret                                       , type: :text },
    { column: :estimate_views          ,                                                                    default: 0                                            , type: :integer },
    { column: :wanted_by_adjustments          ,                                                             default: 0                                            , type: :integer },
    { column: :needs_backup },
    { column: :multi_location          ,                                                                    default: false },
    { column: :taken_by_for_locations          ,                                                            default: false },
    { column: :sales_rep_for_locations          ,                                                           default: false },
    { column: :training          ,                                                                          default: false },
    { column: :beta_tester },
    { column: :printsmith_version },
    { column: :address_1 },
    { column: :address_2 },
    { column: :suburb },
    { column: :postcode },
    { column: :phone },
    { column: :email_marketing },
    { column: :contact_name },
    { column: :business_hours                                       , type: :text },
    { column: :pgdump_path                                        , type: :text },
    { column: :backup_path                                        , type: :text },
    { column: :local_path                                       , type: :text },
    { column: :last_accounting_month                                            , type: :integer },
    { column: :last_accounting_year                                           , type: :integer },
    { column: :marketing_unsubscribe_source_id                                            , type: :integer },
    { column: :default_email_to_test_send          ,                                                        default: true },
    { column: :display_month_first          ,                                                               default: false },
    { column: :estimate_email_template                                            , type: :integer },
    { column: :sale_email_template                                            , type: :integer },
    { column: :order_email_template                                           , type: :integer },
    { column: :contact_email_template                                           , type: :integer },
    { column: :enterprise_id                                            , type: :integer },
    { column: :ngrok_needs_restart },
    { column: :most_recent_monthly_closeout_date                    , type: :date },
    { column: :company_email_template                                           , type: :integer },
    { column: :hide_from_ladders          ,                                                                 default: false },
    { column: :show_cogs          ,                                                                         default: true },
    { column: :campaign_min_resend_days          ,                                                          default: 25                                           , type: :integer },
    { column: :cog_green_threshold          ,                                      type: :decimal          , default: 30.0 },
    { column: :cog_orange_threshold          ,                                     type: :decimal          , default: 70.0 },
    { column: :ngrok_version },
    { column: :ngrok_tcp_online          ,                                                                  default: false },
    { column: :ngrok_http_online          ,                                                                 default: false },
    { column: :week_start          ,                                                                        default: true },
    { column: :allow_production_features_on_staging          ,                                              default: false },
    { column: :campaign_monitor_client_id                                       , type: :text },
    { column: :website },
    { column: :wanted_days          ,                                                                       default: 1                                            , type: :integer },
    { column: :email_blacklist                                        , type: :text },
    { column: :tenant_picker_name },
    { column: :marketing_name },
    { column: :ngrok_crt                                        , type: :text },
    { column: :ngrok_key                                        , type: :text },
    { column: :demo          ,                                                                              default: false },
    { column: :printsmith_api_token },
    { column: :exclude_non_sales          ,                                                                 default: true },
    { column: :estimate_name_list },
    { column: :invoice_name_list },
    { column: :estimate_name_default },
    { column: :invoice_name_default },
    { column: :printsmith_api_version },
    { column: :estimate_name_enforce          ,                                                             default: false },
    { column: :invoice_name_enforce          ,                                                              default: false },
    { column: :test_email },
    { column: :enforce_old_printsmith_api          ,                                                        default: false },
    { column: :banner_id                                            , type: :integer },
    { column: :holiday_last_day },
    { column: :holiday_returning },
    { column: :show_company_tags          ,                                                                 default: true },
    { column: :show_contacts_tags          ,                                                                default: true },
    { column: :show_estimates_tags          ,                                                               default: true },
    { column: :show_orders_tags          ,                                                                  default: true },
    { column: :show_sales_tags          ,                                                                   default: true },
    { column: :website_url },
    { column: :request_quote_url },
    { column: :last_sales_report_start },
    { column: :last_sales_report_finish },
    { column: :monitor_counters                        ,                                                                  default: {}                                , type: :jsonb },
    { column: :facebook },
    { column: :twitter },
    { column: :instagram },
    { column: :pinterest },
    { column: :printsmith_local_port          ,                                                             default: "5432" },
    { column: :review_url },
    { column: :account_history_trigger          ,                                                           default: true },
    { column: :portal_estimate_comment_template_id                                            , type: :integer },
    { column: :portal_estimate_approved_template_id                                           , type: :integer },
    { column: :portal_estimate_canceled_template_id                                           , type: :integer },
    { column: :owner_open_date },
    { column: :use_complex_cost          ,                                                                  default: false },
    { column: :use_smtp          ,                                                                          default: false },
    { column: :lead_sources },
    { column: :statement_template_name                                        , type: :text },
    { column: :statement_template                                       , type: :text },
    { column: :pay_url },
    { column: :auto_self_bcc          ,                                                                     default: false },
    { column: :reorder_days          ,                                                                      default: 1                                            , type: :integer },
    { column: :use_sms },
    { column: :sms_send_number },
    { column: :show_sales          ,                                                                        default: false },
    { column: :job_titles },
    { column: :budget_lock          ,                                                                       default: false },
    { column: :lead_to_psv },
    { column: :s3_key_created },
    { column: :backup_api_key },
    { column: :show_inquiries          ,                                                                    default: false },
    { column: :default_inquiry_user_id                                            , type: :integer },
    { column: :allow_email_validation          ,                                                            default: false },
    { column: :inquiry_email_template                                           , type: :integer },
    { column: :blog },
    { column: :linked_in },
    { column: :inquiry_auto_assign_estimate          ,                                                      default: true },
    { column: :portal_proof_comment_template_id                                           , type: :integer },
    { column: :portal_proof_approved_template_id                                            , type: :integer },
    { column: :portal_proof_approved_production_location_id                                           , type: :integer },
    { column: :portal_proof_amended_production_location_id                                            , type: :integer },
    { column: :show_lead_types          ,                                                                   default: false },
    { column: :use_new_lead },
    { column: :default_lead_type_id                                           , type: :integer },
    { column: :mbe_refresh_token },
    { column: :mbe_refresh_token_expire_at },
    { column: :mbe_access_token },
    { column: :mbe_access_token_expire_at },
    { column: :mbe_tenant_id },
    { column: :mbe_multistore_id },
    { column: :mbe_store_id },
    { column: :address_3 },
    { column: :mbe_username },
    { column: :mbe_password },
    { column: :source_created_at },
    { column: :source_updated_at },
    { column: :mbe_api_base_url },
    { column: :mbe_api_basic_auth_token },
    { column: :shipment_email_template                                            , type: :integer },
    { column: :inquiry_notifications                                            , type: :jsonb },
    { column: :youtube },
    { column: :show_shipments_tags          ,                                                               default: true },
    { column: :show_inquiries_tags          ,                                                               default: true }
    ] } )

  add_index(t, "tenants"          , ["enterprise_id"]          , name: "index_tenants_on_enterprise_id"          , using: :btree)
  add_index(t, "tenants"          , ["id"          , "inital_import_complete"]          , name: "tenant_id"          , using: :btree)

  t = add_table({ table: :tokens, force: :cascade, columns: [
    { column: :user_id                                            , type: :integer },
    { column: :tenant_id                                            , type: :integer },
    { column: :access_token          ,               limit: 255 },
    { column: :refresh_token          ,              limit: 255 },
    { column: :expires_at          ,                             type: :datetime },
    { column: :created_at          ,                             type: :datetime },
    { column: :updated_at          ,                             type: :datetime },
    { column: :sync_token },
    { column: :gmail_sync_token },
    { column: :gmail_history_id },
    { column: :encrypted_access_token },
    { column: :encrypted_access_token_iv },
    { column: :encrypted_refresh_token },
    { column: :encrypted_refresh_token_iv }
    ] } )

  add_index(t, "tokens"          , ["tenant_id"]          , name: "index_tokens_on_tenant_id"          , using: :btree)
  add_index(t, "tokens"          , ["user_id"]          , name: "index_tokens_on_user_id"          , using: :btree)

  t = add_table({ table: :tracker_hits, force: :cascade, columns: [
    { column: :tracker_id                                           , type: :integer },
    { column: :created_at          ,     type: :datetime          , null: false },
    { column: :updated_at          ,     type: :datetime          , null: false },
    { column: :user_agent                                       , type: :text },
    { column: :referer                                        , type: :text },
    { column: :bot },
    { column: :browser_modern },
    { column: :browser },
    { column: :device },
    { column: :platform }
    ] } )

  add_index(t, "tracker_hits"          , ["tracker_id"]          , name: "index_tracker_hits_on_tracker_id"          , using: :btree)

  t = add_table({ table: :trackers, force: :cascade, columns: [
    { column: :uuid                                       , type: :text },
    { column: :method                                           , type: :integer },
    { column: :path                                       , type: :text },
    { column: :created_at          , type: :datetime          , null: false },
    { column: :updated_at          , type: :datetime          , null: false }
    ] } )

  add_index(t, "trackers"          , ["uuid"]          , name: "index_trackers_on_uuid"          , using: :btree)

  t = add_table({ table: :unsubscribes, force: :cascade, columns: [
    { column: :tenant_id                                            , type: :integer },
    { column: :contact_id                                           , type: :integer },
    { column: :unsub_type },
    { column: :email },
    { column: :data                        ,             default: {}                               , type: :jsonb },
    { column: :fixed          ,            default: false },
    { column: :fixed_by_user_id                                           , type: :integer },
    { column: :created_at },
    { column: :updated_at }
    ] } )

  add_index(t, "unsubscribes"          , ["contact_id"          , "unsub_type"          , "email"]          , name: "index_unsubscribes_contact_new_email"          , where: "((unsub_type)::text = ANY (ARRAY[('hard_bounce'::character varying)::text          , ('suppression_list'::character varying)::text]))"          , using: :btree)
  add_index(t, "unsubscribes"          , ["tenant_id"          , "contact_id"          , "unsub_type"          , "email"          , "fixed"]          , name: "index_unsubscribes_tenant_contact_type_email_fixed"          , where: "(fixed = false)"          , using: :btree)
  add_index(t, "unsubscribes"          , ["tenant_id"          , "contact_id"          , "unsub_type"          , "email"          , "fixed"]          , name: "index_unsubscribes_tenant_contact_type_email_not_fixed"          , where: "(fixed = true)"          , using: :btree)

  t = add_table({ table: :users, force: :cascade, columns: [
    { column: :manual_email          ,                limit: 255          ,               default: "" },
    { column: :encrypted_password          ,          limit: 255          ,               default: ""          ,    null: false },
    { column: :reset_password_token          ,        limit: 255 },
    { column: :reset_password_sent_at          ,                  type: :datetime },
    { column: :remember_created_at          ,                     type: :datetime },
    { column: :sign_in_count          ,                                         default: 0                                            , type: :integer },
    { column: :current_sign_in_at          ,                      type: :datetime },
    { column: :last_sign_in_at          ,                         type: :datetime },
    { column: :current_sign_in_ip          ,          limit: 255 },
    { column: :last_sign_in_ip          ,             limit: 255 },
    { column: :created_at          ,                              type: :datetime },
    { column: :updated_at          ,                              type: :datetime },
    { column: :username          ,                    limit: 255 },
    { column: :first_name          ,                  limit: 255 },
    { column: :last_name          ,                   limit: 255 },
    { column: :roles_mask                                           , type: :integer },
    { column: :gmail_username          ,              limit: 255 },
    { column: :gmail_password          ,              limit: 255 },
    { column: :test_email          ,                  limit: 255 },
    { column: :email_signature                                        , type: :text },
    { column: :settings              , type: :hstore },
    { column: :hide          ,                                                  default: false },
    { column: :role },
    { column: :deleted_at },
    { column: :task_calendar_color                                            , type: :integer },
    { column: :display_name },
    { column: :api_token },
    { column: :ip_whitelist },
    { column: :sash_id                                            , type: :integer },
    { column: :level          ,                                                 default: 0                                            , type: :integer },
    { column: :current_date_for_ui                    , type: :date },
    { column: :marketing_calendar_events          ,                             default: false },
    { column: :eula_accepted_at },
    { column: :default_alias },
    { column: :enterprise_id                                            , type: :integer },
    { column: :banner_id                                            , type: :integer },
    { column: :phone },
    { column: :lock_sales_rep          ,                                        default: false },
    { column: :add_task_to_my_calendar          ,                               default: false },
    { column: :smtp_server },
    { column: :smtp_port                                            , type: :integer },
    { column: :smtp_username },
    { column: :smtp_password },
    { column: :hide_reports          ,                                          default: false },
    { column: :email_notifications },
    { column: :sms_test_number },
    { column: :last_token_refresh_time },
    { column: :failed_attempts          ,                                       default: 0          ,     null: false                                           , type: :integer },
    { column: :unlock_token },
    { column: :locked_at },
    { column: :external_id },
    { column: :mbe_access_token                                       , type: :text },
    { column: :mbe_refresh_token                                        , type: :text },
    { column: :mbe_refresh_token_expire_at },
    { column: :platform_id },
    { column: :platform_data                                            , type: :jsonb },
    { column: :sso_onboarding }
    ] } )

  add_index(t, "users"          , ["deleted_at"]          , name: "index_users_on_deleted_at"          , using: :btree)
  add_index(t, "users"          , ["enterprise_id"]          , name: "index_users_on_enterprise_id"          , using: :btree)
  add_index(t, "users"          , ["external_id"]          , name: "index_users_on_external_id"          , unique: true          , using: :btree)
  add_index(t, "users"          , ["reset_password_token"]          , name: "index_users_on_reset_password_token"          , unique: true          , using: :btree)
  add_index(t, "users"          , ["unlock_token"]          , name: "index_users_on_unlock_token"          , unique: true          , using: :btree)
  add_index(t, "users"          , ["username"]          , name: "index_users_on_username"          , unique: true          , using: :btree)

  t = add_table({ table: :workflows, force: :cascade, columns: [
    { column: :name },
    { column: :company_id                                           , type: :integer },
    { column: :user_id          ,                       null: false                                           , type: :integer },
    { column: :global          ,        default: false },
    { column: :site_wide          ,     default: false },
    { column: :tenant_id                                            , type: :integer },
    { column: :enterprise_id          ,                 null: false                                           , type: :integer },
    { column: :created_at          ,                    null: false },
    { column: :updated_at          ,                    null: false }
    ] } )

  add_index(t, "workflows"          , ["company_id"]          , name: "index_workflows_on_company_id"          , using: :btree)
  add_index(t, "workflows"          , ["tenant_id"]          , name: "index_workflows_on_tenant_id"          , using: :btree)

  # add_foreign_key "calendar_entries"          , "calendars"          , name: "calendar_entries_calendar_id_fkey"          , on_update: :cascade          , on_delete: :cascade
  # add_foreign_key "enterprise_salestargets"          , "enterprises"
  # add_foreign_key "enterprise_salestargets"          , "prospect_statuses"
  # add_foreign_key "groups"          , "enterprises"
  # add_foreign_key "inquiries"          , "tenants"
  # add_foreign_key "inquiry_attachments"          , "inquiries"
  # add_foreign_key "invoices"          , "invoices"          , column: "sale_id"
  # add_foreign_key "locations"          , "tenants"
  # add_foreign_key "news"          , "enterprises"
  # add_foreign_key "next_activities"          , "tenants"
  # add_foreign_key "prospect_status_item_contacts"          , "contacts"
  # add_foreign_key "prospect_status_item_contacts"          , "prospect_status_items"
  # add_foreign_key "prospect_status_item_contacts"          , "tenants"
  # add_foreign_key "report_rows"          , "reports"
  # add_foreign_key "sales_tag_by_months"          , "tenants"
  # add_foreign_key "salestargets"          , "tenants"
  # add_foreign_key "tags"          , "tenants"
  # add_foreign_key "tags"          , "users"
  # add_foreign_key "users"          , "enterprises"
