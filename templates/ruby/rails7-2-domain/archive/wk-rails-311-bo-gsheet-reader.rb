# frozen_string_literal: true

module Gsheet
  module Reader
    # Read {{camel entity.model_name}} shaped data from a google spreadsheet
    #
    # @example
    #
    # gsheet = {{camel entity.model_name}}Gsheet.new
    # table = gsheet.read
    class Gs{{camel entity.model_name}}Reader < BaseReader
      # Open a connection to a worksheet within a google spreadsheet
      #
      # @param [string] spreadsheet_name The name of the spreadsheet to open
      # @param [string] worksheet_name The name of the worksheet to open on the spreadsheet
      # @param [string] config_key The key to the Google configuration that will be used
      def initialize(spreadsheet_name, worksheet_name: "{{dashify entity.model_name}}", config_key: nil)
        super(spreadsheet_name, worksheet_name, config_key)
      end

      # Map raw spreadsheet data to Gs{{camel entity.model_name}}
      def map_row(row)
        Gs{{camel entity.model_name}}.new(row)
      end
    end
  end
end
