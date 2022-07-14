# frozen_string_literal: true

# Import all seed data into the database
module ImportDataRunAll
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/GuardClause
  def run_all
    settings = open_settings

{{#each entities}}
    # Import Sample/Seed data for {{titleize (humanize this.name_plural)}}
    if settings["{{snake this.model_name}}"] && settings["{{snake this.model_name}}"]["can_import"]
      L.heading "Import {{camelU this.model_name}}"
      {{snake this.name_plural}} = open("{{snake this.model_name}}.yaml")

      import_{{snake this.model_name}}({{snake this.name_plural}}) if {{snake this.name_plural}}.present?
    end{{#if @last}}{{else}}
{{/if}}

{{/each}}
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/GuardClause
end
