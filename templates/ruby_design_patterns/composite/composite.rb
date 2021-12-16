# frozen_string_literal: true

module {{namespace}}
  # Composite Design Pattern: https://refactoring.guru/design-patterns/composite
  module {{camel name}}
    # Parent allows upwards navigation to parent {{children_name}}
    attr_reader :parent

    # {{titleize children_name_plural}} allow downwards navigation plus access to sub-{{children_name_plural}}
    attr_reader :{{children_name_plural}}

    def attach_parent(parent)
      @parent = parent
    end

    def navigate_parent
      parent.nil? ? self : parent
    end

    def root?
      parent.nil?
    end

    # Implement as needed (Implement is not provided here because you may want to use hash or array and have additional logic)
    # def reset_{{children_name_plural}}
    # end
    # def add_{{children_name}}
    # end
    # def remove_{{children_name}}
    # end
    # def get_{{children_name_plural}}
    # end
    # def has_{{children_name}}?
    # end
    # def execute
    # end
  end
end
