# frozen_string_literal: true

# Sample list of endpoints for {{camel entity.model_name}}
json.partial! "api/v1/result", result: result

json.partial! "api/v1/sample", locals: { endpoints: endpoints } if result[:success]
