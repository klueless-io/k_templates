def models
  [
{{#each models}}
    { type: :model, name: :{{./name}}, name_plural: :{{pluralize ./name}} }{{#if @last}}{{else}},{{/if}}
{{/each}}
  ]
end