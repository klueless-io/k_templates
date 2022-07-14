# frozen_string_literal: true

# Dynamic filtered query against a model
module Query

  # {{camel entity.model_name}}Query provides flexible queries against the {{camel entity.model_name}} table.
  #
  # It is useful in user driven queries such as Angular or VUE Widgets where users need flexible querying
  class {{camel entity.model_name}}Query < Query::BaseQuery

    #======================================================================
    # {{camel entity.model_name}}Query
    #======================================================================

    # Construct a query against the {{camel entity.model_name}} table
    # 
    # @example
    #
    # config = <<-JSON
    #     {
    #       "page": {
    #           "no": 2,
    #           "size": 5
    #       },
    #       "filter": {
    #         "search": "bob",
    #         "{{snake entity.main_key}}names": ["bob", "jane"]
    #       },
    #       "sort": [
    #         { "field": "{{snake entity.main_key}}name" },
    #         { "field": "created_at", "direction": "desc" }
    #       ]
    #     }
    # 
    # query = Query::{{camel entity.model_name}}Query.new(config.parse_json)
    #
    # result = query.run
    # page = query.get_current_page
    # 
    # For more examples, check out the unit tests at /spec/services/{{snake entity.model_name}}_query_spec.rb
    #
    # @param [Hash] options List of filter, pagination and sort options for this query
    # @param [ActiveRecord::Relation] scoped relation to use as the starting point for a query generally you can use the default which is {{camel entity.model_name}}.all
    def initialize(options, relation = {{camel entity.model_name}}.all)
      super relation, '{{camel entity.model_name}}', options

      # ID or Comma seperated list of ID's
      @id = get_filter_value('id')

      # Valid values are ['all', 'active', 'inactive']
      @active = get_filter_value('active', 'all').downcase

      # search for words in any order in {{snake entity.main_key}}name, ALL words must match, e.g. ben hurr will match 'ben god killer hurr' and 'Mr Hurr, Ben'
      @{{snake entity.main_key}}name = get_filter_value('{{snake entity.main_key}}name')

      # # search for words in any order in {{snake entity.main_key}}name, ANY words must match, e.g. ben hurr will match 'ben god killer hurr' and 'Mr Hurr, Ben'
      # @{{snake entity.main_key}}name_any = get_filter_value('{{snake entity.main_key}}name_any')

      # # search across multiple text fields with one search time
      # @search = get_filter_value('search')
    end

    # Dynamically build the main query using the filters that are passed through
    def query
      # log.block ['{{camel entity.model_name}}', "Query"]

      # @relation = @relation.select("{{#each entity.columns}}{{snake ../entity.name_plural}}.{{snake this.name}}{{#if @last}}{{else}}, {{/if}}{{/each}}")
      @relation = @relation.select("*")

      # One ID or many comma seperated ID's can be passed
      @relation = @relation.where(id: @id.split(','))                         if @id.present?

      # Valid values are ['all', 'active', 'inactive']
      @relation = @relation.where(active: @active.is_equal?('active'))        if @active.present? && ['active', 'inactive'].include?(@active)

      # Suggest iLike All
      @relation = add_suggest_ilike_all(:{{snake entity.main_key}}name, @{{snake entity.main_key}}name.split(' '))              if @{{snake entity.main_key}}name.present?

      # # Suggest iLike Any
      # @relation = add_suggest_ilike_any(:{{snake entity.main_key}}name, @{{snake entity.main_key}}name_any.split(' '))        if @{{snake entity.main_key}}name_any.present?

      # # search across multiple text fields with one search term
      # @relation = add_suggest_ilike(:{{snake entity.main_key}}name, @search)
      #                 .or(add_suggest_ilike(:data, @search))                if @search.present?
    end
  end
end
