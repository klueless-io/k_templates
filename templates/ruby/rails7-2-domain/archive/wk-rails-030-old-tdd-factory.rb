# frozen_string_literal: true

# ---------------------------------------------
# Factory for {{camel entity.name_plural}}
# ---------------------------------------------
FactoryBot.define do
    # Test data creation helpers can be found here: spec/helpers/td/td_{{snake entity.model_name}}.rb
    factory :{{snake entity.model_name}} do

      trait :{{snake settings.td_key1}} do
{{#each entity.columns}}
        {{#if (eq db_type 'jsonb')}}
        {{snake this.name}} {  { a: 'A - {{this.name}}' } }
        {{else if (eq type 'string')}}
{{#includes ../../../settings.model_type (array 'admin_user' 'basic_user')}}
        {{snake this.name}} { '{{snake ../../../../settings.td_key1}}@email.com' }
        password { 'password' }
{{else if (eq name ../../../../settings.main_key)}}
        {{snake this.name}} { '{{snake ../../../../../settings.td_key1}}' }
{{else}}
        {{snake this.name}} { 'A - {{this.name}}' }
{{/includes}}
        {{else if (eq type 'integer')}}
        {{snake this.name}} { 1111 }
        {{else if (eq type 'Float')}}
        {{snake this.name}} { 1.1 }
        {{else if (eq type 'boolean')}}
        {{snake this.name}} { true }
        {{else if (eq type 'date')}}
        {{snake this.name}} { Date.parse '01 Jan 2017' }
        {{else if (eq type 'datetime')}}
        {{snake this.name}} { Date.parse '01 Jan 2017' }
  {{/if}}
  {{/each}}
      end

      trait :{{snake settings.td_key2}} do
{{#each entity.columns}}
        {{#if this.db_type '==' 'jsonb'}}
        {{snake this.name}} {  { a: 'B - {{this.name}}' } }
        {{else if (eq type 'string')}}
{{#includes ../../../settings.model_type (array 'admin_user' 'basic_user')}}
        {{snake this.name}} { '{{snake ../../../../settings.td_key2}}@email.com' }
        password { 'password' }
{{else if (eq name ../../../../settings.main_key)}}
        {{snake this.name}} { '{{snake ../../../../../settings.td_key2}}' }
{{else}}
        {{snake this.name}} { 'B - {{this.name}}' }
{{/includes}}
        {{else if (eq type 'integer')}}
        {{snake this.name}} { 2222 }
        {{else if (eq type 'Float')}}
        {{snake this.name}} { 2.2 }
        {{else if (eq type 'boolean')}}
        {{snake this.name}} { false }
        {{else if (eq type 'date')}}
        {{snake this.name}} { Date.parse '01 Feb 2017' }
        {{else if (eq type 'datetime')}}
        {{snake this.name}} { Date.parse '01 Feb 2017' }
{{/if}}
{{/each}}
      end

      trait :{{snake settings.td_key3}} do
{{#each entity.columns}}
        {{#if this.db_type '==' 'jsonb'}}
        {{snake this.name}} {  { a: 'C - {{this.name}}' } }
        {{else if (eq type 'string')}}
{{#includes ../../../settings.model_type (array 'admin_user' 'basic_user')}}
        {{snake this.name}} { '{{snake ../../../../settings.td_key3}}@email.com' }
        password { 'password' }
{{else if (eq name ../../../../settings.main_key)}}
        {{snake this.name}} { '{{snake ../../../../../settings.td_key3}}' }
{{else}}
        {{snake this.name}} { 'C - {{this.name}}' }
{{/includes}}
        {{else if (eq type 'integer')}}
        {{snake this.name}} { 3333 }
        {{else if (eq type 'Float')}}
        {{snake this.name}} { 3.3 }
        {{else if (eq type 'boolean')}}
        {{snake this.name}} { true }
        {{else if (eq type 'date')}}
        {{snake this.name}} { Date.parse '01 March 2017' }
        {{else if (eq type 'datetime')}}
        {{snake this.name}} { Date.parse '01 March 2017' }
{{/if}}
{{/each}}
      end

      # ---------------------------------------------
      # Factory for {{camel entity.name_plural}} QUERY/Filter operations
      # ---------------------------------------------

      # Example Data Printout

      # ---------------------------------------------
  {{#each entity.td_query}}
      trait :query_{{snake ../entity.model_name}}_{{.}} do
  {{#each ../rows}}
        {{#if this.db_type '==' 'jsonb'}}
        {{snake this.name}} {  { a: '{{this.name}}' } }
        {{else if (eq type 'string')}}
        {{snake this.name}} { '{{snake this.name}}_{{../../../.}}{{#if this.format_type '==' 'email'}}@email.com{{/if}}' }
            {{#includes ../../../../settings.model_type (array 'admin_user' 'basic_user')}}
        password { 'password' }
            {{/includes}}
        {{else if (eq type 'integer')}}
        {{snake this.name}} { 1{{../../../../.}} }
        {{else if (eq type 'Float')}}
        {{snake this.name}} { 1{{../../../../../.}}.1 }
        {{else if (eq type 'boolean')}}
        {{snake this.name}} { {{tdd_boolean @../index}} }
        {{else if (eq type 'date')}}
        {{snake this.name}} { Date.parse '{{../../../../../../../.}} Jan 2017' }
        {{else if (eq type 'datetime')}}
        {{snake this.name}} { Date.parse '{{../../../../../../../../.}} Jan 2017' }
  {{/if}}
  {{/each}}
      end

  {{/each}}
    end
  end