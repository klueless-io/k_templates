require "pg_util"
# frozen_string_literal: true

# Access statistics for table
#
# Related to Cache Counters:
#
# Store counts for main tables in the system
# Store counts for related child tables in the system, also includes group for which is the main value row being grouped on
#
# Research:
# Cache Counters vs Materialized Views vs some other stats mechinism
# View Migrations using Scenic:
#  - https://github.com/scenic-views/scenic
#  - https://blog.ragnarson.com/2016/12/09/database-views-in-rails-with-scenic.html
#  - https://robots.thoughtbot.com/announcing-scenic--versioned-database-views-for-rails
# Materialize Views and Scenic
#  - https://ideamotive.co/blog/materialized-views-ruby-rails-scenic
#
# Can I create an ActiveRecord View with an STI that ensures that stats are linked to every table correctly
#  - https://roberteshleman.com/blog/2014/09/18/using-postgres-views-with-rails/
#
# Materialized View Resources:
#  - https://hashrocket.com/blog/posts/materialized-view-strategies-using-postgresql
#  - https://hashrocket.com/blog/posts/materialized-view-strategies-using-postgresql
#  - https://medium.com/jobteaser-dev-team/materialized-views-with-postgresql-for-beginners-9809483db35f
#
# Usage:
# select * from klue_statistics;
#
class KlueStatistics < ActiveRecord::Base
  def self.refresh; end

  # self.primary_key = "event_id"
  # belongs_to :event

  # SqlMigration is for use from a migration file or from a direct call from code
  # as these migrations are simple create/drop of views
  #
  # Current support is for [:view, :materialized_view]
  # Future support will be for [:query, :triggers]
  #
  # Usage:
  #   KlueStatistics::SqlMigration.create
  #   KlueStatistics::SqlMigration.up
  #   KlueStatistics::SqlMigration.down
  class SqlMigration
    def self.up
      migration = SqlMigration.new(sql_strategy: :view)
      migration.create_sql_assets
    end

    def self.down
      migration = SqlMigration.new(sql_strategy: :view)
      migration.drop_sql_assets
    end

    def self.create
      down
      up
    end

    # SQL strategy to use, valid values include [:query, :view, :materialized_view, :triggers]
    attr_accessor :sql_strategy

    # @param [symbol] sql_strategy SQL strategy to use, valid values include [:query, :view, :materialized_view, :triggers]
    def initialize(sql_strategy: :view)
      @sql_strategy = sql_strategy
    end

    def drop_sql_assets
      case @sql_strategy
      when :view
        PgUtil.execute_sql("drop view if exists klue_statistics;")

      when :materialized_view
        PgUtil.execute_sql("drop index if exists klue_statistics_stat_type;")
        PgUtil.execute_sql("drop index if exists klue_statistics_table_name;")
        PgUtil.execute_sql("drop index if exists klue_statistics_group_by;")
        PgUtil.execute_sql("drop index if exists klue_statistics_group_id;")

        PgUtil.execute_sql("drop materialized view if exists klue_statistics;")
      else
        raise "SQL strategy [#{@sql_strategy}] not implemented"
      end
    end

    def create_sql_assets
      case @sql_strategy
      when :view

        sql = <<~SQL
                    drop view if exists klue_statistics;
          #{'          '}
                    create view klue_statistics as
          #{'          '}
                    #{sql_select_statistics}
        SQL

        PgUtil.execute_sql(sql)

      when :materialized_view

        sql = <<~SQL
                    drop materialized view if exists klue_statistics;
          #{'          '}
                    create materialized view klue_statistics as
          #{'          '}
                    #{sql_select_statistics}
        SQL

        PgUtil.execute_sql(sql)

        PgUtil.execute_sql('create index klue_statistics_stat_type  on klue_statistics ("stat_type");')
        PgUtil.execute_sql('create index klue_statistics_table_name on klue_statistics ("table_name");')
        PgUtil.execute_sql('create index klue_statistics_group_by   on klue_statistics ("group_by");')
        PgUtil.execute_sql('create index klue_statistics_group_id   on klue_statistics ("group_id");')

      else
        raise "SQL strategy [#{@sql_strategy}] not implemented"
      end
    end

    def sql_select_statistics
      File.read("app/models/klue_statistics.sql")
    end
  end
end
