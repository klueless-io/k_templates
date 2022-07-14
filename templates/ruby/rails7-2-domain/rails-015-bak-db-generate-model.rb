# frozen_string_literal: true

# rails generate model {{camel entity.name}} {{#each entity.columns}}{{#if (eq db_type 'primary_key')}}{{else}}{{snake this.name}}:{{this.db_type}} {{/if}}{{/each}} --no-test-framework
class Create{{camel entity.name}} < ActiveRecord::Migration[7.0]
  def change
    create_table :{{snake entity.name_plural}} do |t|
{{#each entity.rows_fields_and_fk}}
{{#if (eq this.db_type 'references')}}
      t.{{padr this.db_type 50}} :{{snake this.reference_table}}, foreign_key: true
{{else}}
{{/if}}
{{/each}}
{{#each entity.columns_data_foreign}}
      t.{{padr this.db_type 10}} :{{padr (snake this.name) 40}}{{#if this.precision}}, precision: {{this.precision}}{{/if}}{{#if this.scale}}, scale: {{this.scale}}{{/if}}{{#if this.limit}}, limit: {{this.limit}}{{/if}}{{#if this.format_default}}, default: {{{this.format_default}}}{{/if}}{{#if this.format_null}}, null: {{this.format_null}}{{/if}}{{#if this.format_array}}, array: {{this.format_array}}{{/if}}
{{/each}}

      t.timestamps
    end
  end
end
