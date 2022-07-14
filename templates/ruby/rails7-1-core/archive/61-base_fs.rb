# frozen_string_literal: true

module Fstore
  class BaseFs

    include Virtus.model
    include FsId

    def initialize(data = nil, document_id = nil)
      super(data)

      set_document_id(document_id)
    end

    # ----------------------------------------------------------------------
    protected
    # ----------------------------------------------------------------------

    def _upsert(table_name)
      snapshot = FirestoreApi.upsert(table_name, self._id, self.as_json).get

      set(snapshot.data, snapshot.document_id)
    end

    def set(data, document_id)
      self.attributes = data

      set_document_id(document_id)
    end

    def set_document_id(document_id)
      if self.id.nil?
        self.id = document_id
      end
    end

  end
end
