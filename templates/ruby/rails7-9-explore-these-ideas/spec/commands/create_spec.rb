# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe Commands::{{camelU model.name}}Commands::{{camelU verb}}, type: :command do
  before(:each) do
    FactoryBot.reload
  end

  let(:command) { described_class.call(user: user, {{snake model.name}}: {{snake model.name}}, **create_params) }
  let(:user) { create(:user, :admin) }
  let(:resource) { create(:{{snake model.name}}) }
  let(:create_params) { {} }

  # {nooutput}}
  # Why user?
  # 1. Providing user context allow us to include instrumentation
  # 2. It also allows us to have role based checking on the command,
  #    but
  #    It is generally advised to do your role based checking on the external
  #    boundaries only, e.g controller actions
  context "user role validation" do
    context "when basic user" do
    end
    context "when admin user" do
    end
  end
  # {/nooutput}}

  context "argument validation" do
    describe ".messages" do
      subject { command.messages }

      context "when arguments are valid" do
        let(:create_params) { { arg: :is_good } }
        it { is_expected.to be_empty }
      end

      context "when arguments are invalid" do
        let(:create_params) { { arg: :is_bad } }
        it { is_expected.to include(fail: 'some failure message') }
      end
    end
  end

  context "create the model" do
    describe ".{{snake model.name}}" do
      subject { command.{{snake model.name}} }

      context "when given valid argument" do
        let(:create_params) { { arg: :is_good } }

        it { is_expected.to have_attributes(arg: :is_good) }

        it { expect { command } }.to change({{camelU model.name}}, :count).from(0).to(1) }
      end
    end
    # Additional tests to ensure that published events are are created
  end
end
