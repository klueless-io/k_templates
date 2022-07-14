-- Statistics and Cache Counters:
--
-- Store counts for main tables in the system
-- Store counts for related child tables in the system, also includes group for which is the main value row being grouped on 
--
-- Research:
-- Cache Counters vs Materialized Views vs some other stats mechinism
-- View Migrations using Scenic: 
--  - https://github.com/scenic-views/scenic
--  - https://blog.ragnarson.com/2016/12/09/database-views-in-rails-with-scenic.html
--  - https://robots.thoughtbot.com/announcing-scenic--versioned-database-views-for-rails
-- Materialize Views and Scenic
--  - https://ideamotive.co/blog/materialized-views-ruby-rails-scenic
--
-- Can I create an ActiveRecord View with an STI that ensures that stats are linked to every table correctly
--  - https://roberteshleman.com/blog/2014/09/18/using-postgres-views-with-rails/
--
-- Materialized View Resources:
--  - https://hashrocket.com/blog/posts/materialized-view-strategies-using-postgresql
--  - https://hashrocket.com/blog/posts/materialized-view-strategies-using-postgresql
--  - https://medium.com/jobteaser-dev-team/materialized-views-with-postgresql-for-beginners-9809483db35f
--
-- Usage:
-- select * from klue_statistics;
--
-- Turn the DSL generated query into a Materialized View:
-- drop materialized view if exists klue_statistics;

-- create materialized view klue_statistics as

  select stat_code, stat_type, table_group, table_name, group_by, group_id, group_for, count as total from
  (
  {{#each cache_counters}}
  {{#ifx this.stat_type '==' 'table_count'}}
    -- {{titleize (humanize this.table)}} row count
    select '{{this.stat_code}}' as stat_code, '{{this.stat_type}}' as stat_type, '{{this.table}}' as table_name, '{{this.table_group}}' as table_group, 'all' as group_by, cast(null as integer) as group_id, null as group_for, count(*) as count
    from {{this.table_plural}}
  {{/ifx}}
  {{#ifx this.stat_type '==' 'table_child_count'}}
    -- {{titleize (humanize this.table_plural)}} sub-grouped by {{humanize this.child}} row count
    select '{{this.stat_code}}' as stat_code, '{{this.stat_type}}' as stat_type, '{{this.table}}' as table_name, '{{this.table_group}}' as table_group, '{{this.child_plural}}' as group_by, cast({{this.table_plural}}.id as integer) as group_id, {{this.table_plural}}.{{this.table_key}} as group_for, count(*) as count
    from {{this.table_plural}}
    join {{this.child_plural}} as {{this.table}}_{{this.child_plural}} on {{this.table_plural}}.id = {{this.table}}_{{this.child_plural}}.{{this.child_foreign_key}}
    group by {{this.table_plural}}.id, {{this.table_plural}}.{{this.child_key}}
  {{/ifx}}

  {{#if @last}}{{else}}union{{/if}}

  {{/each}}
  )
  as klue_statistics

  order by stat_code, stat_type, table_group, table_name, group_by, total desc, group_for;

-- -- For Materialized View
-- --
-- create index on klue_statistics (stat_type);
-- create index on klue_statistics (table_name);
-- create index on klue_statistics (group_by);
-- create index on klue_statistics (group_id);

-- -- samples:
-- -- all counts
-- select * from klue_statistics;

-- -- row counts for specific tables
-- select * from klue_statistics where stat_type = 'table_count';

-- -- row counts for tables sub-grouped by related children 
-- {{#each cache_counters}}
-- {{#ifx this.stat_type '==' 'table_child_count'}}
-- select * from klue_statistics where stat_type = 'table_child_count' and table_name = '{{this.table}}' and group_by = '{{this.child_plural}}';
-- {{/ifx}}
-- {{/each}}