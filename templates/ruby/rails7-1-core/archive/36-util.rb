# frozen_string_literal: true

# Utility helpers
module Util
  def self.cast_to_bool(data, default: false)
    return default if data.nil?

    return data if !data.nil? == data

    if data.is_a? String
      return true if data =~ (/^(true|t|yes|y|1)$/i)

      return false if data =~ (/^(false|f|no|n|0)$/i)
    end

    default
  end

  def self.bool?(data)
    !!data == data
  end

  def self.parse_as_hash(data, symbolize: false)
    result = {}

    unless data.nil?

      case data
      when String
        result = if symbolize
                   # if you want to convert into ruby symbols then set symbolize to true
                   # see: https://stackoverflow.com/questions/1732001/what-is-the-best-way-to-convert-a-json-formatted-key-value-pair-to-ruby-hash-wit
                   Marshal.load(Marshal.dump(data))
                 else
                   JSON.parse(data)
                 end

      when Hash
        result = data

      else
        raise
      end
    end

    result
  end

  def self.parse_int(value, def_value = -1)
    return def_value if string_equivalent_of_empty_number(value)

    begin
      Integer(value)
    rescue ArgumentError
      def_value
    end
  end
end
