# frozen_string_literal: true

require 'spec_helper'

RSpec.describe {{#each model.namespaces}}{{camel .}}::{{/each}}{{camel model.name}} do
  subject { instance }

  let(:instance) { described_class.new }

  it { is_expected.not_to be_nil }

{{#each model.fields}}
  context '.{{./name}}' do
    subject { instance.{{./name}} }

    fit { is_expected.to be_nil }
  end

{{/each}}

{{#each model.methods}}
  context '.{{./name}}' do
    subject { instance.{{./name}} }

    fit { is_expected.to be_nil }
  end

{{/each}}

end
