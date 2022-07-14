# frozen_string_literal: true
{{#*inline "one_to_one_association"}}
association :{{model}}{{#key}}, :{{../key}}{{/key}}
{{/inline}}
{{#*inline "column_name"}}{{#if (eq name 'method')}}{{padr 'add_attribute(:method)' padsize}}{{^}}{{padr (snake name) padsize }}{{/if}}{{/inline}}
FactoryBot.define do
  factory :{{snake entity.model_name}} do
{{#if (and false entity.has_one)}}
    # One to one associations
{{#entity.has_one}}
    {{> one_to_one_association model=name}}
{{/entity.has_one}}

{{/if}}
{{#each entity.columns_data}}
    {{> make_trait_key_value default=true column=. settings=settings td_key="" alpha="" num=9 bool=true padsize=40}}
{{/each}}
{{#*inline "make_trait_key_value"}}
{{#if (eq column.db_type 'jsonb')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ { a: "{{alpha}}{{column.name}}" } }
{{else if (eq column.name settings.main_key)}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ "{{snake td_key}}" }
{{else if (eq column.type 'text')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ "{{alpha}}{{titleize column.name}}" }
{{else if (eq column.type 'string')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ "{{alpha}}{{titleize column.name}}" }
{{else if (eq column.type 'integer')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ {{num}}{{num}}{{num}}{{num}} }
{{else if (eq column.type 'float')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ {{num}}.{{num}} }
{{else if (eq column.type 'decimal')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ {{num}}.{{num}} }
{{else if (eq column.type 'boolean')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ {{bool}} }
{{else if (eq column.type 'date')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ Date.parse "0{{num}} Jan 2017" }
{{else if (eq column.type 'datetime')}}
{{> column_name name=column.name}} {{#if default}}{ nil } # {{/if}}{ Date.parse "0{{num}} Jan 2017" }
{{/if}}
{{/inline}}
{{#*inline "make_trait"}}
{{#if rows}}

    trait :{{snake td_key}} do
{{#each rows}}
      {{> make_trait_key_value default=false column=. settings=../settings td_key=../td_key alpha=../alpha num=../num bool=../bool padsize=38}}
{{/each}}
    end
{{/if}}
{{/inline}}
{{> make_trait rows=entity.columns_data       settings=settings td_key=entity.td_key1 alpha="A-" num=1 bool=true}}
{{> make_trait rows=entity.columns_data       settings=settings td_key=entity.td_key2 alpha="B-" num=2 bool=false}}
{{> make_trait rows=entity.columns_data       settings=settings td_key=entity.td_key3 alpha="C-" num=3 bool=true}}
{{> make_trait rows=entity.columns_deleted_at settings=settings td_key="deleted_at"   alpha="A-" num=1 bool=true}}
{{> make_trait rows=entity.columns_token      settings=settings td_key="tokens"       alpha=nil  num=1 bool=true}}
  end
end
