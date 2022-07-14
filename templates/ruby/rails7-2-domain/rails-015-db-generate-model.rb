{{#*inline "key_value"}}{{#if value}}, {{key}}: {{{value}}}{{/if}}{{/inline}}
{{#*inline "field"}}
t.{{padr this.db_type 10}} :{{padr (snake this.name) 0}}{{> key_value key='precision' value=this.precision }}{{> key_value key='limit' value=this.limit }}{{> key_value key='scale' value=this.scale }}{{> key_value key='null' value=this.null_as_code }}{{> key_value key='default' value=this.default_as_code }}{{> key_value key='array' value=this.array_as_code }}
{{/inline}}

# frozen_string_literal: true

class Create{{camel entity.name}} < ActiveRecord::Migration[7.0]
  def change
    create_table :{{snake entity.name_plural}} do |t|
{{#each entity.columns.data_foreign}}  
      {{> field}}
{{/each}}
{{#if entity.create_update_timestamp}}      t.timestamps{{^}}      # no timestamp{{/if}}
    end
  end
end
