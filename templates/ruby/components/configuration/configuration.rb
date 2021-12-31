# frozen_string_literal: true

# Usage: include {{#each dom.namespaces}}{{.}}::{{/each}}Configuration.new

{{#each dom.namespaces}}module {{.}}
{{/each}}
  # Configuration object for all k_builder* GEM
  class Configuration
    include KLog::Logging

{{#each dom.config_keys}}    attr_accessor :{{./name}}
{{/each}}

    def initialize
{{#each dom.config_keys}}      @{{./name}} = {{{./default_value}}}
{{/each}}
    end

    def debug(heading: '{{humanize dom.name}} configuration')
      log.section_heading heading if heading
    
{{#each dom.config_keys}}      log.kv '{{./name}}', {{./name}}
{{/each}}
      ''
    end

    def to_h
      {
{{#each dom.config_keys}}        {{./name}}: {{./name}}{{#if @last}}{{else}},{{/if}}
{{/each}}
      }
    end
  end
{{#each dom.namespaces}}end
{{/each}}
