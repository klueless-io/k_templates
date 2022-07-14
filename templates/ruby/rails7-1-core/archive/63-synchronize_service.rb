# frozen_string_literal: true

# SynchronizeService will synchronize data from google spreadsheets to the main database
class SynchronizeService
  DEFAULT_SOURCE = "production"

  # --------------------------------------------------------------------------------
  # Synchronize ({{titleize (humanize settings.Application)}}) data
  # --------------------------------------------------------------------------------

{{#each entities}}
  def self.{{snake this.name_plural}}(sync: false, reset_table: false, spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME, worksheet_name: "{{dashify this.model_name}}", source_key: DEFAULT_SOURCE)
    bulk_upsert = BulkUpsert::{{camelU this.model_name}}BulkUpsert.new

    upsert(bulk_upsert, sync, reset_table, spreadsheet_name, worksheet_name, source_key)
  end

{{/each}}
  # rubocop:disable Metrics/ParameterLists
  def self.upsert(bulk_upsert, sync, reset_table, spreadsheet_name, worksheet_name, source_key)
    bulk_upsert.destroy_and_resequence_table if reset_table

    bulk_upsert.sync(spreadsheet_name: spreadsheet_name, worksheet_name: worksheet_name, source_key: source_key) if sync
  end
  # rubocop:enable Metrics/ParameterLists
end
