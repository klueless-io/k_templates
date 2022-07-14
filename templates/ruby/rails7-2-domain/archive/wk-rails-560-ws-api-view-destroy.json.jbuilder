# frozen_string_literal: true

json.partial! "api/v1/result", result: result

json.row do
  json.id id
end
