# frozen_string_literal: true

{{#each dom.namespaces}}
module {{.}}
{{/each}}
  VERSION = '0.0.1'
{{#each dom.namespaces}}
end
{{/each}}
