# frozen_string_literal: true

# Query entity objects
module Query
  # Query sort data object
  class QuerySortDo
    include Virtus.model

    attribute :field, String
    attribute :direction, String, default: "asc"
    # The reader is private so it does not appear in the JSON document,
    attribute :sort, String, reader: :private

    def field=(field)
      super(field.downcase)
    end

    def direction=(direction)
      value = direction.downcase

      value = "asc" unless %w[asc desc].include?(value)

      super(value)
    end

    def sort=(sort)
      self.direction = sort
      super(sort)
    end
  end
end
