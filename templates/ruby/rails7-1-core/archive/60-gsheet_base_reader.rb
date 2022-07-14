# frozen_string_literal: true

# Interact with Google Sheets
module Gsheet
  module Reader
    # Google sheets base reader
    class BaseReader
      # GsheetTable = Struct.new(:spreadsheet_name, :worksheet_name, :columns, :active_columns, :rows)
      GsheetColumn = Struct.new(:field, :active, :type, :column_no)

      attr_accessor :spreadsheet_name

      attr_accessor :worksheet
      attr_accessor :worksheet_name

      # Indicates row numbers from the source spreadsheet that contain different pieces of information
      attr_accessor :field_state_row_no       # Row with the state of the data for reading, [active/inactive]
      attr_accessor :field_type_row_no        # Row with the data types
      attr_accessor :field_name_row_no        # Row with the field names
      attr_accessor :data_row_no              # Row where the data actually starts

      attr_accessor :is_loaded                # Has data been loaded from spreadsheet

      def initialize(spreadsheet_name, worksheet_name, config_key = nil)
        @spreadsheet_name = spreadsheet_name
        @spreadsheet_service = Gsheet::GsheetService.new(spreadsheet_name, config_key)

        @worksheet_name = worksheet_name
        @worksheet = @spreadsheet_service.get_ws_by_title(worksheet_name)

        # Row numbers are Zero based
        @field_state_row_no     = 0
        @field_type_row_no      = 1
        @field_name_row_no      = 2
        @data_row_no            = 3

        # Column definitions (AKA active columns, Data is only returned for active columns)
        @columns                = nil

        # All Columns, includes inactive
        @all_columns            = nil

        @is_loaded              = false

        @rows                   = nil
      end

      def read(force_refresh: false)
        raise "Spreadsheet '#{@spreadsheet_name}', does not have a worksheet name: #{@worksheet_name}" if @worksheet.nil?

        return unless !@is_loaded || force_refresh

        load_column_definition
        load_rows

        @is_loaded = true

        # @table = GsheetTable.new(@spreadsheet_service.name, @worksheet.title, @columns, @active_columns, load_rows)
      end

      # def rows_by_sample_keys(keys)
      #   if @table.nil?
      #     read
      #   end
      #   @table.rows.select { |row| keys.include?(row.sample_key)}
      # end

      # Get columns
      #
      # @param [Hash] options Custom options that can be included
      #                       :is_active          Return active columns by default, if you pass in false, then you will get all columns, active and inactive
      #                       :match_fields       Array of field names to include or exclude
      #                       :match_type         Match fields for inclusion or exclusion
      def get_columns(options = {})
        opts = {
          is_active: true,
          match_fields: [],
          match_type: "all"
        }.merge(options)

        read

        result = opts[:is_active] ? @columns : @all_columns

        case opts[:match_type].downcase
        when "exclude"                                                          # Exclude these fields
          result.reject { |c| opts[:match_fields].include? c.field }

        when "only"                                                             # Only include these fields
          result.select { |c| opts[:match_fields].include? c.field }

        else # all
          result
        end
      end

      def row_list
        read

        @rows
      end

      # @param [Hash] options Custom options that can filter the rows
      #                       :active               Return active, inactive or all, defaults to all
      #                       :sample_key           Filter by a sample_key, e.g. td, seed, sample, defaults to all, Filter multiple sample_keys can be passed in, e.g. [td, td-query]
      # rubocop:disable Metrics/AbcSize
      def get_filtered_rows(options)
        opts = { active: "all", sample_key: "all" }.merge(options)

        opts[:sample_key] = opts[:sample_key].is_a?(Array) ? opts[:sample_key] : [opts[:sample_key]]

        row_list.select do |row|
          result = (opts[:active] == "all"        || row[:active] == opts[:active]) &&
                   (opts[:sample_key] == ["all"]  || opts[:sample_key].include?(row[:sample_key]))

          next(result)
        end
      end
      # rubocop:enable Metrics/AbcSize

      protected

      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
      def load_column_definition
        return unless @columns.nil? || @all_columns.nil?

        field_states = @worksheet.rows[@field_state_row_no] || []

        field_types = @worksheet.rows[@field_type_row_no] || []
        field_names = @worksheet.rows[@field_name_row_no] || []

        raise "You must have field_names in your spreadsheet" if field_names.empty?

        field_states = Array.new(field_names.length, "active") if field_states.empty?
        field_types = Array.new(field_names.length, "string") if field_types.empty?

        @all_columns  = []
        @columns      = []

        field_names.each_with_index do |field_name, index|
          column = GsheetColumn.new(field_name.underscore.to_sym,
                                    field_states[index].is_equal?("active"),
                                    map_type(field_types[index]),
                                    index)

          @all_columns.push(column)
          @columns.push(column) if column[:active] == true
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

      def load_rows
        @rows = []

        ws_rows = worksheet.rows[@data_row_no..@worksheet.num_rows]

        ws_rows.each do |ws_row|
          row = {}

          @columns.each do |column|
            row[column[:field]] = map_column_value(ws_row[column[:column_no]], column.type)
          end

          new_row = map_row(row)

          # If you wanted to have a custom map_row that return an array
          # then this is how it would be added to the rows
          #
          # Find original code in KlueGo
          # EXAMPLE: how to write a transpose columns mapper
          #
          #   def map_row(row)
          #
          #     new_rows = []
          #
          #     common_keys = [:sample_key, :test_key, :sync_fk_website, :sync_name, :id, :category, :name]
          #     common_values = row.slice(*common_keys)
          #
          #     value_keys = row.except(*common_keys).keys
          #
          #     value_keys.each do |value_key|
          #       new_row = common_values.clone
          #       new_row[:value]           = row[value_key]
          #       new_row[:sync_fk_website] = value_key
          #
          #       new_rows.push(GsWebsiteSetting.new(new_row))
          #     end
          #
          #     return new_rows
          #   end
          if new_row.is_a?(Array)
            @rows.concat(new_row)
          else
            @rows.push(new_row)
          end
        end
      end
      # rubocop:enable Metrics/AbcSize

      # Override map_row if you want a different structure to be added to the rows data
      def map_row(row)
        row
      end

      # Map strings to typed value
      def map_column_value(column_value, type)
        case type.downcase
        when "id", "integer"
          column_value.to_i

        when "boolean"
          column_value.to_bool

        when "jsonb"
          begin
            column_value = JSON.parse(column_value)
          rescue JSON::ParserError
            # column_value = { }
            column_value = { invalid: "Invalid JSON, please fix" }
          end
          column_value

        else
          column_value
        end
      end

      def map_type(type)
        case type.downcase
        when "id"
          "id"
        when "boolean"
          "boolean"
        when "jsonb"
          "jsonb"
        else
          "string"
        end
      end
    end
  end
end
