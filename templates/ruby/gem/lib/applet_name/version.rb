# frozen_string_literal: true

{{#each dom.namespaces}}
module {{.}}
{{/each}}
  VERSION = '{{dom.initial_semver}}'
{{#each dom.namespaces}}
end
{{/each}}
