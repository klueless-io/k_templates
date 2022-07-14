# frozen_string_literal: true

module BulkUpsert
  # Base bulk upsert provides general base methods for model specific bulk insert or update
  #
  # This is generally to be used in simple batch style data loading
  #
  # Use cases include:
  #
  # * Seed Data
  # * Importing data from CSV
  # * Importing data from live spreadsheets
  # * Importing data from APIs (unlikely edge case)
  #      - Most API imports need custom approaches as they often have complex and unique rules
  #
  # You can use any input source that provides the attributes that match the fields you would like updated.
  #
  # Upsert relies on SQL constraints to understand if a record is new or update and so you must use this
  # in conjunction with a constraint based index, primary key is valid, but so is other types of keys.
  #
  # These constraints could be dynamic, this means that the index need not exist, you can have it created
  # before processing and removed after processing.
  #
  # A table can be totally cleared and have it's sequence reset
  # A table can be bulk loaded from a data source
  #
  class BaseBulkUpsert
    # What is the name of the table
    attr_reader :table_name

    # What is the pluralized name of the table
    attr_reader :table_name_plural

    # Will table reset (destruction) ever be allowed, beware of this setting
    attr_reader :can_destroy_table

    # What fields will make up the constraint to determine if we are inserting or updating
    #
    # NOTE: This is for SQL bulk inserts and not for GSheet Bulk Inserts, I have a clash going on and need a refactor
    #
    # defaults to ['id"]
    attr_reader :conflict_keys

    # Should an index be created and destroyed just for this process
    # This can be false if we already have an existing unique index constraint in the database
    attr_reader :single_use_unique_index

    # Stores rows that have been loaded in for upserting
    attr_accessor :source_rows

    # Initialize with the model that you would like to work with
    #
    # @param [ActiveRelation] relation What model are you bulk updating
    # @param [Array[string]] conflict_keys What fields will make up the constraint to determine if we are inserting or updating
    #                        defaults to ["id"]
    # @param [Boolean] can_destroy_table Will table reset (destruction) ever be allowed, be careful of this setting -
    #                                    Defaults to False
    # @param [Boolean] single_use_unique_index Should an index be created and destroyed just for this process
    def initialize(active_record, conflict_keys: ["id"], can_destroy_table: false, single_use_unique_index: true)
      @active_record = active_record

      @table_name = active_record.name
      @table_name_plural = @table_name.underscore.pluralize

      @conflict_keys = conflict_keys.map(&:downcase)

      @can_destroy_table = can_destroy_table
      @single_use_unique_index = single_use_unique_index
    end

    # Warning: This is a DANGEROUS operation
    #
    # It is designed to clear a table completely and reset it's sequence
    #
    # This is only to be used with tables that suited to resetting.

    def destroy_and_resequence_table
      raise "You cannot destroy this table" unless @can_destroy_table

      # todo-david update generator - need support for fast delete instead of destroy with callbacks
      @active_record.destroy_all

      PgUtil.execute_sql("alter sequence #{@table_name_plural}_id_seq restart with 1;")
    end

    # Note, this maybe useful for SQL bulk upsert, but probabally not needed for custum key lookup bulk upsert
    def create_unique_index
      # PgService.execute_sql("create unique index index_#{@table_name_plual}_on_#{keys}_for_bulk_update;")
      #
      # # create unique index index_cluster_groups_on_code
      # # on cluster_groups (code);
    end

    def sync(source_key: nil, spreadsheet_name: nil, worksheet_name: nil); end

    #
    #   def upsert_cluster_groups(clusters)
    #
    #     sql = build_cluster_groups_upsert(clusters)
    #
    #     PgService::execute_sql(sql)
    #
    #   end
    #
    #   def build_cluster_groups_upsert(clusters)
    #
    #     values = []
    #
    #     clusters.each do |cluster|
    #       values.push("  ("#{cluster[:code]}", "#{cluster[:name]}", NOW, NOW)")
    #     end
    #
    #     insert_values = values.join(",\n")
    #
    #     return <<-SQL
    #
    # INSERT INTO
    #   cluster_groups(code, name, created_at, updated_at)
    # VALUES
    # #{insert_values}
    # ON CONFLICT (code)
    #             DO UPDATE SET
    #               name=EXCLUDED.name,
    #               updated_at=NOW
    # ;
    #     SQL
    #   end
    #
    #   # (1, "Course Provider", NOW, NOW),
    #   #     (1, "Course Level", NOW, NOW),
    #   #     (1, "Higher Ed Group", NOW, NOW)
    #
    #   def build_clusters_upsert(clusters)
    #
    #     values = []
    #
    #     clusters.each do |cluster|
    #
    #       cg = ClusterGroup.find_by(code: cluster[:code])
    #
    #       cluster[:cluster_names].each do |name|
    #         values.push("  (#{cg.id}, "#{name}", NOW, NOW)")
    #       end
    #     end
    #
    #     insert_values = values.join(",\n")
    #
    #     return <<-SQL
    #
    # INSERT INTO
    # clusters(cluster_group_id, name, created_at, updated_at)
    # VALUES
    # #{insert_values}
    # ON CONFLICT (cluster_group_id, name)
    # DO UPDATE SET
    #     name=EXCLUDED.name,
    #     updated_at=NOW
    # ;
    # SQL
    #
    #   end
  end
end
