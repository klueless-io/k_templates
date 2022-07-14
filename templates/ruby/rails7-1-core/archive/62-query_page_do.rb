# frozen_string_literal: true

module Query
  # Query Page data object
  class QueryPageDo
    include Virtus.model

    attribute :active, Boolean, default: true
    attribute :no, Integer, default: 1
    attribute :size, Integer, default: 20
    attribute :total, Integer
  end
end
