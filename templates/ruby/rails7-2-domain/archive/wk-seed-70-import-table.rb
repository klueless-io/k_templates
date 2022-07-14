# frozen_string_literal: true

# Import table data for {{titleize (humanize entity.name_plural)}}
module ImportTable
  def import_{{snake entity.model_name}}(rows)
    rows.each do |row|
      # {{snake entity.model_name}} = {{camel entity.model_name}}.find_by_{{snake entity.main_key}}name(row["{{snake entity.main_key}}name"])
      {{snake entity.model_name}} = {{camel entity.model_name}}
              .where({{snake entity.main_key}}name: row["{{snake entity.main_key}}name"])
      {{#each relations_one_to_one}}
              .joins(:{{snake this.name}}).where("{{snake this.name_plural}}.name = ?", row["{{snake this.name}}"])
        {{/each}}
              .first

      log.kv "{{snake entity.main_key}}name", row["{{snake entity.main_key}}name"]
{{#each relations_one_to_one}}
      log.kv "{{snake this.name}}", row["{{snake this.name}}"]
{{/each}}

      if {{snake entity.model_name}}
        log.kv "{{humanize entity.model_name}} found (skipped)", row["{{snake entity.main_key}}name"]
      else
        {{#each relations_one_to_one}}
        # Todo: currently does not handle duplicates gracefully, ie. you may not get the {{snake this.name}} you wanted
        {{snake this.name}} = {{camel this.name}}.find_by_name(row["{{snake this.name}}"])

        if {{snake this.name}}.nil?
          log.kv "ERROR: {{camel this.name}} not found", row["{{snake this.name}}"]
          next
        end

        row["{{snake this.name}}"] = {{snake this.name}}

{{/each}}
        {{camel entity.model_name}}.create!(row)
        log.kv "{{humanize entity.model_name}} added", row["{{snake entity.main_key}}name"]
      end
    end
  end
end
