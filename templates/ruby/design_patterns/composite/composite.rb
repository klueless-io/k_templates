# frozen_string_literal: true

{{#each dom.namespaces}}module {{.}}
{{/each}}
  # Composite Design Pattern: https://refactoring.guru/design-patterns/composite
  module {{camel dom.name}}
    # Parent allows upwards navigation to parent {{children_name}}
    attr_reader :parent

    # XMEN: {{{json dom.children}}}
{{#each dom.children}}
    # {{titleize name_plural}} allow downwards navigation plus access to sub-{{name_plural}}
    attr_reader :{{./name_plural}}
{{/each}}

    def attach_parent(parent)
      @parent = parent
    end

    def navigate_parent
      parent.nil? ? self : parent
    end

    def root?
      parent.nil?
    end

{{#each dom.children}}
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
