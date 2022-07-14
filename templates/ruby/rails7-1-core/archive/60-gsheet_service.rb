# frozen_string_literal: true

# Interact with Google Sheets
module Gsheet
  # Googlesheet service
  class GsheetService
    # attr_accessor :session
    attr_reader :spreadsheet

    # What spreadsheet would you like to open by name
    #
    # @param title: name of spreadsheet
    # @param config_key: name of configuration to use, defaults to {{settings.application}}

    def initialize(title = nil, config_key = nil)
      config_key = "{{settings.application}}" if config_key.nil?

      @session = GoogleDrive::Session.from_config("config/google-config-#{config_key}.json")

      open_spreadsheet(title) unless title.nil?
    end

    # Get the name (title) of spreadsheet
    def name
      assert_valid_spreadsheet
      @spreadsheet.name
    end

    # Open a connection to a spreadsheet by it's title
    def open_spreadsheet(title)
      @spreadsheet = @session.spreadsheet_by_title(title)
      nil
    end

    # Open a worksheet from an already open spreadsheet by it's index (position)
    def worksheet_by_index(index)
      assert_valid_spreadsheet
      @spreadsheet.worksheets[index]
    end

    # Open a worksheet from an already open spreadsheet by it's title
    def worksheet_by_title(title)
      assert_valid_spreadsheet
      @spreadsheet.worksheet_by_title(title)
    end

    # Open list of worksheet titles from an already open spreadsheet by it's title
    def worksheet_titles
      assert_valid_spreadsheet
      @spreadsheet.worksheets.map(&:title)
    end

    # Add a new worksheet
    def add_worksheet(title, max_rows = 100, max_cols = 20)
      @spreadsheet.add_worksheet(title, max_rows, max_cols)
    end

    private

    def assert_valid_spreadsheet
      raise "You must open a connection to a spreadsheet before using this method" if @spreadsheet.nil?
    end
  end
end
