class DataDictionary
  def entities
    {{#each entities}}
    entity :{{padr ./name 40 }}, label: '{{./label}}'
    {{/each}}
  end

  def attributes
    # Format
    # No. of Entities
    # No. of Type Mismatches (1 is expected)
    # Attribute Name
    # Attribute Title
    # List of types, more than one means a mismatch
    # List of entities that the attribute is found on
    {{#each words}}
    attribute {{padl ./entity_count 3}}, {{padl ./type_count 3}}, :{{padr ./name 40 }}, segment: :{{padr ./segment 14 }}, label: '{{./label}}', types: [{{#each ./types}}:{{.}}{{#if @last}}{{else}}, {{/if}}{{/each}}], entities: [{{#each ./entities}}:{{.}}{{#if @last}}{{else}}, {{/if}}{{/each}}]
    {{/each}}
  end
end
