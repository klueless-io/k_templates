# frozen_string_literal: true

# Reset all seed data in the database
module ImportDataResetAll
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/GuardClause
  def reset_all
    settings = open_settings

    {{#each entities}}
    # Delete data for {{titleize (humanize this.name_plural)}}
    if settings["{{snake this.model_name}}"] && settings["{{snake this.model_name}}"]["can_reset"]
      L.kv "Delete", "{{camelU this.model_name}}"
      {{camelU this.model_name}}.delete_all
      PgUtil.execute_sql("alter sequence {{snake this.name_plural}}_id_seq restart with 1;")
    end{{#if @last}}{{else}}
{{/if}}

{{/each}}
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/GuardClause
end
