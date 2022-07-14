# frozen_string_literal: true

# Bulk update multiple rows using upsert from a google sheet data source
module BulkUpsert
  # Bulk upsert the {{camel entity.model_name}} table
  class {{camel entity.model_name}}BulkUpsert < BaseBulkUpsert
    def initialize
      super({{camel entity.model_name}})

      @can_destroy_table = true

      # Currently not used as this is for SQL bulk insert
      @conflict_keys = ["{{snake entity.main_key}}name"]
    end

    # Note, this is really a GSheet sync tool and as such probably should be named that way
    # Two required params would be name of google spreadsheet and name of actual sheet and name or filter key
    #
    # @param [String] source_key Defaults to "sample" and represents the type of data you would like to sync, e.g. produciton, sample, unit-test
    def sync(source_key: "production", spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME, worksheet_name: "{{dashify entity.model_name}}")
      reader = Gsheet::Reader::Gs{{camel entity.model_name}}Reader.new(spreadsheet_name, worksheet_name)

      reader.read

      self.source_rows = reader.get_filtered_rows(sample_key: source_key)

      # self.source_rows.each { |r| puts r.attributes}

      source_rows.each do |row|
{{#array_has_key_value rows 'db_type' 'jsonb'}}
{{#each rows_fields}}
  {{#if (eq db_type 'jsonb')}}
        if row.{{snake this.name}}.nil? || row.{{snake this.name}}.blank?
          row.{{snake this.name}} = { config: {} }
        end
  {{/if}}
{{/each}}
{{/array_has_key_value}}

        {{#if relations}}
        # Lookup relations that need to be looked up and attached to this object
        {{#each relations}}
        {{#if (eq type 'one_to_one')}}
        {{snake this.name}} = {{camel this.name}}.find_by({{snake this.main_key}}: row.sync_fk_{{snake this.name}})

        if {{snake this.name}}.nil?
          log.kv "{{camel this.name}} (not found)", row.sync_fk_{{snake this.name}}
        end

{{/if}}
{{/each}}
{{/if}}
        attributes = {
{{#each relations}}
{{#if (eq type 'one_to_one')}}
          {{snake this.name}}: {{snake this.name}},
{{/if}}
{{/each}}
{{#each rows_fields_and_virtual}}
          {{snake this.name}}: row.{{snake this.name}}{{#if @last}}{{else}},{{/if}}
{{/each}}
        }

{{#if settings.GsCutomLookup}}
        {{snake entity.model_name}} = {{settings.GsCutomLookup}}
{{else if settings.key.yes}}
        # Use GsCutomLookup if you want to customize this lookup
        {{snake entity.model_name}} = {{camel entity.model_name}}.find_by({{snake entity.main_key}}name: row.sync_{{snake entity.main_key}}name)
{{else}}
        # Use GsLookkupKeys and list keys that can be used as a composite key for finding unique {{camel entity.name_plural}}
        # {{snake entity.model_name}} = {{camel entity.model_name}}.find_by({{#each settings.GsLookkupKeys}}{{snake .}}: row.{{snake .}}{{#if @last}}{{else}}, {{/if}}{{/each}})
{{/if}}

        if {{snake entity.model_name}}.present?
          save(attributes, {{snake entity.model_name}})
        else
          save(attributes)
        end
      end
    end

    def save(attributes, {{snake entity.model_name}} = nil)
      is_create = {{snake entity.model_name}}.nil?

      if is_create
        {{snake entity.model_name}} = {{camel entity.model_name}}.new(attributes)
      else
        {{snake entity.model_name}}.update(attributes)
      end

      return if {{snake entity.model_name}}.save

      log.info "Could not #{is_create ? 'create' : 'update'} {{titleize entity.model_name}}"
      log.block {{snake entity.model_name}}.errors.full_messages
      log.kv "{{camel entity.main_key}}name", {{snake entity.model_name}}.{{snake entity.main_key}}name
      log.yaml attributes
    end
  end
end
