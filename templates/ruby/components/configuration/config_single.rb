# frozen_string_literal: true

# Usage: include {{#each dom.namespaces}}{{.}}::{{/each}}

{{#each dom.namespaces}}module {{.}}
{{/each}}
  # Access configuration for {{titleize dom.name}}
  attr_writer :configuration

  def configuration
    @configuration ||= {{#each dom.namespaces}}{{.}}::{{/each}}Configuration.new
  end

  def reset
    @configuration = {{#each dom.namespaces}}{{.}}::{{/each}}Configuration.new
  end

  def configure
    yield(configuration)
  end
{{#each dom.namespaces}}end
{{/each}}
