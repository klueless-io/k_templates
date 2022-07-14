# frozen_string_literal: true

json.partial! "api/v1/result", result: result
json.page page

json.rows rows, partial: "row", as: :row
