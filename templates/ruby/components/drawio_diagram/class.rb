# frozen_string_literal: true
{{#each model.namespaces}}
module {{camel .}}
{{/each}}

  # {{titleize model.name}}
  class {{camel model.name}}
{{#each model.fields}}    attr_accessor :{{./name}}
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
