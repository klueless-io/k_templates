# frozen_string_literal: true

# Usage: include {{#each dom.namespaces}}{{.}}::{{/each}}

{{#each dom.namespaces}}module {{.}}
{{/each}}
  # Access named configurations for {{titleize dom.name}}
  attr_writer :configuration

  def configuration(name = :default)
    @configuration ||= Hash.new do |h, key|
      h[key] = {{#each dom.namespaces}}{{.}}::{{/each}}Configuration.new
    end
    @configuration[name]
  end

  def reset(name = :default)
    @configuration ||= Hash.new do |h, key|
      h[key] = {{#each dom.namespaces}}{{.}}::{{/each}}Configuration.new
    end
    @configuration[name] = {{#each dom.namespaces}}{{.}}::{{/each}}Configuration.new
  end

  def configure(name = :default)
    yield(configuration(name))
  end
{{#each dom.namespaces}}end
{{/each}}
