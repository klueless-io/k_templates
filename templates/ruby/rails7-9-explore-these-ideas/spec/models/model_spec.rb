# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe {{camelU entity.name}}, type: :model do
  before(:each) do
    FactoryBot.reload
  end

  subject{ instance }
  
  let(:instance) { described_class.new }

  context "factories" do
    # here you can check that your test data is valid
  end

  context 'cardinality' do
    # tests for relationship go here
  end

  context 'validations' do
    # tests for attribute validation go here
  end

  context 'scopes' do
    describe 'default_scope' do
    end

    # one per scope
    describe 'custom_scope' do
    end
  end


  context 'business' do
    # tests for custom business logic goes here
  end
end

# == Schema Information
#
# Table name: {{entity.name}}
#
#  id                            :bigint         not null, primary key
{{#each entity.columns}}
#  {{padr ./name 30}}:{{padr ./type 15}}
{{/each}}
#
# Cardinality
#
{{#each entity.foreign}}
#  {{padr ./name 30}}:{{padr ./type 15}}foreign: {{./table}}
{{/each}}
