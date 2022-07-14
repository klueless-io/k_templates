# frozen_string_literal: true

module TestData
  # ---------------------------------------------
  # Setup Test Data for {{camel entity.name_plural}}
  # ---------------------------------------------

  # Factories can be found here: spec/factories/{{snake entity.name_plural}}.rb

  # Test data for CRUD (Model/Controller) tests or specific business use cases
  # TODO: Refactor
  def td_{{snake entity.name_plural}}
    @{{snake entity.name}}_{{snake entity.td_key1}} = FactoryBot.build(:{{snake entity.name}}, :{{snake entity.td_key1}}) # TODO: {{#if entity.has_one}}{{#entity.has_one}}, {{this.name}}: @{{this.name}}_{{snake td_key1}}{{/entity.has_one}}{{/if}})
    @{{snake entity.name}}_{{snake entity.td_key2}} = FactoryBot.build(:{{snake entity.name}}, :{{snake entity.td_key2}}) # TODO: {{#if entity.has_one}}{{#entity.has_one}}, {{this.name}}: @{{this.name}}_{{snake td_key2}}{{/entity.has_one}}{{/if}})
    @{{snake entity.name}}_{{snake entity.td_key3}} = FactoryBot.build(:{{snake entity.name}}, :{{snake entity.td_key3}}) # TODO: {{#if entity.has_one}}{{#entity.has_one}}, {{this.name}}: @{{this.name}}_{{snake td_key3}}{{/entity.has_one}}{{/if}})
  end

  # Test data for QUERY/Filter operations
  # TODO: Refactor
  def td_{{snake entity.name_plural}}_for_query
{{#each entity.td_query}}
    @query_{{snake ../entity.model_name}}_{{.}} = FactoryBot.build(:{{snake ../entity.model_name}}, :query_{{snake ../entity.model_name}}_{{.}}{{#if ../relations}}{{#each ../relations}}{{#if this.type '==' 'one_to_one'}}, {{this.name}}: @{{this.name}}_{{snake td_key1}}{{/if}}{{/each}}{{/if}})
{{/each}}
  end
end
