# frozen_string_literal: true

{{#each require_paths}}
require_relative '{{.}}'
{{/each}}
