# frozen_string_literal: true

# This concern provides an easy way to publish resource changes from controllers
#
module PublishResourceChanges
  extend ActiveSupport::Concern

  included do
    # Publish an event if given fields have changed
    #
    # Note: This will only fire an event if the given fields have changed
    # The changes will be included in the payload
    #
    # * <tt>:resource</tt> - The resource the event is about.
    # * <tt>:on_changes_to</tt> - A list of fields that trigger publish event.
    # * <tt>:event_key</tt> - The event key of the publish event
    # * <tt>:actor</tt> - User/Integration that triggered event
    def publish_resource_changes(resource:, on_changes_to:, event_key:, actor:)
      trigger_fields = Array(on_changes_to)

      return if resource.saved_changes.slice(*trigger_fields).empty?

      changeset = EventChangeSetBuilder.new(resource).build

      # Honeybadger or other abstraction
      EventStore.publish(key: event_key,
                         resource: resource,
                         actor: actor,
                         data: { changes: changeset.slice(*trigger_fields) })
    end
  end
end
