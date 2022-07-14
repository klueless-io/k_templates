# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

# Gs{{camel entity.model_name}}
#
# Plain Old Object for reading data from from Google Sheet for GsGnModel
describe Gsheet::Gs{{camel entity.model_name}} do
  before(:each) do
    FactoryBot.reload
  end

  context "setup" do
    describe "instantiate" do
      it "should instantiate class" do
        expect(Gsheet::Gs{{camel entity.model_name}}.new).to_not be_nil
      end

      it "should instantiate class with type safe data" do
        model = Gsheet::Gs{{camel entity.model_name}}.new({
          sample_key: "sample",
          sync_{{snake entity.main_key}}: "{{snake entity.main_key}}",
          {{#each relations_one_to_one}}
          sync_fk_{{this.name}}: "{{this.td_key1}}",
{{/each}}

        {{#each rows_and_virtual}}
        {{#if (eq type 'primary_key')}}
          {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
        {{else if (eq type 'foreign_key')}}
          {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
        {{else if (eq type 'integer')}}
          {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
        {{else if (eq type 'boolean')}}
          {{snake this.name}}: true{{#if @last}}{{else}},{{/if}}
        {{else if (eq type 'date')}}
          {{snake this.name}}: DateTime.now{{#if @last}}{{else}},{{/if}}
        {{else}}
          {{snake this.name}}: "{{snake this.name}}{{#if (eq format_type 'email')}}@email.com{{/if}}"{{#if @last}}{{else}},{{/if}}
{{/if}}
            {{/each}}
        })

        # Keys
        expect(model.sample_key).to eq("sample")
        {{#each relations_one_to_one}}
        expect(model.sync_fk_{{this.name}}).to eq("{{this.td_key1}}")
{{/each}}
        expect(model.sync_{{snake entity.main_key}}).to eq("{{snake entity.main_key}}")

        # Model Data
      {{#each rows_and_virtual}}
      {{#if (eq type 'primary_key')}}
        expect(model.{{snake this.name}}).to eq(1)
      {{else if (eq type 'foreign_key')}}
        expect(model.{{snake this.name}}).to eq(1)
      {{else if (eq type 'integer')}}
        expect(model.{{snake this.name}}).to eq(1)
      {{else if (eq type 'boolean')}}
        expect(model.{{snake this.name}}).to eq(true)
      {{else if (eq type 'date')}}
        expect(model.{{snake this.name}}).to eq(DateTime.now)
      {{else}}
        expect(model.{{snake this.name}}).to eq("{{snake this.name}}{{#if (eq format_type 'email')}}@email.com{{/if}}")
{{/if}}
      {{/each}}
      end
    end
  end
end
