# frozen_string_literal: true

{{#each entity.columns}}
{{#if (eq type 'foreign_key')}}
json.{{snake this.name}}_id row.{{snake this.name}}_id
{{else}}
json.{{snake this.name}} row.{{snake this.name}}
{{/if}}
{{/each}}

# json.created_at row.created_at
# json.updated_at row.updated_at
