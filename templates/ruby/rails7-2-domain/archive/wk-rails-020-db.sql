-- ======================================================================
-- Common SQL statents for {{camel entity.name_plural}}
-- ======================================================================

-- ----------------------------------------------------------------------
-- Select
-- ----------------------------------------------------------------------
select * from {{snake entity.name_plural}};

select count(*) from {{snake entity.name_plural}};

select 
{{#each entity.columns_data_primary}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}}
{{/each}}
{{#each entity.has_one}}
,  {{snake infer_key}} -- has one - fieldname mismatch, fix
{{/each}}
from {{snake entity.name_plural}};

-- Join parents
{{#if entity.has_relations}}
select 
{{#each entity.columns_data_primary}}
{{#if @first}}  {{else}}, {{/if}} {{snake ../entity.name_plural}}.{{snake this.name}}
{{/each}}
{{#each entity.has_one}}
,  {{snake this.model_name_plural}}.{{snake infer_key}}
,  '{{snake this.model_name_plural}}.{{snake this.main_key}}' as {{snake this.model_name_plural}}_main_key -- FIX this
{{/each}}
from {{snake entity.name_plural}}
{{#each entity.has_one}}
join {{this.model_name_plural}} on {{this.model_name_plural}}.id = {{snake ../entity.name_plural}}.{{this.infer_key}}
{{/each}}
;
{{/if}}

-- ----------------------------------------------------------------------
-- Insert
-- ----------------------------------------------------------------------
insert into {{snake entity.name_plural}} (
{{#each entity.columns_data}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}}
{{/each}}
{{#each entity.has_one}}
,  {{snake this.infer_key}}
{{/each}}
, created_at
, updated_at
)
values (
{{#each entity.columns_data}}
{{#if (eq type 'foreign_key')}}
{{#if @first}}  {{else}}, {{/if}} null                          -- Foreign KEY
{{else if (eq type 'integer')}}
{{#if @first}}  {{else}}, {{/if}} 1
{{else if (eq type 'decimal')}}
{{#if @first}}  {{else}}, {{/if}} 1.0
{{else if (eq type 'jsonb')}}
{{#if @first}}  {{else}}, {{/if}} '{}'
{{else if (eq type 'json')}}
{{#if @first}}  {{else}}, {{/if}} '{}'
{{else if (eq type 'hstore')}}
{{#if @first}}  {{else}}, {{/if}} '{}'
{{else if (eq type 'boolean')}}
{{#if @first}}  {{else}}, {{/if}} true
{{else if (eq type 'date')}}
{{#if @first}}  {{else}}, {{/if}} now()
{{else if (eq type 'datetime')}}
{{#if @first}}  {{else}}, {{/if}} now()
{{else}}
{{#if @first}}  {{else}}, {{/if}} '{{snake this.name}}'
{{/if}}
{{/each}}
{{#each entity.has_one}}
,  null                          -- Put Foreign KEY for {{camel this.field}} here
{{/each}}
, now()
, now()
);

-- ----------------------------------------------------------------------
-- Update
-- ----------------------------------------------------------------------
update {{snake entity.name_plural}}
set
{{#each entity.columns_data}}
{{#if (eq type 'integer')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = 2
{{else if (eq type 'decimal')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = 2.0
{{else if (eq type 'boolean')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = false
{{else if (eq type 'date')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = now()
{{else if (eq type 'json')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = '{}'
{{else if (eq type 'jsonb')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = '{}'
{{else if (eq type 'hstore')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = '{}'
{{else if (eq type 'datetime')}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = now()
{{else}}
{{#if @first}}  {{else}}, {{/if}} {{padr (snake name) 40}} = '{{snake this.name}} - update'
{{/if}}
{{/each}}
{{#each entity.has_one}}
, {{padr (snake infer_key) 40}} =  null                          -- Put Foreign KEY for updating {{camel this.field}} here
{{/each}}
WHERE
  id = 1;

-- ----------------------------------------------------------------------
-- Delete
-- ----------------------------------------------------------------------

delete from {{snake entity.name_plural}};
alter sequence {{snake entity.name_plural}}_id_seq restart with 1;
