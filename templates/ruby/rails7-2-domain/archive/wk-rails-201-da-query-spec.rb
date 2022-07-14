# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Query::{{camel entity.model_name}}Query do
  before(:each) do
    FactoryBot.reload
  end

  context 'factories' do
    before(:each) do
      full_data_set_for_query
    end

    if AppService::SHOULD_PRINT_TEST_DATA
      it 'should print test data' do
        print_data_set

        expect(1).to eq(1)
      end
    end

    it 'should have test data' do
      expect({{camel entity.model_name}}.count).to be >= 2

      {{#each entity.td_query}}
      expect(@query_{{snake ../entity.model_name}}_{{snake this}}).to_not be_nil
      {{/each}}
    end
  end

  context 'setup' do
    describe 'instantiate' do
      it 'should instantiate class' do
        expect(Query::{{camel entity.model_name}}Query.new({})).to_not be_nil
      end
    end

    describe 'configure' do
      it 'should have default configuration' do
        query = Query::{{camel entity.model_name}}Query.new({})

        expect(query.page.no).to eq(1)
        expect(query.page.size).to eq(20)
        expect(query.page.active).to eq(true)

        expect(query.filter).to eq({})
        expect(query.order_by).to eq([])

        # query.debug
      end

      it 'should have a custom configuration' do
        config = <<-JSON
            {
              "page": {
                  "no": 1,
                  "size": 3
              },
              "filter": {
{{#if (eq entity.no_key true)}}
{{else}}
                "search": "bob",
                "{{snake entity.main_keys}}": ["bob", "jane"]
{{/if}}
              },
              "sort": [
{{#if (eq entity.no_key true)}}
                { "field": "id" },
{{else}}
                { "field": "{{snake entity.main_key}}" },
{{/if}}
                { "field": "created_at", "direction": "desc" }
              ]
            }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)
        # query.debug

        # expect(query.page.no).to eq(1)
        # expect(query.page.size).to eq(3)
        expect(query.page.active).to eq(true)

        # log.kv 'Filter', query.filter
        # log.kv 'Sort', query.sort

        expect(query.order_by.length).to eq(2)

{{#if (eq entity.no_key true)}}
        expect(query.order_by[0].field).to eq('id')
        expect(query.order_by[0].direction).to eq('asc')
{{else}}
        expect(query.order_by[0].field).to eq('{{snake entity.main_key}}')
        expect(query.order_by[0].direction).to eq('asc')
{{/if}}

        expect(query.order_by[1].field).to eq('created_at')
        expect(query.order_by[1].direction).to eq('desc')

{{#if (eq entity.no_key false)}}
        expect(query.filter["search"]).to eq("bob")
        expect(query.filter["{{snake entity.main_keys}}"]).to eq(["bob", "jane"])
{{/if}}
      end
    end
  end

  context 'queries' do
    before(:each) do
      full_data_set_for_query
    end

    describe 'all data' do
      it 'should query {{camel entity.model_name}} and return all rows' do
        config = <<-JSON
          {}
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run
        page = query.current_page

        expect(page.no).to eq(1)
        expect(page.size).to eq(20)
        expect(page.total).to eq({{camel entity.model_name}}.count)

        expect(result.length).to eq({{camel entity.model_name}}.count)

        # p_{{snake entity.name_plural}}_as_table(result)
      end
    end

    describe 'pagination' do
      it 'should query {{camel entity.model_name}}s for page size 3: page #1' do
        config = <<-JSON
          {
            "page": {
                "no": 1,
                "size": 3
            }
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run
        page = query.current_page

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(page.no).to eq(1)
        expect(page.size).to eq(3)
        expect(page.total).to eq(3)

        expect(result.length).to eq(page.total)

        # First record on the :first page
{{#if (eq entity.no_key true)}}
        expect(result.first.id).to eq(@query_{{snake entity.model_name}}_01.id)
{{else}}
        expect(result.first.{{snake entity.main_key}}).to eq(@query_{{snake entity.model_name}}_01.{{snake entity.main_key}})
{{/if}}
      end

      it 'should query {{camel entity.model_name}} for page size 3: page #2' do
        config = <<-JSON
          {
            "page": {
              "no": 2,
              "size": 3
            },
            "sort": [
{{#if (eq entity.no_key true)}}
              {
                "field": "id",
                "sort": "asc"
              }
{{else}}
              {
                "field": "{{snake entity.main_key}}",
                "sort": "asc"
              }
{{/if}}
            ]
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run
        page = query.current_page

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(page.no).to eq(2)
        expect(page.size).to eq(3)
        expect(page.total).to eq(3)

        expect(result.length).to eq(page.total)

        # First record on the 2nd page
{{#if (eq entity.no_key true)}}
        expect(result.first.id).to eq(@query_{{snake entity.model_name}}_04.id)
{{else}}
        expect(result.first.{{snake entity.main_key}}).to eq(@query_{{snake entity.model_name}}_04.{{snake entity.main_key}})
{{/if}}
      end

    end

    describe 'sort order' do
      it 'should query {{camel entity.model_name}} with sort by [{{snake entity.main_key}} asc]' do
        config = <<-JSON
          {
            "sort": [
{{#if (eq entity.no_key true)}}
                {
                  "field": "id",
                  "sort": "asc"
                }
{{else}}
                {
                  "field": "{{snake entity.main_key}}",
                  "sort": "asc"
                }
{{/if}}
              ]
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run

        # p_{{snake entity.name_plural}}_as_table(result)

        # First record on the :first page
{{#if (eq entity.no_key true)}}
        expect(result.first.id).to eq(@query_{{snake entity.model_name}}_01.id)
{{else}}
        expect(result.first.{{snake entity.main_key}}).to eq(@query_{{snake entity.model_name}}_01.{{snake entity.main_key}})
{{/if}}
      end

      it 'should query {{camel entity.model_name}} with sort by [{{#if (eq entity.no_key true)}}id{{else}}{{snake entity.main_key}}{{/if}} desc]' do
        config = <<-JSON
          {
            "sort": [
                {
                    "field": "{{#if (eq entity.no_key true)}}id{{else}}{{snake entity.main_key}}{{/if}}",
                    "sort": "desc"
                }
            ]
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run

        # p_{{snake entity.name_plural}}_as_table(result)

        # First record on the :first page
        expect(result.first.{{#if (eq entity.no_key true)}}id{{else}}{{snake entity.main_key}}{{/if}}).to eq(@query_{{snake entity.model_name}}_13.{{#if (eq entity.no_key true)}}id{{else}}{{snake entity.main_key}}{{/if}})
      end

      # If you need multi column sorts then activate this unit test
      # xit 'should query {{camel entity.model_name}} with multiple sort conditions by [data desc, {{snake entity.main_key}} desc]' do

      #   config = <<-JSON
      #     {
      #       "sort": [
      #           {
      #               "field": "data",
      #               "sort": "desc"
      #           },
      #           {
      #               "field": "{{snake entity.main_key}}",
      #               "sort": "desc"
      #           }
      #       ]
      #     }
      #   JSON

      #   query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

      #   result = query.run

      #   # p_{{snake entity.name_plural}}_as_table(result)

      #   expect(result.first.{{snake entity.main_key}}).to eq(@query_{{snake entity.model_name}}_11.{{snake entity.main_key}})
      # end
    end
  end

  context 'filtered queries' do
    before(:each) do
      full_data_set_for_query
    end

    describe 'filter by id' do
      it 'should query {{camel entity.model_name}} where id=1' do
        id = @query_{{snake entity.model_name}}_01.id

        config = <<-JSON
          {
            "filter": {
              "id": "#{id}"
            }
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(result.first.id).to eq(id)

      end

      it 'should query {{camel entity.model_name}} where id in (id1, id2, id3)' do
        ids = [
          999,
          @query_{{snake entity.model_name}}_01.id,
          @query_{{snake entity.model_name}}_04.id,
          @query_{{snake entity.model_name}}_10.id
        ].join(',')

        config = <<-JSON
          {
            "filter": {
              "id": "#{ids}"
            }
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(result.length).to eq(3)

        expect(result.map(&:id)).to include(
                  @query_{{snake entity.model_name}}_01.id,
                  @query_{{snake entity.model_name}}_04.id,
                  @query_{{snake entity.model_name}}_10.id)
      end
    end

    {{#array_has_key_value rows 'name' 'active'}}
    describe 'filter by active flag' do
      it 'should query {{camel entity.model_name}} where active = "all"' do
        config = <<-JSON
          {
            "filter": {
                "active": "all"
            }
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(result.find { |item| item.active == true }).to_not be_nil
        expect(result.find { |item| item.active == false }).to_not be_nil
      end

      it 'should query {{camel entity.model_name}} where active = "active"' do
        config = <<-JSON
          {
            "filter": {
                "active": "active"
            }
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        # To array so that we are working off final data results
        result = query.run.to_a

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(result.find { |item| item.active == true }).to_not be_nil
        expect(result.find { |item| item.active == false }).to be_nil
      end

      it 'should query {{camel entity.model_name}} where active = "inactive"' do
        config = <<-JSON
          {
            "filter": {
                "active": "inactive"
            }
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(result.find { |item| item.active == true }).to be_nil
        expect(result.find { |item| item.active == false }).to_not be_nil
      end

    end
    {{else}}
    # ACTIVE has been SKIPPED
    {{/array_has_key_value}}

{{#if (eq entity.no_key false)}}
    describe 'filter by [combination of words] in {{snake entity.main_key}} [ALL match]' do
      it 'should query {{camel entity.model_name}} where "ben" and "hurr" are in {{snake entity.main_key}} ' do
        @query_{{snake entity.model_name}}_01.{{snake entity.main_key}} = 'ben+god+killer+hurr{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake entity.model_name}}_01.save

        @query_{{snake entity.model_name}}_02.{{snake entity.main_key}} = 'Mr+Hurr+Ben{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake entity.model_name}}_02.save

        @query_{{snake entity.model_name}}_03.{{snake entity.main_key}} = 'Ben+Jones{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake entity.model_name}}_03.save

        @query_{{snake entity.model_name}}_04.{{snake entity.main_key}} = 'John+Hurr{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake entity.model_name}}_04.save

        config = <<-JSON
          {
            "filter": {
                "{{snake entity.main_key}}": "ben hurr"
            }
          }
        JSON

        query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake entity.name_plural}}_as_table(result)

        expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_01.{{snake entity.main_key}})}).to_not be_nil
        expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_02.{{snake entity.main_key}})}).to_not be_nil
        expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_03.{{snake entity.main_key}})}).to be_nil
        expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_04.{{snake entity.main_key}})}).to be_nil

        expect(result.length).to eq(2)
      end
    end
{{else}}
# NO_KEY has been SKIPPED
{{/if}}

    # Currently not implemented
    # xdescribe 'filter by [combination of words] in {{snake entity.main_key}} [ANY match]' do

    #   it 'should query {{camel entity.model_name}} where "ben" and "hurr" are in {{snake entity.main_key}}' do

    #     @query_{{snake entity.model_name}}_01.{{snake entity.main_key}} = 'ben+god+killer+hurr'
    #     @query_{{snake entity.model_name}}_01.save

    #     @query_{{snake entity.model_name}}_02.{{snake entity.main_key}} = 'Mr+Hurr+Ben'
    #     @query_{{snake entity.model_name}}_02.save

    #     @query_{{snake entity.model_name}}_03.{{snake entity.main_key}} = 'Ben+Jones'
    #     @query_{{snake entity.model_name}}_03.save

    #     @query_{{snake entity.model_name}}_04.{{snake entity.main_key}} = 'John+Hurr'
    #     @query_{{snake entity.model_name}}_04.save

    #     config = <<-JSON
    #       {
    #         "filter": {
    #             "{{snake entity.main_key}}_any": "ben hurr"
    #         }
    #       }
    #     JSON

    #     query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

    #     result = query.run.to_a                             # To array so that we are working off final data results

    #     # p_{{snake entity.name_plural}}_as_table(result)

    #     expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_01.{{snake entity.main_key}})}).to_not be_nil
    #     expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_02.{{snake entity.main_key}})}).to_not be_nil
    #     expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_03.{{snake entity.main_key}})}).to_not be_nil
    #     expect(result.find { |item| item.{{snake entity.main_key}}.is_equal?(@query_{{snake entity.model_name}}_04.{{snake entity.main_key}})}).to_not be_nil

    #     expect(result.length).to eq(4)

    #   end

    # end

    # Currently not implemented
    # xdescribe 'filter by [search value] in [any] field' do

    #   it 'should query {{camel entity.model_name}} where "weirdo" is in any searchable field' do

    #     @query_{{snake entity.model_name}}_01.{{snake entity.main_key}} = 'weirdo'
    #     @query_{{snake entity.model_name}}_01.save

    #     @query_{{snake entity.model_name}}_02.data = 'weirdo'
    #     @query_{{snake entity.model_name}}_02.save

    #     @query_{{snake entity.model_name}}_03.{{snake entity.main_key}} = 'the weirdo'
    #     @query_{{snake entity.model_name}}_03.save

    #     @query_{{snake entity.model_name}}_04.data = 'weirdo in the house'
    #     @query_{{snake entity.model_name}}_04.save

    #     @query_{{snake entity.model_name}}_10.data = 'weirdo'
    #     @query_{{snake entity.model_name}}_10.save

    #     config = <<-JSON
    #       {
    #         "filter": {
    #             "search": "weirdo"
    #         }
    #       }
    #     JSON

    #     query = Query::{{camel entity.model_name}}Query.new(config.parse_json)

    #     result = query.run.to_a                             # To array so that we are working off final data results

    #     # p_{{snake entity.name_plural}}_as_table
    #     # p_{{snake entity.name_plural}}_as_table(result)

    #     expect(result.find { |item| item.{{snake entity.main_key}}.is_equal(@query_{{snake entity.model_name}}_01.{{snake entity.main_key}})}).to_not be_nil
    #     expect(result.find { |item| item.data.is_equal(@query_{{snake entity.model_name}}_02.data)}).to_not be_nil
    #     expect(result.find { |item| item.{{snake entity.main_key}}.is_equal(@query_{{snake entity.model_name}}_03.{{snake entity.main_key}})}).to_not be_nil
    #     expect(result.find { |item| item.data.is_equal(@query_{{snake entity.model_name}}_04.data)}).to_not be_nil
    #     expect(result.find { |item| item.data.is_equal(@query_{{snake entity.model_name}}_10.data)}).to_not be_nil

    #     expect(result.length).to eq(5)

    #   end

    # end

  end

  # ----------------------------------------------------------------------
  # {{camel entity.model_name}}s: Data Setup and Printing
  # ----------------------------------------------------------------------

  # data set for query unit tests
  def full_data_set_for_query
    {{#each settings.parent_dependencies}}
    td_{{snake this}}
    {{/each}}
    {{#each relations}}
    {{#if (eq type 'one_to_one')}}
    td_{{snake this.name_plural}}
{{/if}}
{{/each}}

    td_{{snake entity.name_plural}}_for_query
  end

  def print_data_set
    return if !AppService::is_debug

      {{#each settings.parent_dependencies}}
    p_{{snake this}}_as_table
      {{/each}}
      {{#each relations}}
      {{#if (eq type 'one_to_one')}}
    p_{{snake this.name_plural}}_as_table
{{/if}}
      {{/each}}

    p_{{snake entity.name_plural}}_as_table
    #p_{{snake entity.name_plural}}(nil, 'detailed')
  end

end
