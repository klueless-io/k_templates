# frozen_string_literal: true

module Commands
  module {{camelU model.name}}Commands
    # {{titleize verb}} {{downcase (humanize model.name)}}
    #
    # This will '{{titleize verb}} {{humanize model.name}}' and publish an update event (via honeybadger) on success.
    #
    # If there is an error it returns a failed status and a localized error message
    class {{camelU verb}}
      include Interactor
      include Ensure
      include Instrumentation

      delegate :{{dasherize model.name}}, :attribute1, :attribute2, to: :context

      def call
        ensure_context_includes :{{dasherize model.name}}

        # Sample custom error for paramater marshalling, for when ensure_context_includes is not enough
        context.fail!(message: 'Attribute2 is required during updates') if attribute2.nil? || attribute2 == :bad_condition

        {{dasherize model.name}}.assign_attributes(attribute1: attribute1, attribute2: attribute2)

        if {{dasherize model.name}}.save
          publish_event
        else
          context.fail!(i18: :{{dasherize verb}}_{{dasherize model.name}}_failed)
        end
      rescue ActiveRecord::RecordInvalid
        # context.fail!(message: 'There was an error updating this {{humanize model.name}}')
        context.fail!(i18: :{{dasherize verb}}_{{dasherize model.name}}_record_invalid)
      end
    end
  end
end