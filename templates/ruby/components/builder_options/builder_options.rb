{{#*inline "option_groups"}}

  def {{name}}(active{{#each flags}}, {{.}}: 0{{/each}}{{#each params}}, {{.}}: ''{{/each}})
    active = active == true || active == 1

    {{#if flags}}
    # Flags
    {{#each flags}}
    {{.}} = active && ({{.}} == true || {{.}} == 1)
    {{/each}}
    {{/if}}

    @{{name}} = {
      active: active{{#each flags}},
      {{.}}: {{.}}{{/each}}{{#each params}},
      {{.}}: {{.}}{{/each}}
    }

    self
  end
{{/inline}}
{{#*inline "build_options"}}
  data = {
  {{#each dom.option_groups}}
    {{name}}: @{{name}}{{#if @last}}{{else}},{{/if}}
  {{/each}}
  }
  KUtil.data.to_open_struct(data)
{{/inline}}
# BuilderOptions is an object that you configure and alter as needed for dynamic code generation
#
# # How to use
# build_options = BuilderOptions.init
{{#each dom.option_groups}}
#   .{{name}}(1{{#each flags}}, {{.}}: 1{{/each}}{{#each params}}, {{.}}: '{{titleize .}}'{{/each}})
{{/each}}
# build_options.print # this will print debug information
#
# # Create an OpenStruct based on the configured build_options
# opts = build_options.build
class BuilderOptions
  class << self
    def init
      new
    end
  end
  {{#each dom.option_groups}}
{{> option_groups}}

  def {{name}}!
    OpenStruct.new(@{{name}})
  end
  {{/each}}

  def build
  {{> build_options}}
  end

  def print
    log.section_heading 'debug options'

    # log.open_struct(build)
    log.structure(build) # , graph: { filter: { names: { skip_empty: true } } })
  end
end
