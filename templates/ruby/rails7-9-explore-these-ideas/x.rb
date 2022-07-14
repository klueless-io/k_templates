# row :application_controller                  , :controller, [:cop_inspect], 'base controller has a bunch of helper methods and callbacks that are called automatically', 'add a simple unit tests for each method'

{{#each names}}
# row :{{padr ./name 40}}, :controller, :def, [:cop_inspect],  '{{titleize ./name}}'
{{/each}}
