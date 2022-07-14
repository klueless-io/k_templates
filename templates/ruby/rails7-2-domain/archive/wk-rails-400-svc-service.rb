# frozen_string_literal: true

# {{camel entity.model_name}}Service provides light weight access to actions related to "{{titleize (humanize entity.model_name) }}'
#
# Use these service actions from your controllers, other business objects and state change events throughout the application
#
# Keep these actions simple, delegate any complex code to specialized classes or subsystems that can be called from these actions
#
# Patterns: Facade Pattern, Micro Service
class {{camel entity.model_name}}Service
  # --------------------------------------------------------------------------------
  # Service Actions
  # --------------------------------------------------------------------------------
  def self.some_action
    "light weight action"
  end
end
