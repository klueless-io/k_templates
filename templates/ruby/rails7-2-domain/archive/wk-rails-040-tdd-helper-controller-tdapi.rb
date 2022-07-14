# frozen_string_literal: true

# Setup test data
module TestData
  # Test Data structure and mapper specifically for {{camel entity.model_name}} API V1

  # {{camel entity.model_name}} object that is returned by API V1 actions
  class TdApi{{camel entity.model_name}}Row
    include Virtus.model

    # def initialize(attributes)
    #   super(attributes)
    # end

    {{#each entity.columns}}
    {{#if (eq type 'boolean')}}
    attribute :{{snake this.name}}, Boolean
    {{else if (eq type 'primary_key')}}
    attribute :{{snake this.name}}, Integer
    {{else if (eq type 'foreign_key')}}
    attribute :{{snake this.name}}_id, Integer
    {{else if (eq type 'integer')}}
    attribute :{{snake this.name}}, Integer
    {{else if (eq type 'float')}}
    attribute :{{snake this.name}}, Float
    {{else if (eq type 'datetime')}}
    attribute :{{snake this.name}}, DateTime
    {{else}}
    attribute :{{snake this.name}}, String
{{/if}}
    {{/each}}

    # Map JSON row from API V1 actions to {{camel entity.model_name}}
    def self.map(data)
      return nil if data.blank?

      mapped = {
      {{#each entity.columns}}
      {{#if (eq this.type 'boolean')}}
        {{snake this.name}}: !data["{{snake this.name}}"].nil?{{#if @last}}{{else}},{{/if}}
      {{else if (eq this.type 'primary_key')}}
        {{snake this.name}}: data["{{snake this.name}}"].to_i{{#if @last}}{{else}},{{/if}}
      {{else if (eq this.type 'foreign_key')}}
        {{snake this.name}}_id: data['{{snake this.name}}_id'].to_i{{#if @last}}{{else}},{{/if}}
      {{else if (eq this.type 'integer')}}
        {{snake this.name}}: data["{{snake this.name}}"].to_i{{#if @last}}{{else}},{{/if}}
      {{else if (eq this.type 'float')}}
        {{snake this.name}}: data["{{snake this.name}}"].to_f{{#if @last}}{{else}},{{/if}}
      {{else if (eq this.type 'date')}}
        {{snake this.name}}: data["{{snake this.name}}"].try(:to_datetime){{#if @last}}{{else}},{{/if}}
      {{else if (eq this.type 'datetime')}}
        {{snake this.name}}: data["{{snake this.name}}"].try(:to_datetime){{#if @last}}{{else}},{{/if}}
      {{else}}
        {{snake this.name}}: data["{{snake this.name}}"]{{#if @last}}{{else}},{{/if}}
{{/if}}
      {{/each}}
      }

      TdApi{{camel entity.model_name}}Row.new(mapped)
    end
  end
end
