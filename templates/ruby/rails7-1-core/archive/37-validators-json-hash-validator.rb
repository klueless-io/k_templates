# frozen_string_literal: true

# JSON Hash Validator
class JsonHashValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "is not valid json" unless valid_json(value)
  end

  private

  def valid_json(value)
    return true     if value.nil?

    return true     if value.instance_of?(Hash)

    false
  end
end
