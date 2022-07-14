{{#*inline "related_values_tabular"}}
{{#each relations}}{{#if ./related_entity}}, "{{snake this.related_entity.name}}.{{snake this.related_entity.main_key}}"{{/if}}{{/each}}
{{/inline}}
{{#*inline "related_values"}}
{{#if relations}}

# {{title}}
  {{#each relations}}
    {{#if ./related_entity}}
if row.{{snake this.related_entity.name}}
      {{#if ./related_entity.main_key}}
  log.kv "{{snake this.related_entity.name}} > {{snake this.related_entity.main_key}}", row.{{snake this.related_entity.name}}.{{snake this.related_entity.main_key}} if row.{{snake this.related_entity.name}}.{{snake this.related_entity.main_key}}
      {{^}}
  log.kv "{{snake this.related_entity.name}}_id", row.{{snake this.related_entity.name}}.id if row.{{snake this.related_entity.name}}_id
      {{/if}}
end
    {{^}}
# Missing related entity reference: {{this.name}}
    {{/if}}
  {{/each}}
{{/if}}
{{/inline}}
# frozen_string_literal: true

# Print helpers for {{camel entity.name_plural}}
module Printer
  def print_{{snake entity.name_plural}}(rows = nil, format: :default)
    log.section_heading "{{camel entity.name_plural}}"

    rows = {{camel entity.model_name}}.unscoped.all if rows.nil?

    rows.each do |row|
      print_{{snake entity.model_name}}_detailed(row) if format == :detailed
      print_{{snake entity.model_name}}(row) if format == :default
    end
  end

  def print_{{snake entity.name_plural}}_as_table(rows = nil, format: :default)
    log.section_heading "{{camel entity.name_plural}}"

    rows = {{camel entity.model_name}}.unscoped.all if rows.nil?

    tp rows{{#each entity.columns_primary}}, :{{snake this.name}}{{/each}}{{#each entity.has_one}}, '{{snake this.name}}.{{snake this.related_entity.main_key}}'{{/each}}{{#each entity.columns_data}}, :{{snake this.name}}{{/each}}{{> related_values_tabular relations=entity.belongs_to}}
  end

  def print_{{snake entity.model_name}}(row)
    {{#each entity.columns_data_primary}}
    log.kv "{{snake this.name}}", row.{{snake this.name}}
    {{/each}}
    {{> related_values relations=entity.belongs_to title='Belongs to relationships'}}
    {{> related_values relations=entity.has_one title='Has one relationships'}}

    log.line
  end

  def print_{{snake entity.model_name}}_detailed(row)
    {{#each entity.columns}}
    log.kv "{{snake this.name}}", row.{{snake this.name}}
    {{/each}}
    {{> related_values relations=entity.belongs_to title='Belongs to relationships'}}
    {{> related_values relations=entity.has_one title='Has one relationships'}}

    log.line
  end
end
