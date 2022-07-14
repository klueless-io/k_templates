# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe Commands::{{camelU model.name}}Commands::{{camelU verb}}, type: :command do
  before(:each) do
    FactoryBot.reload
  end

  let(:command) { described_class.call(user: user, {{snake model.name}}: {{snake model.name}}) }
  let(:user) { create(:user, :admin) }
  let(:resource) { create(:{{snake model.name}}) }

  context "delete the model" do
    it { is_expected.to run_successfully }

    it { expect { command } }.to change(Address.with_deleted, :count).from(1).to(0) }
    # Additional tests to ensure that published events are are created
  end

  context "delete the model" do
    it { is_expected.to run_successfully }
    
    it { expect { command } }.to change({{camelU model.name}}.with_deleted, :count).from(1).to(0) }
    # Additional tests to ensure that published events are are created
  end
end
