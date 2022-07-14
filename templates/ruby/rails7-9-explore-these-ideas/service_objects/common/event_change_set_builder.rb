# frozen_string_literal: true

# This class builds an Event style changeset for a model from the changes on an active model
#
# N.B. As this is using saved_changes the model will need to be saved before calling.
class EventChangeSetBuilder
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def build
    resource.saved_changes.except('updated_at').each_with_object({}) do |(key, changes), mem|
      mem[key.to_sym] = %i[from to].zip(changes).to_h
    end
  end
end
