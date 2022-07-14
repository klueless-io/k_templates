# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

describe Gsheet::Reader::Gs{{camel entity.model_name}}Reader do
  before(:each) do
    FactoryBot.reload
  end

  subject(:gs_reader) { Gsheet::Reader::Gs{{camel entity.model_name}}Reader.new(AppService::DEFAULT_SPREADSHEET_NAME_TEST) }

  # ----------------------------------------------------------------------
  # Examples of how you can use this in your code
  # ----------------------------------------------------------------------

  context "examples", :gsheet_live_data do
    example "example: read {{snake entity.model_name}} from gsheets" do
      reader = Gsheet::Reader::Gs{{camel entity.model_name}}Reader.new(AppService::DEFAULT_SPREADSHEET_NAME)

      reader.read

      rows = reader.get_filtered_rows(sample_key: "production")

      p_{{snake entity.name_plural}}_as_table rows, "gsheet"
    end
  end

  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context "factories" do
    # it "should print test data" do
    #   print_data_set
    #
    #   expect(1).to eq(1)
    # end
  end

  context "setup", :gsheet_test_data do
    describe "instantiate" do
      it "should instantiate class" do
        # expect({{camel entity.model_name}}Query.new({})).to_not be_nil
        expect(Gsheet::Reader::Gs{{camel entity.model_name}}Reader.new(AppService::DEFAULT_SPREADSHEET_NAME_TEST)).to_not be_nil
      end
    end

    context "read" do
      it "should read entire table" do
        gs_reader.read

        expect(gs_reader.spreadsheet_name).to eq(AppService::DEFAULT_SPREADSHEET_NAME_TEST)
        expect(gs_reader.worksheet_name).to eq("{{dashify entity.model_name}}")

        p_{{snake entity.name_plural}}_as_table gs_reader.get_rows, "gsheet" if AppService::SHOULD_PRINT_TEST_DATA
      end
    end
  end
end
