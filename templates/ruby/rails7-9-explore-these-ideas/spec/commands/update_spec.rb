# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe Commands::{{camelU model.name}}Commands::{{camelU verb}}, type: :command do
  before(:each) do
    FactoryBot.reload
  end

  let(:command) { described_class.call(user: user, {{snake model.name}}: {{snake model.name}}, **update_params) }
  let(:user) { create(:user, :admin) }
  let(:resource) { create(:{{snake model.name}}) }
  let(:update_params) { {} }

  context "argument validation" do
    describe ".messages" do
      subject { command.messages }

      context "when arguments are valid" do
        let(:update_params) { { arg: :is_good } }
        it { is_expected.to be_empty }
      end

      context "when arguments are invalid" do
        let(:update_params) { { arg: :is_bad } }
        it { is_expected.to include(fail: 'some failure message') }
      end
    end
  end

  context "update the model" do
    describe ".{{snake model.name}}" do
      subject { command.{{snake model.name}} }

      context "when given valid argument" do
        let(:update_params) { { arg: :is_good } }

        it { is_expected.to have_attributes(arg: :is_good) }
      end
    end
    # Additional tests to ensure that published events are are created
  end
end
