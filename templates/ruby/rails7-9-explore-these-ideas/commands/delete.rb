# frozen_string_literal: true

module Commands
  module {{camelU model.name}}Commands
    # {{titleize verb}} {{humanize model.name_plural}}
    #
    # This will {{titleize verb}} one {{humanize model.name}} and publish a deletion event (via honeybadger) on success.
    #
    # If there is an error it returns a failed status and a localized error message
    class {{camelU verb}}
      include Interactor
      include Ensure
      include Instrumentation

      delegate :{{dasherize model.name}}, to: :context

      def call
        ensure_context_includes :{{dasherize model.name}}

        context.fail!(i18: :{{dasherize verb}}_{{dasherize model.name}}_already_deleted)  if {{dasherize model.name}}.deleted?

        if {{dasherize model.name}}.destroy
          publish_event
        else
          # context.fail!(message: 'Failed to delete {{humanize model.name}}')
          context.fail!(i18: :{{dasherize verb}}_{{dasherize model.name}})
        end
      end
    end
  end
end