# frozen_string_literal: true

# API V1
module Api
  module V1
    # Restful Actions against {{camel entity.model_name}}
    class {{camel entity.name_plural}}Controller < ApiController
      respond_to :json

      # Show a list of sample endpoints for the {{camel entity.name_plural}} API
      def sample
        super("{{camelL entity.model_name}}", build_sample_endpoints("{{camelL entity.model_name}}", main_key: "{{snake entity.main_key}}"))
      end

      # Index - List of {{camel entity.name_plural}} query with configurable sort and filter options
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     page              : Pagination settings for this request
      #     rows              : List of {{camel entity.name_plural}}
      #
      #
      # Samples:
      #     Success (HTTP Status 200)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}
      #
      #     Failure (HTTP Status 404)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}?options={"page":{"active":true,"no":1,"size":50},"filter":{"search":""},"sort":[{"field":"name","sort":"asc"}]}
      def index
        # log.block "{{camel entity.name_plural}} Index"
        # log.info params[:options]

        query = Query::{{camel entity.model_name}}Query.new(params[:options])

        rows = query.run
        page = query.current_page

        # How do we handle errors?, e.g. is there a 404
        render_success_query(rows, page)
      end

      # Show - Get {{camel entity.model_name}} by ID as JSON
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     row               : Single {{camel entity.model_name}}
      #
      # Samples:
      #     Success (HTTP Status 200)
      #     http://localhost:{{settings.RailsPort}}:3001/api/v1/{{snake entity.name_plural}}/1
      #
      #     Failure (HTTP Status 404)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}/10000069
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}/david
      def show
        # log.block "{{camel entity.name_plural}} Show"

        row = {{camel entity.model_name}}.find_by(id: params[:id])

        return render_success_row(row) if row.present?

        render_error("Could not find {{titleize (humanize entity.model_name)}}")
      end

      # Multi - Select multiple {{camel entity.name_plural}} for bulk actions
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     rows              : List of {{camel entity.name_plural}}
      #
      # Samples:
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}/multi?ids=1,2
      def multi
        log.block "{{camel entity.name_plural}} Multi Select"

        ids = params[:ids] ? params[:ids].split(", ") : []

        rows = {{camel entity.model_name}}.where(id: ids)

        render_success_rows(rows)
      end

      # Create {{camel entity.model_name}}
      #
      # Samples:
      #     (POST) http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}
      def create
        # log.block "{{camel entity.model_name}} - Create"

        row = {{camel entity.model_name}}.new(create_{{snake entity.model_name}}_params)

        return render_success_row(row, "{{titleize (humanize entity.model_name)}} Created") if row.save

        render_error("Failed to create {{titleize (humanize entity.model_name)}}", row.errors.full_messages)
      end

      # Update {{camel entity.model_name}}
      #
      # Samples:
      #     (PUT) http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}/:id
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     row               : Single {{camel entity.model_name}}
      #
      # Samples:
      #     Success (HTTP Status 200)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}/1
      def update
        # log.block "{{camel entity.model_name}} - Update"

        row = {{camel entity.model_name}}.find_by(id: params[:id])

        if row.present?
          return render_success_row(row, "{{titleize (humanize entity.model_name)}} Updated") if row.update(update_{{snake entity.model_name}}_params)

          return render_error("Failed to update {{titleize (humanize entity.model_name)}}", row.errors.full_messages)
        end

        render_error("Could not find {{titleize (humanize entity.model_name)}}")
      end

      # Delete {{camel entity.model_name}}
      #
      # Samples:
      #     (DELETE) http://localhost:{{settings.RailsPort}}/api/v1/{{snake entity.name_plural}}/id
      def destroy
        # log.block "{{camel entity.model_name}} - Destroy"

        row = {{camel entity.model_name}}.find_by(id: params[:id])

        if row.present?
          return render_success_destroy(row, "{{titleize (humanize entity.model_name)}} Deleted") if row.destroy

          return render_error("Failed to delete {{titleize (humanize entity.model_name)}}", row.errors.full_messages)
        end

        render_error("Could not find {{titleize (humanize entity.model_name)}}")
      end

      private

      # Strong params for updating {{camel entity.model_name}}
      def update_{{snake entity.model_name}}_params
        # http://blog.trackets.com/2013/08/17/strong-parameters-by-example.html

        # Only Change this if you want to have different params for create and update
        create_{{snake entity.model_name}}_params
      end

      # Strong params for creating {{camel entity.model_name}}
      def create_{{snake entity.model_name}}_params
        params.require(:{{snake entity.model_name}}).permit({{#each relations}}{{#if this.type '==' 'one_to_one'}}:{{snake this.field}},{{/if}}{{/each}}{{#each rows_and_virtual}}
          :{{snake this.name}}{{#if this.db_type '==' 'jsonb'}}, {{snake this.name}}: {}{{/if}}{{#if @last}}{{else}}, {{/if}}{{/each}})
      end
    end
  end
end
