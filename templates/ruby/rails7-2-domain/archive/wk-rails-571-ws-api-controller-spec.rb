# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

# {{camel entity.name_plural}}Controller :: Restful tests
RSpec.describe Api::V1::{{camel entity.name_plural}}Controller, type: :controller do
  render_views

  before(:each) do
    FactoryBot.reload

    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  context "factories" do
    before(:each) do
      full_data_set
    end

    describe "check factory data" do
      if AppService::SHOULD_PRINT_TEST_DATA
        it "should print test data" do
          print_data_set

          expect(1).to eq(1)
        end
      end

      it "should have test data" do
        # NOTE: This is copied from /spec/models/{{snake entity.model_name}}_spec.rb and so may be better placed in a helper such as /spec/helpers/{{snake entity.model_name}}_expect.rb
        expect({{camel entity.model_name}}.count).to eql 3

        expect(@{{snake entity.model_name}}_{{snake settings.td_key1}}).to_not be_nil
        expect(@{{snake entity.model_name}}_{{snake settings.td_key2}}).to_not be_nil
      end
    end
  end

  # {{camel entity.name_plural}}Controller.show
  #
  # GET api/v1/{{snake entity.name_plural}}/:id
  context "show" do
    before(:each) do
      full_data_set
    end

    it "should have success response and data for valid ID" do
      get :show, params: { id: @{{snake entity.model_name}}_{{snake settings.td_key1}}.id }

      # log.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil
      {{#each entity.columns}}
      {{#if (eq type 'foreign_key')}}
      expect(data.row.{{snake this.name}}_id).to eq(@{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}}_id)
      {{else}}
      expect(data.row.{{snake this.name}}).to eq(@{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}})
{{/if}}
      {{/each}}
    end

    it "should have failure response for invalid ID" do
      get :show, params: { id: "3" }

      # log.info response.body.parse_json

      expect(response.status).to eq(404)

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
      expect(data.result.message).to_not be_empty
      expect(data.row).to be_nil

      get :show, params: { id: "bad_name" }
      expect(response.status).to eq(404)

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
    end
  end

  # ----------------------------------------------------------------------
  # {{camel entity.name_plural}}Controller.index (Query)
  #
  # GET api/v1/{{snake entity.name_plural}}?options={}
  context "index" do
    before(:each) do
      full_data_set_for_query
    end

    it "should query {{camel entity.model_name}} and return first page of data for no filter conditions" do
      get :index

      # log.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_index

      expect(data.result.success).to eq(true)

      expect(data.page).to_not be_nil
      expect(data.rows).to_not be_nil

      expect(data.page.no).to eq(1)
      expect(data.page.size).to eq(20)
      expect(data.page.total).to eq({{camel entity.model_name}}.count)
      {{#each entity.columns}}
      {{#if (eq type 'foreign_key')}}
      expect(data.rows.first.{{snake this.name}}_id).to eq(@query_{{snake ../entity.model_name}}_01.{{snake this.name}}_id)
      {{else}}
      expect(data.rows.first.{{snake this.name}}).to eq(@query_{{snake ../entity.model_name}}_01.{{snake this.name}})
{{/if}}
      {{/each}}
      {{#each entity.columns}}
      {{/each}}
    end

    it "should query {{camel entity.model_name}} with custom filter and sort order" do
      ids = [
        @query_{{snake entity.model_name}}_01.id,
        @query_{{snake entity.model_name}}_03.id,
        @query_{{snake entity.model_name}}_10.id
      ].join(",")

      get :index, params: { options: "{\"filter\":{\"id\":\"#{ids}\"},\"sort\":[{\"field\":\"{{snake entity.main_key}}name\",\"sort\":\"desc\"}]}" }

      # log.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_index

      expect(data.result.success).to eq(true)

      expect(data.page).to_not be_nil
      expect(data.rows).to_not be_nil

      expect(data.page.no).to eq(1)
      expect(data.page.size).to eq(20)
      expect(data.page.total).to eq(data.rows.length)

      # Descending order
      expect(data.rows.map(&:id)).to include(
        @query_{{snake entity.model_name}}_01.id,
        @query_{{snake entity.model_name}}_03.id,
        @query_{{snake entity.model_name}}_10.id
      )

      expect(data.rows[0].{{snake entity.main_key}}name).to eq(@query_{{snake entity.model_name}}_10.{{snake entity.main_key}}name)
      expect(data.rows[1].{{snake entity.main_key}}name).to eq(@query_{{snake entity.model_name}}_03.{{snake entity.main_key}}name)
      expect(data.rows[2].{{snake entity.main_key}}name).to eq(@query_{{snake entity.model_name}}_01.{{snake entity.main_key}}name)
    end

    it "should query {{camel entity.model_name}} with custom pagination" do
      get :index, params: { options: '{"page":{"active":true,"no":2,"size":3}}' }

      # log.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_index

      expect(data.result.success).to eq(true)

      expect(data.page).to_not be_nil
      expect(data.rows).to_not be_nil

      expect(data.page.no).to eq(2)
      expect(data.page.size).to eq(3)
      expect(data.page.total).to eq(data.rows.length)

      # Page 2 data
      expect(data.rows[0].{{snake entity.main_key}}name).to eq(@query_{{snake ./entity.model_name}}_04.{{snake entity.main_key}}name)
      expect(data.rows[1].{{snake entity.main_key}}name).to eq(@query_{{snake ./entity.model_name}}_10.{{snake entity.main_key}}name)
      expect(data.rows[2].{{snake entity.main_key}}name).to eq(@query_{{snake ./entity.model_name}}_11.{{snake entity.main_key}}name)
    end
  end

  # Create {{camel entity.model_name}}
  #
  # POST api/v1/{{snake entity.name_plural}}
  context "create" do
    before(:each) do
      data_set_for_create
    end

    it "should create {{titleize (humanize entity.model_name)}}" do
      expected_count = {{camel entity.model_name}}.count + 1

      # Set Field Values
      new_row = {
{{#each relations_one_to_one}}
        {{snake this.field}}: @{{snake this.name}}_{{snake this.td_key1}}.id,
{{/each}}
{{#each rows_fields_and_virtual}}
      {{#if (eq db_type '')}}
)        {{snake this.name}}: { a: '{{snake this.name}}'}{{#if @last}}{{else}},{{/if}}
      {{else if (eq type 'integer')}}
        {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
      {{else if (eq type 'boolean')}}
        {{snake this.name}}: true{{#if @last}}{{else}},{{/if}}
      {{else if (eq type 'Float')}}
        {{snake this.name}}: 1.1{{#if @last}}{{else}},{{/if}}
      {{else if (eq type 'date')}}
        {{snake this.name}}: DateTime.now{{#if @last}}{{else}},{{/if}}
      {{else if (eq type 'datetime')}}
        {{snake this.name}}: DateTime.now{{#if @last}}{{else}},{{/if}}
      {{else}}
        {{snake this.name}}: '{{snake this.name}}{{#if (eq format_type 'email')}}@email.com{{/if}}'{{#if @last}}{{else}},{{/if}}
{{/if}}
{{/each}}
      }

      # Set any relations here

      # Create a new {{snake entity.model_name}} through controller action
      post :create, params: { {{snake entity.model_name}}: new_row }

      # log.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      # Check {{snake entity.model_name}} was created
      expect({{camel entity.model_name}}.count).to eq(expected_count)

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil
      {{#each rows_fields}}
      {{#if (eq db_type '')}}
)      expect(data.row.{{snake this.name}}).to eq({"a"=>"{{snake this.name}}"})
      {{else if (eq type 'integer')}}
      expect(data.row.{{snake this.name}}).to eq(1)
      {{else if (eq type 'boolean')}}
      expect(data.row.{{snake this.name}}).to eq(true)
      {{else if (eq type 'Float')}}
      expect(data.row.{{snake this.name}}).to eq(1.1)
      {{else if (eq type 'date')}}
      expect(data.row.{{snake this.name}}).to be_within(1.second).of(DateTime.now) # This really needs to be near to second, refactor and update template
      {{else if (eq type 'datetime')}}
      expect(data.row.{{snake this.name}}).to be_within(1.second).of(DateTime.now) # This really needs to be near to second, refactor and update template
      {{else}}
      expect(data.row.{{snake this.name}}).to eq('{{snake this.name}}{{#if (eq format_type 'email')}}@email.com{{/if}}')
{{/if}}
      {{/each}}
    end

    it "should fail to create {{titleize (humanize entity.model_name)}} when required fields have invalid data" do
      expect({{camel entity.model_name}}.count).to eq(0)

      new_row = {
      {{#each entity.columns}}
      {{#if (eq type 'primary_key')}}
      {{else if (eq type 'foreign_key')}}
      {{else}}
        {{snake this.name}}: nil{{#if @last}}{{else}},{{/if}}
{{/if}}
      {{/each}}
      }

      # Set any relations here

      # Try to create a new {{snake entity.model_name}} through this controller action
      post :create, params: { {{snake entity.model_name}}: new_row }

      # log.info response.body.parse_json

      expect(response.status).to eq(404)

      expect({{camel entity.model_name}}.count).to eq(0)

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
      expect(data.row).to be_nil

      # puts response.body

      # Check Field Validation
      {{#each rows_fields_and_virtual}}
      {{#if (eq type 'boolean')}}
      expect(data.result.errors).to include("{{humanize this.name}} must be provided")
      {{else if this.db_type '==' 'jsonb'}}
      # NOTE: 
      # {{humanize this.name}} = nil converts to {{humanize this.name}} = ""
      # This means both blank and invalid json errors will be triggered
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
      expect(data.result.errors).to include("{{humanize this.name}} is not valid json")
      {{else}}
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
{{/if}}
      {{/each}}

      # Check Relations
      {{#each relations_one_to_one}}
      {{#if (eq json.optional true)}}
      {{else}}
      expect(data.result.errors).to include("{{humanize this.name}} must exist")
{{/if}}
{{/each}}

      # Check Field + Relation Count
      expect(data.result.errors.count).to eq({{settings.stats.fields_and_virtual_error_message_count}}1 + 1{{relations_one_to_one.length}})

      # p_{{snake entity.name_plural}}
    end
  end

  # ----------------------------------------------------------------------
  # Update {{camel entity.model_name}}
  #
  # PUT api/v1/{{snake entity.name_plural}}/:id
  # ----------------------------------------------------------------------
  context "update" do
    before(:each) do
      full_data_set
    end

    it "should update {{titleize (humanize entity.model_name)}}" do
      # Update Fields
      {{#each rows_fields}}
      {{#if (eq db_type '')}}
)      exp_{{snake this.name}} = @{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}}
      exp_{{snake this.name}}['a'] = 'update {{snake this.name}}'
      {{else if (eq type 'boolean')}}
      exp_{{snake this.name}} = !@{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}}
      {{else if (eq type 'string')}}
      exp_{{snake this.name}} = @{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}} + '+updated'
      {{else if (eq type 'integer')}}
      exp_{{snake this.name}} = @{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}} + 1
      {{else if (eq type 'Float')}}
      exp_{{snake this.name}} = @{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}} + 1
      {{else if (eq type 'date')}}
      exp_{{snake this.name}} = @{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}} + 1.days
      {{else if (eq type 'datetime')}}
      exp_{{snake this.name}} = @{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}} + 1.days
      {{else}}
      #exp_{{snake ../entity.model_name}}.{{snake this.name}} = '{{snake this.name}}' # Custom type
{{/if}}
      {{/each}}

      update_row = {
      {{#each rows_fields}}
        {{snake this.name}}: exp_{{snake this.name}}{{#if @last}}{{else}},{{/if}}
      {{/each}}
      }

      # Set any relations here

      # Update existing {{snake entity.model_name}} through controller update action
      post :update, params: { id: @{{snake entity.model_name}}_{{snake settings.td_key1}}.id, {{snake entity.model_name}}: update_row }

      # log.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil

      {{#each rows_fields}}
      expect(data.row.{{snake this.name}}).to eq(exp_{{snake this.name}})
      {{/each}}
      # Check any relations here

      # p_{{snake entity.name_plural}}
    end

    it "should fail to update {{titleize (humanize entity.model_name)}} when required fields have invalid data" do
      update_row = {
      {{#each rows_fields}}
        {{snake this.name}}: nil{{#if @last}}{{else}},{{/if}}
      {{/each}}
      }

      # Try to update existing {{snake entity.model_name}} through controller action
      post :update, params: { id: @{{snake entity.model_name}}_{{snake settings.td_key1}}.id, {{snake entity.model_name}}: update_row }

      # log.info response.body.parse_json

      expect(response.status).to eq(404)

      # puts response.body

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
      expect(data.row).to be_nil

      # Check Field Validation
      {{#each entity.columns}}
      {{#if (eq type 'primary_key')}}
      {{else if (eq type 'foreign_key')}}
      {{else if (eq type 'boolean')}}
      expect(data.result.errors).to include("{{humanize this.name}} must be provided")
      {{else if (eq db_type 'jsonb')}}
      # NOTE: 
      # {{humanize this.name}} = nil converts to {{humanize this.name}} = ''
      # This means both blank and invalid json errors will be triggered
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
      expect(data.result.errors).to include("{{humanize this.name}} is not valid json")
      {{else}}
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
{{/if}}
      {{/each}}

      expect(data.result.errors.count).to eq({{settings.stats.fields_error_message_count}})

      # p_{{snake entity.name_plural}}
    end

    # it "should fail to update {{titleize (humanize entity.model_name)}} when required relations are missing" do
    #
    #   {{snake entity.model_name}} = {{camel entity.model_name}}.find(@{{snake entity.model_name}}_{{snake settings.td_key1}}.id)
    #
    #
    #   is_save = {{snake entity.model_name}}.save
    #
    #   # log.block {{snake entity.model_name}}.errors.full_messages
    #
    #   expect(is_save).to eq(false)
    #
    #   # Check Relations
    #
    #   expect({{snake entity.model_name}}.errors.messages.count).to eq(1)
    #
    #   # p_{{snake entity.name_plural}}
    # end
  end

  # ----------------------------------------------------------------------
  # Delete {{camel entity.model_name}}
  #
  # DELETE api/v1/{{snake entity.name_plural}}/:id
  # ----------------------------------------------------------------------

  context "destroy" do
    before(:each) do
      full_data_set
    end

    it "should destroy {{titleize (humanize entity.model_name)}} by id" do
      count = {{camel entity.model_name}}.count

      get :destroy, params: { id: @{{snake entity.model_name}}_{{snake settings.td_key1}}.id }

      # log.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil

      expect(data.row.id).to eq(@{{snake entity.model_name}}_{{snake settings.td_key1}}.id)

      expect({{camel entity.model_name}}.count).to eq(count - 1)

      # p_{{snake entity.name_plural}}
    end
  end

  # Convert each API JSON string into structure objects with named properties
  def parse_result_with_row
    json = response.body.parse_json

    row = TestData::TdApi{{camel entity.model_name}}Row.map(json["row"])

    data = {
      result: map_td_api_result(json["result"]),
      row: row
    }

    TestData::TdApiOneRow.new(data)
  end

  def parse_index
    json = response.body.parse_json

    rows = json["rows"].map { |row| TestData::TdApi{{camel entity.model_name}}Row.map(row) }

    data = {
      result: map_td_api_result(json["result"]),
      page: map_td_api_page(json["page"]),
      rows: rows
    }

    TestData::TdApiManyRows.new(data)
  end

  # ----------------------------------------------------------------------
  # Create unit test data
  # ----------------------------------------------------------------------

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
    return unless AppService.debug?

      {{#each settings.parent_dependencies}}
    p_{{snake this}}_as_table
      {{/each}}
{{#each relations_one_to_one}}
    p_{{snake this.name_plural}}_as_table
{{/each}}
    p_{{snake entity.name_plural}}_as_table
    # p_{{snake entity.name_plural}}(nil, "detailed")
  end
end
