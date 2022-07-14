# frozen_string_literal: true

# Query entity objects
module Query
  # Query option data object
  class QueryOptionDo
    include Virtus.model

    def initialize(hash)
      super(hash)

      page.size = 10_000 if page.present? && page.size.present? && page.size == -1
    end

    attribute :page, QueryPageDo, default: QueryPageDo.new
    attribute :filter, Hash
    attribute :layout, String, default: "default"
    attribute :sort, Array[QuerySortDo]
  end
end
