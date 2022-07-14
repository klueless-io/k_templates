# frozen_string_literal: true

# Application Settings - Provide access to settings that may differ in different environments
#
# see: config/klue-settings.yml
class AppSettings
  # Some Value
  SOME_VALUE = Rails.configuration.settings["some_key"]
end
