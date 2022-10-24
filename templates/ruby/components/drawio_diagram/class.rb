# frozen_string_literal: true
{{#each model.namespaces}}
module {{camel .}}
{{/each}}

  # {{titleize model.name}}{{#if model.description}}
  #
  # {{model.description}}{{/if}}
  class {{camel model.name}}{{#if model.dry_struct}} < Dry::Struct{{/if}}
{{#each model.fields}}    {{#if ../model.dry_struct}}attribute :{{padr ./name 30}} , {{{./return_type}}}{{^}}attr_accessor :{{./name}}{{/if}}
{{/each}}
    
    def initialize
    end

{{#each model.methods}}    def {{./name}}
    end
{{/each}}
  end

{{#each model.namespaces}}
end
{{/each}}
