# frozen_string_literal: true

require "query/query_page_do"
require "query/query_sort_do"
require "query/query_option_do"

# Query entity objects
module Query
  # Query base object
  class BaseQuery
    attr :model_name, :relation, :options
    attr_accessor :current_user

    def initialize(relation, model_name, options)
      @relation = relation
      @model_name = model_name

      # L.block(@model_name + ".initialize")

      process_options(options)
    end

    def page
      @options.page
    end

    def filter
      @options.filter
    end

    def order_by
      @options.sort
    end

    def current_page
      result = QueryPageDo.new(@options.page)

      result.total = @relation.length

      result
    end

    def run
      # L.block [@model_name + ".run"]

      # Setup column selection, by default it be .*
      # Filter the dataset based on incoming filter parameters, i.e. build a where clause
      query

      # Order the dataset based on incoming sort parameters. i.e. add an order by clause
      ordered

      # Page the data based on incoming pagination parameters, uses gem "kaminari"
      paged

      # L.block @relation.to_sql

      @relation
    end

    #----------------------------------------------------------------------
    # Debugging
    #----------------------------------------------------------------------
    # Sample Test Data:
    # http://localhost:3000/api_admin/v1/jobs?access_token=XYZEH892374JKLASDF&options={%22page%22:{%22active%22:true,%22no%22:1,%22size%22:50},%22sort%22:[{%22field%22:%22location%22},{%22field%22:%22id%22,%22direction%22:%22desc%22}],%22filter%22:[[%22state%22,%22pending%22],[%22otherkey%22,true]]}
    # http://localhost:3000/api_admin/v1/jobs?access_token=XYZEH892374JKLASDF&options={%22page%22:{%22active%22:true,%22no%22:1,%22size%22:10},%22sort%22:[{%22field%22:%22location%22,%22direction%22:%22asc%22},{%22field%22:%22xyz%22,%22direction%22:%22desc%22},{%22field%22:%22xyzs%22,%22direction%22:%22wht%20direction%22},{%22field%22:%22xyz1%22},{%22field%22:%22xyz%22,%22direction%22:%22%22},{%22direction%22:%22desc%22}]}
    #----------------------------------------------------------------------

    # rubocop:disable Metrics/AbcSize
    def debug
      L.line
      L.info "Paging"
      L.kv "active", page.active
      L.kv "page.no", page.no
      L.kv "page.size", page.size
      L.line

      L.info "Order By"
      order_by.each do |sort|
        L.kv sort.field, sort.direction
      end
      L.line

      # PL.yaml @options.sort

      L.info "Filter"
      filter.each_key do |key|
        L.kv key, @options.filter[key]
      end
      L.line

      # L.yaml @options.filter
    end
    # rubocop:enable Metrics/AbcSize

    protected

    def ordered
      # PL.block ["BASE", "Order"]

      @options.sort.each do |sort_order|
        @relation = @relation.order("#{sort_order.field} #{sort_order.direction}")
      end

      # @relation = order_by("model_name")
    end

    # --------------------------------------------------------------------------------
    # Query helpers for single field
    # --------------------------------------------------------------------------------

    def add_suggest_ilike(field, value)
      @relation.where("#{field} ilike ?", "%#{value}%")
    end

    # Suggest iLike All will return rows where the field contains ANY of the values in any order
    # e.g. "David Anthony Cruwys" will be found for name ["david", "cruwys"] or ["cruwys", "david"]
    # or put another way
    # e.g. "ben hurr" will match "ben god killer hurr" and "Mr Hurr, Ben"
    def add_suggest_ilike_all(field, values)
      @relation.where("#{field} ilike all (array[?])", values.map { |map| "%#{map}%" })
    end

    # Suggest iLike Any will return rows where the field contains ANY of the values in any order
    # e.g. "David Anthony Cruwys" will be found for name ["david", "cruwys"] or ["cruwys", "david"] or ["Cruwys"] or ["David"]
    def add_suggest_ilike_any(field, values)
      @relation.where("#{field} ilike any (array[?])", values.map { |map| "%#{map}%" })
    end

    # --------------------------------------------------------------------------------
    # Query helpers for multi fields
    # --------------------------------------------------------------------------------

    # def where_suggest_ilike_across_fields(fields, value)
    #   @relation = @relation.where("#{field} ilike ?", "%#{value}%")
    # end

    #----------------------------------------------------------------------
    # Filter Values
    #----------------------------------------------------------------------
    def get_filter_value(key, default_value = "")
      result = @options.filter[key]

      return result if Util.is_bool(result)

      result = default_value if result.blank?

      result
    end

    #----------------------------------------------------------------------
    # Sort Order
    #----------------------------------------------------------------------

    # # def order_by(order, defaultField, defaultDirection = "asc")
    # # This code is not finished
    # def order_by(defaultField, defaultDirection = "asc")
    #
    #
    #   # # order = JSON.parse(order) if !order.nil?
    #   # order = {"field" => defaultField, "sort" => defaultDirection } if order.nil?
    #   #
    #   # field = order["field"]
    #   # direction = order["sort"]
    #   #
    #   # PL.kv "Sort Field", field
    #   # PL.kv "Sort Order", direction
    #   #
    #   # @relation = @relation.order("#{field} #{direction}")
    # end

    #----------------------------------------------------------------------
    # Pagination
    #----------------------------------------------------------------------

    def paged
      return unless @options.page.active

      # @relation = @relation.paginate(:page => @options.page.no, :per_page => @options.page.size)
      @relation = @relation.page(@options.page.no).per(@options.page.size)
    end

    private

    #----------------------------------------------------------------------
    # Configuration
    #----------------------------------------------------------------------

    # Read in options JSON object and populate internal state
    def process_options(options)
      options_hash = Util.parse_as_hash(options)

      @options = QueryOptionDo.new(options_hash)

      #-----------------------
      # Handle Filter Settings
      #-----------------------
      # Sample Filters: "filter":["state":"pending","otherkey":true]

      #------------------------
      # Handle Sorting Settings
      #------------------------
      # Sample Sorts: "sort":[{"field":"location"},{"field":"id","direction":"desc"}]
    end
  end
end
