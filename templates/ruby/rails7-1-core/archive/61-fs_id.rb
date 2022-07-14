# frozen_string_literal: true

module Fstore
  module FsId
    include Virtus.module

    # Prevent the ID from being read  (NEED TO NOTE DOWN why this is a requirement, I think it is related to the to_json action)
    attribute :id, String, :reader => :protected

    def _id
      return self.id
    end
  end
end
