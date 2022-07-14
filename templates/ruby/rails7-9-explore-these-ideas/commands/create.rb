# frozen_string_literal: true

module Commands
  module {{camelU model.name}}Commands
    # {{titleize verb}} {{downcase (humanize model.name)}}
    #
    # This will '{{titleize verb}} {{humanize model.name}}' and publish a creation event (via honeybadger) on success.
    #
    # If there is an error it returns a failed status and a localized error message
    class {{camelU verb}}
      include Interactor
      include Ensure
      include Instrumentation

      delegate :{{dasherize model.name}}, :attribute1, :attribute2, to: :context

      def call
        ensure_context_includes :{{dasherize model.name}}, :attribute1

        context.{{dasherize model.name}} = {{camelU model.name}}.new(**map_params)

        if {{dasherize model.name}}.save
          publish_event
        else
          context.fail!(i18: :{{dasherize verb}}_{{dasherize model.name}}_failed)
        end
      end

      private

      def map_params
        {
          # mapping go here
        }
      end
    end
  end
end