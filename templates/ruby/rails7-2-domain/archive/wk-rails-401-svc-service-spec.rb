# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

# ----------------------------------------------------------------------
# {{camel entity.model_name}}Service
#
# Performs feature or domain specific business logic
#
# Tests can be light weight because much of the business logic is either
# light weight or delegated to other classes that have their own tests
# ----------------------------------------------------------------------
describe {{camel entity.model_name}}Service do
  before(:each) do
    FactoryBot.reload
  end

  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context "factories" do
    before(:each) do
      full_data_set
    end

    describe "print" do
      if AppService::SHOULD_PRINT_TEST_DATA
        it "should print test data" do
          print_data_set

          expect(1).to eq(1)
        end
      end
    end
  end

  # --------------------------------------------------------------------------------
  # {{camel entity.name_plural}} Service - Some Context
  # --------------------------------------------------------------------------------

  context "some context, e.g. api" do
    before(:each) do
      FactoryBot.reload

      full_data_set
    end

    describe "some sub group action" do
      it "should do something" do
        expect({{camel entity.model_name}}.count).to be > 0

        result = {{camel entity.model_name}}Service.some_action

        expect(result).to eq("light weight action")
        # print_data_set
      end
    end
  end

  # ----------------------------------------------------------------------
  # {{camel entity.name_plural}}: Data Setup and Printing
  # ----------------------------------------------------------------------

  # NOTE: Refactor opportunity :: Test Data creation patterns are being
  #       repeated in services, controllers and model specs for the same
  #       table name and so these methods below should be moved out into
  #       a Test data helper section

  # data set for create unit tests
  def data_set_for_create
    {{#each settings.parent_dependencies}}
    td_{{snake this}}
    {{/each}}
    {{#each relations}}
    {{#if (eq type 'one_to_one')}}
    td_{{snake this.name_plural}}
{{/if}}
{{/each}}
  end

  # data set for general unit tests
  def full_data_set
    data_set_for_create

    td_{{snake entity.name_plural}}
  end

  def full_data_set_for_query
    td_{{snake entity.name_plural}}_for_query
  end

  def print_data_set
    return unless AppService.debug?

    {{#each settings.parent_dependencies}}
    p_{{snake this}}_as_table
      {{/each}}
      {{#each relations}}
      {{#if (eq type 'one_to_one')}}
    p_{{snake this.name_plural}}_as_table
{{/if}}
      {{/each}}
    p_{{snake entity.name_plural}}_as_table
    # p_{{snake entity.name_plural}}(nil, "detailed")
  end
end
