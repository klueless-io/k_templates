# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# {{camel entity.model_name}} :: CRUD and other model tests
RSpec.describe {{camel entity.model_name}}, type: :model do
  before(:each) do
    FactoryBot.reload
  end

  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context "factories" do
    before(:each) do
      full_data_set
    end

    describe 'check factory data' do
      if AppService::SHOULD_PRINT_TEST_DATA
        it 'should print test data' do
          print_data_set

          expect(1).to eq(1)
        end
      end

      it 'should have test data' do

        # Note: This is copied from /spec/controllers/{{snake entity.model_name}}_spec.rb and so may be better placed in a helper such as /spec/helpers/{{snake entity.model_name}}_expect.rb
        expect({{camel entity.model_name}}.count).to eql 3

        expect(@{{snake entity.model_name}}_{{snake settings.td_key1}}).to_not be_nil
        expect(@{{snake entity.model_name}}_{{snake settings.td_key2}}).to_not be_nil
        expect(@{{snake entity.model_name}}_{{snake settings.td_key3}}).to_not be_nil
      end
    end
  end

  # ----------------------------------------------------------------------
  # Read {{camel entity.model_name}}
  # ----------------------------------------------------------------------

  context "read" do
    before(:each) do
      full_data_set
    end

    it "should show {{titleize (humanize entity.model_name)}}" do
      {{snake entity.model_name}} = {{camel entity.model_name}}.find(@{{snake entity.model_name}}_{{snake settings.td_key1}}.id)

      {{#each entity.columns}}
      {{#if (eq type 'SomeCustomType')}}
      {{else}}
      expect({{snake ../entity.model_name}}.{{snake this.name}}).to eq(@{{snake ../entity.model_name}}_{{snake ../settings.td_key1}}.{{snake this.name}})
      {{/if}}
      {{/each}}

      # Check Relations
{{#each relations_one_to_one}}
      expect({{snake ../entity.model_name}}.{{snake this.name}}.id).to eq(@{{snake this.name}}_{{snake this.td_key1}}.id)
{{/each}}

      # p_{{snake entity.name_plural}}
    end
  end

  # ----------------------------------------------------------------------
  # Create {{camel entity.model_name}}
  # ----------------------------------------------------------------------

  context "create" do
    before(:each) do
      data_set_for_create
    end

    it "should create {{titleize (humanize entity.model_name)}}" do

      expected_count = {{camel entity.model_name}}.count + 1

      new_row = {}

      # Set Field Values
      {{#each rows_fields_and_virtual}}
      {{#if (eq db_type 'jsonb')}}
      new_row[:{{snake this.name}}] = { a: '{{this.name}}' }
      {{else if (eq type 'integer')}}
      new_row[:{{snake this.name}}] = 1
      {{else if (eq type 'boolean')}}
      new_row[:{{snake this.name}}] = true
      {{else if (eq type 'date')}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else if (eq type 'datetime')}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else}}
      new_row[:{{snake this.name}}] = '{{snake this.name}}{{#if this.format_type '==' 'email'}}@email.com{{/if}}'
{{/if}}
      {{/each}}

      # Set Relations
{{#each relations_one_to_one}}
      new_row[:{{snake this.name}}] = @{{snake this.name}}_{{snake this.td_key1}}
{{/each}}

      {{snake entity.model_name}} = {{camel entity.model_name}}.new(new_row)

      is_save = {{snake entity.model_name}}.save

      # log.block {{snake entity.model_name}}.errors.full_messages

      expect(is_save).to eq(true)

      expect({{camel entity.model_name}}.count).to eq(expected_count)

      find_{{snake entity.model_name}} = {{camel entity.model_name}}.find_by(id: {{snake entity.model_name}}.id)

      # Expect Fields
      {{#each rows_fields}}
      {{#if this.db_type '==' 'jsonb'}}
      expect(find_{{snake ../entity.model_name}}.{{snake this.name}}).to eq({ "a"=> "{{snake this.name}}" })
      {{else if (eq type 'date')}}
      expect(find_{{snake ../entity.model_name}}.{{snake this.name}}).to be_within(1.second).of({{snake ../entity.model_name}}.{{snake this.name}})
      {{else if (eq type 'datetime')}}
      expect(find_{{snake ../entity.model_name}}.{{snake this.name}}).to be_within(1.second).of({{snake ../entity.model_name}}.{{snake this.name}})
      {{else}}
      expect(find_{{snake ../entity.model_name}}.{{snake this.name}}).to eq({{snake ../entity.model_name}}.{{snake this.name}})
{{/if}}
      {{/each}}

      # Expect Relationships
{{#each relations_one_to_one}}
      expect({{snake ../entity.model_name}}.{{snake this.name}}.id).to eq(@{{snake this.name}}_{{this.td_key1}}.id)
{{/each}}

      # p_{{snake entity.name_plural}}
    end

    it "should fail to create {{titleize (humanize entity.model_name)}} when required fields are missing" do
      expected_count = {{camel entity.model_name}}.count

      new_row = {}

      # Set Field Values
      {{#each rows_fields_and_virtual}}
      new_row[:{{snake this.name}}] = nil
      {{/each}}
      # Set Relations
{{#each relations_one_to_one}}
      new_row[:{{snake this.name}}] = nil
{{/each}}

      {{snake entity.model_name}} = {{camel entity.model_name}}.new(new_row)

      is_save = {{snake entity.model_name}}.save

      # log.block {{snake entity.model_name}}.errors.full_messages

      expect(is_save).to eq(false)

      expect({{camel entity.model_name}}.count).to eq(expected_count)

      # Check Field Validation
      {{#each rows_fields}}
      {{#if (eq type 'boolean')}}
      expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} must be provided")
      {{else}}
      expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} can't be blank")
{{/if}}
      {{/each}}
{{#includes settings.model_type (array 'admin_user' 'basic_user')}}
      expect({{snake entity.model_name}}.errors.full_messages).to include("Password can't be blank")
{{/includes}}

      # Check Relations
      {{#each relations_one_to_one}}
      {{#if this.json.optional '==' true}}
      {{else}}
      expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} must exist")
{{/if}}
      {{/each}}

      # Check Field + Relation Count
      expect({{snake entity.model_name}}.errors.messages.count).to eq({{rows_fields_and_virtual.length}} + {{relations_one_to_one.length}})

      # p_{{snake entity.name_plural}}
    end

{{#array_has_key_value rows 'db_type' 'jsonb'}}
    it "should fail to create {{titleize (humanize entity.model_name)}} when JSON data is invalid" do

      expected_count = {{camel entity.model_name}}.count

      new_row = {}

      # Set Field Values
      {{#each rows_fields}}
      {{#if this.db_type '==' 'jsonb'}}
      new_row[:{{snake this.name}}] = "invalid JSON data here"
      {{else if (eq type 'integer')}}
      new_row[:{{snake this.name}}] = 1
      {{else if (eq type 'boolean')}}
      new_row[:{{snake this.name}}] = true
      {{else if (eq type 'date')}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else if (eq type 'datetime')}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else}}
      new_row[:{{snake this.name}}] = '{{snake this.name}}'
{{/if}}
      {{/each}}

      # Set Relations
      {{#each relations}}
      {{#if (eq type 'one_to_one')}}
      new_row['{{snake this.name}}'] = @{{snake this.name}}_{{snake this.td_key1}}
{{/if}}
      {{/each}}

      {{snake entity.model_name}} = {{camel entity.model_name}}.new(new_row)

      is_save = {{snake entity.model_name}}.save

      # log.block {{snake entity.model_name}}.errors.full_messages

      expect(is_save).to eq(false)

      # Check Field Validation
      {{#each rows_fields}}
      {{#if this.db_type '==' 'jsonb'}}
      expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} is not valid json")
{{/if}}
      {{/each}}

      # p_{{snake entity.name_plural}}
    end
{{/array_has_key_value}}
  end

  # ----------------------------------------------------------------------
  # Update {{camel entity.model_name}}
  # ----------------------------------------------------------------------

  context "update" do
    before(:each) do
      full_data_set
    end

    it "should update {{titleize (humanize entity.model_name)}}" do
      {{snake entity.model_name}} = {{camel entity.model_name}}.find(@{{snake entity.model_name}}_{{snake settings.td_key1}}.id)

      # Update Fields
      {{#each rows_fields}}
      {{#if this.db_type '==' 'jsonb'}}
      {{snake ../entity.model_name}}.{{snake this.name}} = { a: '{{this.name}}' }
      {{else if (eq type 'boolean')}}
      {{snake ../entity.model_name}}.{{snake this.name}} = false
      {{else if (eq type 'string')}}
      {{snake ../entity.model_name}}.{{snake this.name}} = '{{snake this.name}}+updated{{#if this.format_type '==' 'email'}}@email.com{{/if}}'
      {{else if (eq type 'integer')}}
      {{snake ../entity.model_name}}.{{snake this.name}} = 99999
      {{else}}
      #{{snake ../entity.model_name}}.{{snake this.name}} = '{{snake this.name}}' # Custom type
{{/if}}
      {{/each}}

      # Update Relations
{{#each relations_one_to_one}}
      {{snake ../entity.model_name}}.{{snake this.name}} = @{{snake name}}_{{this.td_key1}}
{{/each}}

      is_save = {{snake entity.model_name}}.save

      # log.block {{snake entity.model_name}}.errors.full_messages

      expect(is_save).to eq(true)

      # Expect Fields
      {{#each rows_fields}}
      {{#if this.db_type '==' 'jsonb'}}
      expect({{snake ../entity.model_name}}.{{snake this.name}}).to eq({ "a"=> "{{snake this.name}}" })
      {{else if (eq type 'boolean')}}
      expect({{snake ../entity.model_name}}.{{snake this.name}}).to be_falsey
      {{else if (eq type 'string')}}
      expect({{snake ../entity.model_name}}.{{snake this.name}}).to eq('{{snake this.name}}+updated{{#if this.format_type '==' 'email'}}@email.com{{/if}}')
      {{else if (eq type 'integer')}}
      expect({{snake ../entity.model_name}}.{{snake this.name}}).to eq(99999)
      {{else}}
      #expect({{snake ../entity.model_name}}.{{snake this.name}}).to eq('{{snake this.name}}') # Custom type
{{/if}}
      {{/each}}

      # Expect Relationships
{{#each relations_one_to_one}}
      #expect({{snake ../entity.model_name}}.{{snake this.name}}.id).to eq(@{{snake name}}_{{snake settings.td_key1}}.id)
{{/each}}

      # p_{{snake entity.name_plural}}
    end

    it "should fail to update {{titleize (humanize entity.model_name)}} when required fields are missing" do
      {{snake entity.model_name}} = {{camel entity.model_name}}.find(@{{snake entity.model_name}}_{{snake settings.td_key1}}.id)

      {{#each rows_fields}}
      {{snake ../entity.model_name}}.{{snake this.name}} = nil
      {{/each}}

      is_save = {{snake entity.model_name}}.save

      # log.block {{snake entity.model_name}}.errors.full_messages

      expect(is_save).to eq(false)

      # Check Field Validation
      {{#each rows_fields}}
      {{#if (eq type 'boolean')}}
      expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} must be provided")
      {{else}}
      expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} can't be blank")
{{/if}}
      {{/each}}

      expect({{snake entity.model_name}}.errors.messages.count).to eq({{rows_fields.length}})

      # p_{{snake entity.name_plural}}
    end

{{#if relations_one_to_one}}
    it "should fail to update {{titleize (humanize entity.model_name)}} when required relations are missing" do
      {{snake entity.model_name}} = {{camel entity.model_name}}.find(@{{snake entity.model_name}}_{{snake settings.td_key1}}.id)

{{#each relations_one_to_one}}
      {{snake ../entity.model_name}}.{{snake this.name}} = nil
{{/each}}

      is_save = {{snake entity.model_name}}.save

      # log.block {{snake entity.model_name}}.errors.full_messages

      expect(is_save).to eq(false)

      # Check Relations
{{#each relations_one_to_one}}
{{#if this.json.optional '==' true}}
      # How would you like to deal with this optional relation?
      # expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} must exist")
{{else}}
      expect({{snake ../entity.model_name}}.errors.full_messages).to include("{{humanize this.name}} must exist")
{{/if}}
{{/each}}

      expect({{snake entity.model_name}}.errors.messages.count).to eq({{relations_one_to_one.length}})

      # p_{{snake entity.name_plural}}
    end
{{/if}}
  end

  # ----------------------------------------------------------------------
  # Delete {{camel entity.model_name}}
  # ----------------------------------------------------------------------

  context "delete" do
    before(:each) do
      full_data_set
    end

    it "should delete {{titleize (humanize entity.model_name)}} by id" do
      count = {{camel entity.model_name}}.count

      {{camel entity.model_name}}.destroy(@{{snake entity.model_name}}_{{snake settings.td_key1}}.id)

      expect({{camel entity.model_name}}.count).to eq(count-1)

      # p_{{snake entity.name_plural}}
    end

    it "should delete {{titleize (humanize entity.model_name)}} by multiple ids" do
      count = {{camel entity.model_name}}.count

      {{camel entity.model_name}}.where(id: [@{{snake entity.model_name}}_{{snake settings.td_key1}}.id, @{{snake entity.model_name}}_{{snake settings.td_key2}}.id]).destroy_all

      expect({{camel entity.model_name}}.count).to eql (count-2)

      # p_{{snake entity.name_plural}}
    end
  end

  # data set for create unit tests
  def data_set_for_create
# {{#if settings.parent_dependencies}}
#     # Create higher level parent test data
# {{/if}}
# {{#each settings.parent_dependencies}}
#     td_{{snake this}}
# {{/each}}
# {{#if relations_one_to_one}}
#     # create one to one related test data
# {{/if}}
# {{#each relations_one_to_one}}
#     td_{{snake this.name_plural}}
# {{/each}}

  end

  # data set for general unit tests
  def full_data_set
    data_set_for_create

    @{{snake entity.model_name}}_{{snake settings.td_key1}} = FactoryBot.create(:{{snake entity.model_name}}, :{{snake settings.td_key1}}{{#if relations}}{{#each relations}}{{#if (eq type 'one_to_one')}}, {{this.name}}: @{{this.name}}_{{snake td_key1}}{{/if}}{{/each}}{{/if}})
    @{{snake entity.model_name}}_{{snake settings.td_key2}} = FactoryBot.create(:{{snake entity.model_name}}, :{{snake settings.td_key2}}{{#if relations}}{{#each relations}}{{#if (eq type 'one_to_one')}}, {{this.name}}: @{{this.name}}_{{snake td_key2}}{{/if}}{{/each}}{{/if}})
    @{{snake entity.model_name}}_{{snake settings.td_key3}} = FactoryBot.create(:{{snake entity.model_name}}, :{{snake settings.td_key3}}{{#if relations}}{{#each relations}}{{#if (eq type 'one_to_one')}}, {{this.name}}: @{{this.name}}_{{snake td_key3}}{{/if}}{{/each}}{{/if}})

    # td_{{snake entity.name_plural}}
  end

  def print_data_set
    return unless AppService.debug?

    {{#if settings.parent_dependencies}}
    # Print higher level parents
    {{/if}}
    {{#each settings.parent_dependencies}}
    p_{{snake this}}_as_table
    {{/each}}
    {{#if relations}}
    # Print related tables
    {{/if}}
{{#each relations}}
    p_{{snake this.name_plural}}_as_table
{{/each}}
    p_{{snake entity.name_plural}}_as_table
    #p_{{snake entity.name_plural}}(nil, 'detailed')
  end
end
