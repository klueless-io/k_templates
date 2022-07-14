# frozen_string_literal: true

# Opening up the application class and extending with settings
#
# Example Usage
# Rails.configuration.settings["some_key"]                     # Some Value
# Rails.configuration.settings["some_url"]                     # http://localhost:3030
# Rails.configuration.settings["some_folder"]                  # "/home/david/Dropbox/video-presentations/presentations"
#
# When to use these settings:
#
# If you just need a simple application setting that can be setup for multiple environments and
# is ok with only changing during development, staging or at time of release to production then
# this is the correct place to define a setting
#
# When NOT to use these settings:
#
# If you need a setting that can be turned on or by an administration end user and a data driven
# setting is needed then you are best of using some sort of database settings technique.
##
class Application < Rails::Application
  config.settings = config_for("klue-settings")
end
