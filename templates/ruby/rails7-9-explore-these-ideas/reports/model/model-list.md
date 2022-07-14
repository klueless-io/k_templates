# {{title}}

| model                                    | col# | status                         | column names |
|------------------------------------------|------|--------------------------------|--------------|
{{#each schema.tables}}
| {{#if model_rel_path}}[{{./name}}]({{./model_rel_path}}){{else}}{{./name}}{{/if}} | {{./column_count}} | {{./display_state}} | {{display_column_names}} |
{{/each}}
