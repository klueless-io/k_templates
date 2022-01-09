# frozen_string_literal: true

{{#each dom.namespaces}}module {{camel .}}
{{/each}}
  # Composite Design Pattern: https://refactoring.guru/design-patterns/composite
  class {{camel dom.name}}Director
    class << self
      def init
        new
      end
    end

    include KLog::Logging

    attr_reader :build_dom

    # Parent allows upwards navigation to parent
    attr_reader :parent

{{#each dom.child_directors}}
    # {{titleize name_plural}} allow downwards navigation plus access to sub-{{name_plural}}
    attr_reader :{{./name_plural}}
{{/each}}

    def initialize(**opts)
      @on_exist = opts[:on_exist] || :skip # %i[skip write compare]

      @build_dom = {{#each dom.namespaces}}{{camel .}}{{#if @last}}{{^}}::{{/if}}{{/each}}::{{camel dom.name}}Builder.new
    end

    # Move into Base Class
    def attach_parent(parent)
      @parent = parent
    end

    def navigate_parent
      parent.nil? ? self : parent
    end

    def root?
      parent.nil?
    end

{{#each dom.child_directors}}
    # Implement as needed (Implement is not provided here because you may want to use hash or array and have additional logic)
    # def reset_{{./name_plural}}
    # end
    # def add_{{./name}}
    # end
    # def remove_{{./name}}
    # end
    # def get_{{./name_plural}}
    # end
    # def has_{{./name}}?
    # end
    # def execute
    # end
{{/each}}
  end
{{#each dom.namespaces}}end
{{/each}}
