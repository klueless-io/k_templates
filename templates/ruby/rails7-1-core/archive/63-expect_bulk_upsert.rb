# frozen_string_literal: true

require "spec_helper"

module Expectation
  # Expect Bulk Upsert contains helpers that can be reused across different models
  # that need support for bulk inserting or updating

  # Ensure that a bulk_upsert can destroy and reset a table correctly
  #
  # @example
  #
  # expect_bulk_upsert_to_destroy_and_resequence(Project, "Projects", upsert, {
  #   active: true,
  #   name: "name",
  #   data: "data"}
  # )
  #
  # To ensure that the "Project" table can be reset, you can pass in these paramaters
  #
  # @param [ActiveRelation] relation What model are you testing
  # @param [string] model_key This is a (by convention) pluralized model name that can be used to use pre-existing test data and print data routines
  # @param [BaseBulkUpsert] bulk_upsert What upserter are you testing, this class should extend BaseBulkUpsert
  # @param [Hash] sample_data Sample data to create the model you are testing
  # @param [Boolean] is_debug Would you like to print test data for debugging purposes, default = false
  # rubocop:disable Metrics/AbcSize
  def expect_bulk_upsert_to_destroy_and_resequence(relation, model_key, bulk_upsert, sample_data, is_debug: false)
    expect(relation.count).to eq(0)                                   # Make sure we start with no data

    send(:"td_#{model_key}")                                          # Run standard test data creation for this model

    send(:"p_#{model_key}_as_table") if is_debug

    # Need at least 2 records to know that we have a sequence > 1
    # row_1_and_2 = relation.order(:id).limit(2)

    # expect(row_1_and_2[0].id).to eq(1)
    # expect(row_1_and_2[1].id).to eq(2)

    # Destroy
    bulk_upsert.destroy_and_resequence_table

    # Recreate our first record
    model = relation.create(sample_data)

    send(:"p_#{model_key}_as_table") if is_debug

    # Finally ensure we have a parsing test
    expect(model.id).to eq(1)
    expect(relation.count).to eq(1)
  end

  def expect_bulk_upsert_default_settings(bulk_upsert, table_name:, table_name_plural:, can_destroy:, single_use_unique_index:, conflict_keys:)
    expect(bulk_upsert.table_name).to eq(table_name)
    expect(bulk_upsert.table_name_plural).to eq(table_name_plural)
    expect(bulk_upsert.can_destroy_table).to eq(can_destroy)
    expect(bulk_upsert.single_use_unique_index).to eq(single_use_unique_index)
    expect(bulk_upsert.conflict_keys).to eq(conflict_keys)
  end
  # rubocop:enable Metrics/AbcSize
end
