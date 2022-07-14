# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

describe BulkUpsert::{{camel entity.model_name}}BulkUpsert do
  # NOTE: The tests on BASE must use a table and so they are using the {{camel entity.model_name}} as an example

  # Default bulk upsert
  #   - CANNOT destroy underlying table
  #   - Will automatically create constraining index
  subject(:upsert) { BulkUpsert::{{camel entity.model_name}}BulkUpsert.new }

  before(:each) do
    FactoryBot.reload
  end

  # ----------------------------------------------------------------------
  # Examples of how you can use this in your code
  # ----------------------------------------------------------------------
  context "examples", :gsheet_live_data do
    example "synchronize {{dashify entity.name_plural}} from gsheets using [unit-test] data" do
      data_set_for_create

      upsert_{{snake entity.name_plural}} = BulkUpsert::{{camel entity.model_name}}BulkUpsert.new
      upsert_{{snake entity.name_plural}}.destroy_and_resequence_table
      upsert_{{snake entity.name_plural}}.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "unit-test")

      print_data_set
    end

    example "synchronize {{dashify entity.name_plural}} from gsheets using [sample] data" do
{{#each settings.parent_dependencies}}
      upsert_{{snake this}} = BulkUpsert::{{camel this}}BulkUpsert.new
      upsert_{{snake this}}.destroy_and_resequence_table
      upsert_{{snake this}}.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "sample")

{{/each}}
{{#each relations_one_to_one}}
      upsert_{{snake this.name_plural}} = BulkUpsert::{{camel this.name}}BulkUpsert.new
      upsert_{{snake this.name_plural}}.destroy_and_resequence_table
      upsert_{{snake this.name_plural}}.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "sample")

{{/each}}

      upsert_{{snake entity.name_plural}} = BulkUpsert::{{camel entity.model_name}}BulkUpsert.new
      upsert_{{snake entity.name_plural}}.destroy_and_resequence_table
      upsert_{{snake entity.name_plural}}.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "sample")

      print_data_set
    end

    example "example: synchronize {{dashify entity.name_plural}} from gsheets using [production] data" do
{{#each settings.parent_dependencies}}
      upsert_{{snake this}} = BulkUpsert::{{camel this}}BulkUpsert.new
      upsert_{{snake this}}.destroy_and_resequence_table
      upsert_{{snake this}}.sync(source_key: "production")

{{/each}}
{{#each relations_one_to_one}}
      upsert_{{snake this.name_plural}} = BulkUpsert::{{camel this.name}}BulkUpsert.new
      upsert_{{snake this.name_plural}}.destroy_and_resequence_table
      upsert_{{snake this.name_plural}}.sync(source_key: "production")

{{/each}}
      upsert_{{snake entity.name_plural}} = BulkUpsert::{{camel entity.model_name}}BulkUpsert.new
      upsert_{{snake entity.name_plural}}.destroy_and_resequence_table
      upsert_{{snake entity.name_plural}}.sync(source_key: "production")

      print_data_set
    end
  end

  context "factories" do
    before(:each) do
      full_data_set
    end

    describe "print" do
      # it "should print test data" do
      #   print_data_set
      #
      #   expect(1).to eq(1)
      # end
    end
  end

  context "setup", :gsheet_test_data do

    it "should instantiate the service" do
      expect(upsert).to_not be_nil
      # expect(upsert_with_destroy).to_not be_nil
    end

    it "should have default properties" do
      expect_bulk_upsert_default_settings(
        upsert,
        table_name: "{{camel entity.model_name}}",
        table_name_plural: "{{snake entity.name_plural}}",
        can_destroy: true,
        single_use_unique_index: true,
        conflict_keys: ["{{snake entity.main_key}}"]
     )
    end
  end

  context "reset table", :gsheet_test_data do
    before(:each) do
      full_data_set
    end

    it "should destroy_and_resequence_table" do
      expect({{camel entity.model_name}}.count).to eq(3)

      # p_{{snake entity.name_plural}}_as_table

      upsert.destroy_and_resequence_table

      expect({{camel entity.model_name}}.count).to eq(0)

      td_{{snake entity.name_plural}}

      expect({{camel entity.model_name}}.order(:id).first.id).to eq(1)

      # p_{{snake entity.name_plural}}_as_table
    end
  end

  # context "create constraining indexes" do
  #
  # end

  context "synchronize", :gsheet_test_data do
    before(:each) do
      data_set_for_create
      # full_data_set
    end

    it "should add {{snake entity.name_plural}}" do
      expect({{camel entity.model_name}}.count).to eq(0)

      upsert.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "unit-test")

      expect({{camel entity.model_name}}.count).to eq(upsert.source_rows.length)

      # p_{{snake entity.name_plural}}_as_table
    end

    it "should add new {{snake entity.name_plural}} only" do
      upsert.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "unit-test")
      # p_{{snake entity.name_plural}}_as_table

      expect({{camel entity.model_name}}.count).to eq(upsert.source_rows.length)

      {{snake entity.model_name}} = {{camel entity.model_name}}.first

{{#if settings.key.yes}}
      expected_{{snake entity.main_key}}name = {{snake entity.model_name}}.{{snake entity.main_key}}name
{{/if}}
      {{snake entity.model_name}}.delete

      expect({{camel entity.model_name}}.count).to eq(upsert.source_rows.length-1)

      upsert.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "unit-test")
      # p_{{snake entity.name_plural}}_as_table

      expect({{camel entity.model_name}}.count).to eq(upsert.source_rows.length)
{{#if (eq entity.no_key false)}}
      expect({{camel entity.model_name}}.order(:id).last.{{snake entity.main_key}}name).to eq(expected_{{snake entity.main_key}}name)
{{/if}}
    end

{{#includes settings.model_type (array 'admin_user' 'basic_user')}}
      # 'should update {{snake entity.name_plural}}'
      #   NOT SUPPORTED for {{settings.model_type}}
      # end
{{else}}
    it 'should update {{snake entity.name_plural}}' do
      upsert.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: "unit-test")
      # p_{{snake entity.name_plural}}_as_table

      expect({{camel entity.model_name}}.count).to eq(upsert.source_rows.length)

      # Grab first and delete
      {{snake entity.model_name}} = {{camel entity.model_name}}.first
      original_{{snake settings.utest_update.field_name}} = {{snake entity.model_name}}.{{snake settings.utest_update.field_name}}

{{#if (eq settings.utest_update.field_type 'boolean')}}
      {{snake entity.model_name}}.{{snake settings.utest_update.field_name}} = !{{snake entity.model_name}}.{{snake settings.utest_update.field_name}}
{{else}}
      {{snake entity.model_name}}.{{snake settings.utest_update.field_name}} = {{snake entity.model_name}}.{{snake settings.utest_update.field_name}} + ' - updated'
{{/if}}
      {{snake entity.model_name}}.save

      expect({{camel entity.model_name}}.first.{{snake settings.utest_update.field_name}}).to eq({{snake entity.model_name}}.{{snake settings.utest_update.field_name}})

      # p_{{snake entity.name_plural}}_as_table
      upsert.sync(spreadsheet_name: AppService::DEFAULT_SPREADSHEET_NAME_TEST, source_key: 'unit-test')
      # p_{{snake entity.name_plural}}_as_table

      expect({{camel entity.model_name}}.first.{{snake settings.utest_update.field_name}}).to eq(original_{{snake settings.utest_update.field_name}})
    end
{{/includes}}
  end

  # ----------------------------------------------------------------------
  # {{camel entity.name_plural}}: Data Setup and Printing
  # ----------------------------------------------------------------------

  # NOTE: Refactor opportunity :: Test Data creation patterns are being
  #       repeated in services, controllers and model specs for the same
  #       table name and so these methods below should be moved out into
  #       a Test data helper section

  # data set for create unit tests
  def data_set_for_create
{{#each settings.parent_dependencies}}
    td_{{snake this}}
{{/each}}
{{#each relations_one_to_one}}
    td_{{snake this.name_plural}}
{{/each}}
  end

  # data set for general unit tests
  def full_data_set
    data_set_for_create

    td_{{snake entity.name_plural}}
  end

  def full_data_set_for_query
    data_set_for_create

    td_{{snake entity.name_plural}}_for_query
  end

  def print_data_set
    return if !AppService::is_debug

{{#each settings.parent_dependencies}}
    p_{{snake this}}_as_table
{{/each}}
{{#each relations_one_to_one}}
    p_{{snake this.name_plural}}_as_table
{{/each}}
    p_{{snake entity.name_plural}}_as_table
    #p_{{snake entity.name_plural}}(nil, "detailed")
  end
end
