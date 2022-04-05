# frozen_string_literal: true

require 'spec_helper'

RSpec.describe {{model.namespaces}}::{{camel model.name}} do
  subject { instance }

  let(:instance) { described_class.new }

  it { is_expected.not_to be_nil }
end
