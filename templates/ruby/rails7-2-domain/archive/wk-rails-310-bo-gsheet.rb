# frozen_string_literal: true

# Read data from google sheets
module Gsheet
  # Google sheet model
  class Gs{{camel entity.model_name}}
    include Virtus.model

    # What sort of sample data, e.g. unit-test, unit-test-query
    attribute :sample_key, String

    # What field could we use as a synchronization key
    attribute :sync_{{snake entity.main_key}}name, String

    # Unique test key, this key is used by factory bot unit tests
    attribute :test_key, String

    {{#if relations}}
    # Foreign keys that need to be looked up and attached to this object
    {{#each relations}}
    {{#if (eq type 'one_to_one')}}
    attribute :sync_fk_{{snake this.name}}, String
    {{/if}}
    {{/each}}
    {{/if}}
    def initialize(attributes = nil)
      # Virtus will take your attributes and match them to the attribute definitions listed below
      super(attributes)
    end
    {{#each rows_and_virtual}}
    {{#if (eq type 'primary_key')}}
    attribute :{{snake this.name}}, Integer
    {{else if (eq type 'foreign_key')}}
    attribute :{{snake this.name}}, Integer # This will be lookedup via a tkey
    {{else if (eq db_type 'jsonb')}}
    attribute :{{snake this.name}}, Hash
    {{else}}
    attribute :{{snake this.name}}, {{camel this.type}}
{{/if}}
    {{/each}}
  end
end
