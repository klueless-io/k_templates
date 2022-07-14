{{#*inline "key_value"}}{{#if value}}, {{key}}: {{{value}}}{{/if}}{{/inline}}
{{#*inline "quoted_key_value"}}{{#if value}}, {{key}}: "{{{value}}}"{{/if}}{{/inline}}
# frozen_string_literal: true

class CreateIndexes < ActiveRecord::Migration[7.0]
  def change
{{#each indexes}}  
    add_index "{{table_name}}", %w[{{#each fields}}{{#if @first}}{{^}} {{/if}}{{.}}{{/each}}], name: "{{name}}"{{> key_value key='using' value=this.using }}{{> key_value key='unique' value=this.unique }}{{> quoted_key_value key='where' value=this.where }}
{{/each}}
  end
end
