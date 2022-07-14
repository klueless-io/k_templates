# frozen_string_literal: true

json.result do
  json.success result[:success]
  json.message result[:message]  if result[:message]
  json.errors  result[:errors]   if result[:success] == false && result[:errors]
end
