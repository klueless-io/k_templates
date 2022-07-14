# frozen_string_literal: true

module SeedCommands
  class {{camel entity.model_name_plural}}
    def call
      puts 'create {{titleize entity.model_name_plural}}'

      skill_source = FactoryBot.create(:skill_source)
  end
end


{{#*inline "one_to_one_association"}}
association :{{model}}{{#key}}, :{{../key}}{{/key}}
{{/inline}}
# ---------------------------------------------
# Factory for {{camel entity.name_plural}}
# ---------------------------------------------
FactoryBot.define do
  # Test data creation helpers can be found here: spec/helpers/td/td_{{snake entity.model_name}}.rb
  factory :{{snake entity.model_name}} do
    initialize_with { {{camel entity.model_name}}.find_or_create_by({{snake entity.main_key}}: {{snake entity.main_key}}) }

{{#relations_one_to_one}}
    {{> one_to_one_association model=name}}
{{/relations_one_to_one}}

{{#includes settings.model_type (array 'admin_user' 'basic_user')}}
    email { 'person@email.com' }
    password { 'password' }
{{else}}
{{#each entity.columns}}
    {{> make_trait_key_value row=. settings=settings td_key="" alpha="" num=9 bool=true}}
{{/each}}
{{/includes}}

    # ---------------------------------------------
    # Traits for common use cases
    # ---------------------------------------------
{{#*inline "make_trait_key_value"}}
{{#if (eq db_type 'jsonb')}}
{{snake name}} {  { a: '{{alpha}}{{name}}' } }
{{else if (eq this.name settings.main_key)}}
{{snake this.name}} { '{{snake td_key}}' }
{{else if (eq type 'string')}}
{{snake name}} { '{{alpha}}{{name}}' }
{{else if (eq type 'integer')}}
{{snake name}} { {{num}}{{num}}{{num}}{{num}} }
{{else if (eq type 'Float')}}
{{snake name}} { {{num}}.{{num}} }
{{else if (eq type 'boolean')}}
{{snake name}} { {{bool}} }
{{else if (eq type 'date')}}
{{snake this.name}} { Date.parse '0{{num}} Jan 2017' }
{{else if (eq type 'datetime')}}
{{snake this.name}} { Date.parse '0{{num}} Jan 2017' }
{{/if}}
{{/inline}}
{{#*inline "make_trait"}}
    trait :{{snake td_key}} do
{{#relations_one_to_one}}
      {{> one_to_one_association model=name key=(lookup . ../child_key) }}
{{/relations_one_to_one}}

{{#includes settings.model_type (array 'admin_user' 'basic_user')}}
      email { '{{snake td_key}}@email.com' }
      password { 'password' }
{{else}}
{{#each entity.columns}}
      {{> make_trait_key_value row=. settings=../settings td_key=../td_key alpha=../alpha num=../num bool=../bool}}
{{/each}}
{{/includes}}
    end

{{/inline}}
{{> make_trait rows=rows settings=settings td_key=settings.td_key1 alpha="A - " num=1 bool=true  child_key='td_key1'}}
{{> make_trait rows=rows settings=settings td_key=settings.td_key2 alpha="B - " num=2 bool=false child_key='td_key2'}}
{{> make_trait rows=rows settings=settings td_key=settings.td_key3 alpha="C - " num=3 bool=true  child_key='td_key3'}}

    # ---------------------------------------------
    # Traits for {{camel entity.name_plural}} QUERY/Filter operations
    # ---------------------------------------------

{{#each entity.td_query}}
    trait :query_{{snake ../entity.model_name}}_{{.}} do
{{#each ../rows}}
{{#if (eq db_type 'jsonb')}}
      {{snake this.name}} {  { a: '{{this.name}}' } }
      {{else if (eq type 'string')}}
      {{snake this.name}} { '{{snake this.name}}_{{../.}}{{#if (eq format type 'email')}}@email.com{{/if}}' }
{{#includes ../../settings.model_type (array 'admin_user' 'basic_user')}}
      password { 'password' }
{{/includes}}
      {{else if (eq type 'integer')}}
      {{snake this.name}} { 1{{../.}} }
      {{else if (eq type 'Float')}}
      {{snake this.name}} { 1{{../.}}.1 }
      {{else if (eq type 'boolean')}}
      {{snake this.name}} { {{tdd_boolean @../index}} }
      {{else if (eq type 'date')}}
      {{snake this.name}} { Date.parse '{{../.}} Jan 2017' }
      {{else if (eq type 'datetime')}}
      {{snake this.name}} { Date.parse '{{../.}} Jan 2017' }
{{/if}}
{{/each}}
    end

{{/each}}
  end
end
