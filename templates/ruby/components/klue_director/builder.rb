# frozen_string_literal: true

{{#each dom.namespaces}}module {{camel .}}
{{/each}}
  class {{camel dom.name}}Builder
    attr_reader :dom

    def initialize
      @dom = {
{{#each dom.builder_nodes}}
        {{./name}}: {}{{#if @last}}{{^}},{{/if}}
{{/each}}
      }
    end

    {{#each dom.builder_nodes}}
    def {{./name}}
      dom << { name: name }
  
      self
    end
    {{/each}}
  end
{{#each dom.namespaces}}end
{{/each}}
