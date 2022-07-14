class Schema{{camelU ./klass_name}}
  {{#each schema.tables}}
  table :{{./name}},
        model_name: :{{./model_name}},
        model_name_plural: :{{./name}}{{#if ./id}},
        id: {{./id}}{{/if}}{{#if ./primary_key}},
        primary_key: '{{./primary_key}}'{{/if}},
        column_count: {{./column_count}} do
  {{#if ../show_columns}}{{#each columns}}
    column :{{padr ./name 40}}{{/each}}{{/if}}
  end

  {{/each}}
end
