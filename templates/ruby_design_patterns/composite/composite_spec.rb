# frozen_string_literal: true

require 'spec_helper'

module TestComposite
  class {{camel name}}Base
    include {{namespace}}::{{camel name}}

    def initialize
      @parent = nil
      @{{children_name_plural}} = []
    end
  end

  class Parent{{camel name}} < TestComposite::{{camel name}}Base
    def add_{{children_name}}({{children_name}}_klass)
      @{{children_name_plural}} << {{children_name}}_klass.new(self)
    end
  end

  class Child{{camel name}} < TestComposite::{{camel name}}Base
    def initialize(parent)
      super()
      attach_parent(parent)
    end
  end
end

RSpec.describe {{namespace}}::{{camel name}} do
  subject { instance }

  let(:instance) { TestComposite::{{camel name}}Base.new }

  it { is_expected.to respond_to(:parent) }
  it { is_expected.to respond_to(:attach_parent) }
  it { is_expected.to respond_to(:navigate_parent) }
  it { is_expected.to respond_to(:{{children_name_plural}}) }

  context 'when component is Parent' do
    let(:instance) { parent }

    let(:parent) { TestComposite::Parent{{camel name}}.new }

    context '.parent' do
      subject { instance.parent }

      it { is_expected.to be_nil }
    end

    context 'when parent adds child' do
      before { instance.add_{{children_name}}(TestComposite::Child{{camel name}}) }

      context '.{{children_name_plural}}' do
        subject { instance.{{children_name_plural}} }

        it { is_expected.not_to be_nil }
        it { is_expected.to have_attributes(length: 1) }

        context '.parent' do
          subject { instance.parent }

          it { is_expected.to be_nil }
        end

        context '.navigate_parent' do
          subject { instance.navigate_parent }

          it { is_expected.to be_a(TestComposite::Parent{{camel name}}) }
          it { is_expected.to eq(parent) }
        end

        context '.root?' do
          subject { instance.root? }

          it { is_expected.to be_truthy }
        end

        context '.{{children_name_plural}}.first' do
          subject { first_{{children_name}} }

          let(:first_{{children_name}}) { instance.{{children_name_plural}}.first }

          it { is_expected.to be_a(TestComposite::Child{{camel name}}) }

          context '.root?' do
            subject { first_{{children_name}}.root? }

            it { is_expected.to be_falsey }
          end

          context '.{{children_name_plural}}.first.parent' do
            subject { first_{{children_name}}.parent }

            it { is_expected.to be_a(TestComposite::Parent{{camel name}}) }
            it { is_expected.to eq(parent) }
          end

          context '.{{children_name_plural}}.first.navigate_parent' do
            subject { first_{{children_name}}.navigate_parent }

            it { is_expected.to be_a(TestComposite::Parent{{camel name}}) }
            it { is_expected.to eq(parent) }
          end
        end
      end
    end
  end

  context 'when component is Child{{camel name}}' do
    let(:instance) { child }
    let(:parent) { TestComposite::Parent{{camel name}}.new }
    let(:child) { TestComposite::Child{{camel name}}.new(parent) }

    context '.parent' do
      subject { instance.parent }

      it { is_expected.not_to be_nil }
      it { is_expected.to be_a(TestComposite::Parent{{camel name}}) }
    end

    context '.{{children_name_plural}}' do
      subject { instance.{{children_name_plural}} }

      it { is_expected.not_to be_nil }
      it { is_expected.to have_attributes(length: 0) }
    end
  end
end
