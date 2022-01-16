# frozen_string_literal: true

require '{{dom.application_lib_path}}/version'

{{#each dom.namespaces}}
module {{.}}
{{/each}}
  # raise {{dom.application_lib_namespace}}::Error, 'Sample message'
  class Error < StandardError; end
  
  # Your code goes here...
{{#each dom.namespaces}}
end
{{/each}}

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = '{{camelU dom.application}}::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('{{dom.application_lib_path}}/version') }
  version   = {{camelU dom.application}}::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end


