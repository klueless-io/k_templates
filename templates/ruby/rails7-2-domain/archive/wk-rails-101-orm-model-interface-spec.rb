{{#*inline "make_value"}}
{{~#if (eq column.db_type 'jsonb')}}
{ a: "{{column.name}}" }
{{~else if (eq column.name settings.main_key)}}
"???"
{{~else if (eq column.type 'string')}}
"{{snake column.name}}{{alpha_suffix}}"
{{~else if (eq column.type 'text')}}
"{{snake column.name}}{{alpha_suffix}}"
{{~else if (eq column.type 'integer')}}
{{num}}
{{~else if (eq column.type 'float')}}
{{num}}.{{num}}
{{~else if (eq column.type 'decimal')}}
{{num}}.{{num}}
{{~else if (eq column.type 'boolean')}}
{{bool}}
{{~else if (eq column.type 'date')}}
Date.parse("0{{num}} Jan 2017")
{{~else if (eq column.type 'datetime')}}
Date.parse("0{{num}} Jan 2017")
{{/if}}
{{/inline}}
# frozen_string_literal: true

require {{{q}}}rails_helper{{{q}}}
require {{{q}}}spec_helper{{{q}}}

RSpec.describe {{camel entity.model_name}}, type: :model do
  include Refactor

  {{#if entity.rails_model.public_instance_methods}}
  describe "#public API methods" do
    {{#each entity.rails_model.public_instance_methods}}
    describe "#{{./name}}" do
      it { refactor(:ok) }
    end
    {{/each}}
  end

  {{/if}}
  {{#if entity.rails_model.public_class_methods}}
  describe "#public class methods" do
    {{#each entity.rails_model.public_class_methods}}
    describe "#{{./name}}" do
      it { refactor(:ok) }
    end
    {{/each}}
  end

  {{/if}}
end
