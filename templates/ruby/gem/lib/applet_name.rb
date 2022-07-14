# frozen_string_literal: true

require_relative '{{dom.application_lib_path}}/version'

{{#each dom.namespaces}}
module {{.}}
{{/each}}
  # raise {{dom.application_lib_namespace}}::Error, 'Sample message'
  Error = Class.new(StandardError)

  # Your code goes here...
{{#each dom.namespaces}}
end
{{/each}}

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = '{{camelU dom.application}}::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('{{dom.application_lib_path}}/version') }
  version   = {{camelU dom.application}}::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
