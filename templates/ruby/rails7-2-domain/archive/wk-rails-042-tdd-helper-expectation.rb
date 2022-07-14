# frozen_string_literal: true

# Reusable expect helpers for {{camel entity.name_plural}}
module Expectation
  # # Expect Something for {{camel entity.name_plural}}
  # #
  # # @example
  # #
  # # {{snake entity.model_name}}_expect_something('input', {
  # #   some_field: expected_output
  # # })
  # #
  # # @param [string] input This is some input
  # # @param [Hash] expected This is some expected output
  # # @param [Boolean] is_debug Would you like to print test data for debugging purposes, default = false
  # def {{snake entity.model_name}}_expect_something(input, expected_output, is_debug: false)
  #   # send(:"td_#{model_key}")                                          # Run standard test data creation for this model
  #   # send(:"p_#{model_key}_as_table")               if is_debug        # Print the test data if you need help with debugging

  #   expect(input).to eq(expected_output)
  # end
end
