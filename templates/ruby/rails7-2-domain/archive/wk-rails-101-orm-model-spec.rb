{{#*inline "make_value"}}
{{~#if (eq column.db_type 'jsonb')}}
{ a: "{{column.name}}" }
{{~else if (eq column.name settings.main_key)}}
"???"
{{~else if (eq column.type 'string')}}
"{{snake column.name}}{{alpha_suffix}}"
{{~else if (eq column.type 'text')}}
"{{snake column.name}}{{alpha_suffix}}"
{{~else if (eq column.type 'integer')}}
{{num}}
{{~else if (eq column.type 'float')}}
{{num}}.{{num}}
{{~else if (eq column.type 'decimal')}}
{{num}}.{{num}}
{{~else if (eq column.type 'boolean')}}
{{bool}}
{{~else if (eq column.type 'date')}}
Date.parse("0{{num}} Jan 2017")
{{~else if (eq column.type 'datetime')}}
Date.parse("0{{num}} Jan 2017")
{{/if}}
{{/inline}}
# frozen_string_literal: true

require {{{q}}}rails_helper{{{q}}}
require {{{q}}}spec_helper{{{q}}}

RSpec.describe {{camel entity.model_name}}, type: :model do
  include_examples :factory_data
  before(:each) do
    FactoryBot.reload
  end

  let(:{{snake entity.model_name}}_{{snake entity.trait1}}) { FactoryBot.create(:{{snake entity.model_name}}, :{{snake entity.trait1}}{{#each entity.has_one}}, {{snake ./name}}: {{snake ./related_entity.name}}_{{snake ./related_entity.trait1}}{{/each}}{{#each entity.belongs_to}}, {{snake ./name}}: {{snake ./related_entity.name}}_{{snake ./related_entity.trait1}}{{/each}}) }
  let(:{{snake entity.model_name}}_{{snake entity.trait2}}) { FactoryBot.create(:{{snake entity.model_name}}, :{{snake entity.trait2}}{{#each entity.has_one}}, {{snake ./name}}: {{snake ./related_entity.name}}_{{snake ./related_entity.trait2}}{{/each}}{{#each entity.belongs_to}}, {{snake ./name}}: {{snake ./related_entity.name}}_{{snake ./related_entity.trait2}}{{/each}}) }

  let(:described_model) { {{snake entity.model_name}}_{{snake entity.trait1}} }
  {{#if entity.belongs_to}}
  # belongs to dependencies
  {{#each entity.belongs_to}}
  let(:{{snake this.related_entity.name}}_{{snake this.related_entity.trait1}}) { FactoryBot.build(:{{snake this.related_entity.name}}, :{{snake this.related_entity.trait1}}) }
  let(:{{snake this.related_entity.name}}_{{snake this.related_entity.trait2}}) { FactoryBot.build(:{{snake this.related_entity.name}}, :{{snake this.related_entity.trait2}}) }
  {{/each}}
  {{/if}}

  {{#if entity.has_one}}
  # has one dependencies
  {{#each entity.has_one}}
  let(:{{snake this.name}}_{{snake this.trait1}}) { FactoryBot.build(:{{snake this.name}}, :{{snake this.trait1}}) }
  let(:{{snake this.name}}_{{snake this.trait2}}) { FactoryBot.build(:{{snake this.name}}, :{{snake this.trait2}}) }
  {{/each}}
  {{/if}}
  describe {{{q}}}#find{{{q}}} do
    context {{{q}}}when row ID exists{{{q}}} do
      before(:each) { described_model }

      let(:found) { described_class.find(described_model.id) }

      it {{{q}}}should find by id{{{q}}} do
        expect(found.id).to eq(described_model.id)
      end
      {{#if entity.has_one}}
      describe {{{q}}}#has_one{{{q}}} do
        {{#each entity.has_one}}
        it {{{../q}}}should have one {{downcase (titleize ./name)}}{{{../q}}} do
          expect(found.{{snake ./name}}).to eq({{snake this.related_entity.name}}_{{snake this.related_entity.trait1}})
        end
        {{/each}}
      end
      {{/if}}
    end
  end

  describe {{{q}}}#create{{{q}}} do
    let(:create) { described_class.new(attributes) }

    {{#if entity.columns_data_required}}
    let(:required_data_values) do
      {
    {{#each entity.columns_data_required}}
        {{snake ./name}}: {{> make_value column=. settings=settings num=1 bool=true}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    {{#if entity.columns_data_optional}}
    let(:optional_data_values) do
      {
    {{#each entity.columns_data_optional}}
        {{snake ./name}}: {{> make_value column=. settings=settings num=1 bool=true}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    {{#if (and false entity.columns_virtual)}}
    let(:virtual_columns) do
      {
    {{#each entity.columns_virtual}}
        {{snake ./name}}: {{> make_value column=. settings=settings num=1 bool=true}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    {{#if entity.has_one}}
    let(:has_one_values) do
      {
    {{#each entity.has_one}}
        {{snake ./name}}: {{snake ./related_entity.name}}_{{snake ./related_entity.trait1}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    {{#if entity.belongs_to}}
    let(:belongs_to_values) do
      {
    {{#each entity.belongs_to}}
        {{snake ./name}}: {{snake ./related_entity.name}}_{{snake ./related_entity.trait1}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    let(:all_data_values) { {}{{#if entity.columns_data_required}}.merge(required_data_values){{/if}}{{#if entity.columns_data_optional}}.merge(optional_data_values){{/if}}{{#if (and false entity.columns_data_virtual)}}.merge(virtual_columns){{/if}} }
    let(:nil_data_values) { all_data_values.keys.map { |key| [key, nil] }.to_h }

    describe {{{q}}}happy path :){{{q}}} do
      context {{{q}}}when creating a row{{{q}}} do
        context {{{q}}}with valid data values{{{q}}} do
          context {{{q}}}and valid relationships{{{q}}} do
            let(:attributes) { all_data_values{{#if entity.has_one}}.merge(has_one_values){{/if}}{{#if entity.belongs_to}}.merge(belongs_to_values){{/if}} }

            it {{{q}}}should create a new row{{{q}}} do
              expect { create.save }
                .to change { described_class.count }.by(1)
            end

            {{#if entity.has_one}}
            describe {{{q}}}#has_one{{{q}}} do
              before(:each) { create.save }
              {{#each entity.has_one}}
              it {{{../q}}}should have one {{downcase (titleize ./name)}}{{{../q}}} do
                expect(create.{{snake ./name}}).to eq({{snake this.related_entity.name}}_{{snake this.related_entity.trait1}})
              end
              {{/each}}
            end
            {{/if}}
            {{#if entity.belongs_to}}
            describe {{{q}}}#belongs_to{{{q}}} do
              {{#if false}}
              # before(:each) do
              #   # attach any paired belongs_to (bi-directional)
              #   create.enterprise.default_group = create
              #   create.save
              # end
              {{/if}}
              {{#each entity.belongs_to}}
              it {{{../q}}}should belong to {{downcase (titleize ./name)}}{{{../q}}} do
                expect(create.{{snake ./name}}).to eq({{snake this.related_entity.name}}_{{snake this.related_entity.trait1}})
              end
              {{/each}}
            end
            {{/if}}
          end
        end
        {{#if todo}}
        context {{{q}}}when creating a row with minimal data fields and all foreign key values{{{q}}} do
          # NOT APPLICABLE
        end
        {{/if}}
      end
    end

    describe {{{q}}}unhappy path :({{{q}}} do
      context {{{q}}}when misconfigured{{{q}}} do
        context {{{q}}}because relationships are invalid{{{q}}} do
          {{#if entity.belongs_to}}
          context {{{q}}}when belongs_to relationship is missing{{{q}}} do
            subject { create.errors.full_messages }
            before(:each) { create.save }

            let(:attributes) { all_data_values }

            {{#each entity.belongs_to}}
            it { is_expected.to include({{{../q}}}{{titleize ./name}} must exist{{{../q}}}) }

            {{/each}}
          end
          {{^}}
          # no relationships for belongs_to
          {{/if}}
        end
        {{#if false}}
        context {{{q}}}because data columns are missing{{{q}}} do
          let(:attributes) { {}{{#if entity.belongs_to}}.merge(belongs_to_values){{/if}} }

          # xit {{{q}}}should not create a new row{{{q}}} do
          #   expect { create.save }
          #     .to change { described_class.count }.by(0)
          # end
        end
        
        context {{{q}}}because data columns are nil{{{q}}} do
          let(:attributes) { nil_data_values{{#if entity.belongs_to}}.merge(belongs_to_values){{/if}} }

          # xit {{{q}}}should fail to create new row{{{q}}} do
          #   expect { create.save }
          #     .to change { described_class.count }.by(0)
          #   # .to raise_error(ActiveRecord::NotNullViolation)
          # end
        end
{{/if}}
      end
    end
  end

  describe {{{q}}}#update{{{q}}} do
    {{#if entity.columns_data_required}}
    let(:required_data_values) do
      {
    {{#each entity.columns_data_required}}
        {{snake ./name}}: {{> make_value column=. settings=settings num=9 bool=false alpha_suffix='+updated'}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    {{#if entity.columns_data_optional}}
    let(:optional_data_values) do
      {
    {{#each entity.columns_data_optional}}
        {{snake ./name}}: {{> make_value column=. settings=settings num=9 bool=false alpha_suffix='+updated'}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    {{#if (and false entity.columns_virtual)}}
    let(:virtual_columns) do
      {
    {{#each entity.columns_virtual}}
        {{snake ./name}}: {{> make_value column=. settings=settings num=9 bool=false alpha_suffix='+updated'}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    {{#if entity.has_one}}
    let(:has_one_values) do
      {
    {{#each entity.has_one}}
        {{snake ./name}}: {{snake ./related_entity.name}}_{{snake ./related_entity.trait1}}{{#if @last}}{{^}},{{/if}}
    {{/each}}
      }
    end
    {{/if}}
    let(:all_data_values) { {}{{#if entity.columns_data_required}}.merge(required_data_values){{/if}}{{#if entity.columns_data_optional}}.merge(optional_data_values){{/if}}{{#if (and false entity.columns_data_virtual )}}.merge(virtual_columns){{/if}} }
    let(:nil_data_values) { all_data_values.keys.map { |key| [key, nil] }.to_h }

    let(:update) { described_model }

    describe {{{q}}}happy path :){{{q}}} do
      context {{{q}}}when data fields are valid{{{q}}} do
        let(:attributes) { all_data_values }

        describe ".valid?" do
          before(:each) { update.assign_attributes(attributes) }

          it { expect(update.valid?).to be_truthy }
        end

        describe ".save" do
          it {{{q}}}values should change{{{q}}} do
            expect do
              update.assign_attributes(attributes)
              update.save
              update.reload
            end
            .to  change { update.updated_at }
            {{#if entity.main_key}}.and change { update.{{entity.main_key}} }.to({{{q}}}{{entity.main_key}}+updated{{{q}}}) # you can check specific fields{{/if}}
          end
        end
      end
    end
    {{#if false}}
    describe {{{q}}}unhappy path :({{{q}}} do
      context {{{q}}}data fields with nil{{{q}}} do
        before(:each) { update.assign_attributes(attributes) }

        let(:attributes) { nil_data_values }

        # describe ".valid?" do
        #   # this test does not work for {{camel entity.model_name}}
        #   xit { expect(update.valid?).to be_falsey }
        # end

        describe ".save" do
          before(:each) { update.assign_attributes(attributes) }

          # this test does works for Enterprise, but not for Group
          # xit {{{q}}}should fail to save{{{q}}} do
          #   expect { update.save }.to raise_error(ActiveRecord::NotNullViolation)
          # end
        end
      end

      context {{{q}}}when updating foreign keys with nil{{{q}}} do
        # NOT APPLICABLE
      end
    end
{{/if}}
  end

  describe {{{q}}}#destroy{{{q}}} do
    context {{{q}}}when delete by id{{{q}}} do
      before(:each) { described_model }

      it {{{q}}}when the row exists{{{q}}} do
        expect { described_class.destroy(described_model.id) }
          .to change { described_class.count }.by(-1)
      end
    end
    context {{{q}}}when delete by multiple ids{{{q}}} do
      before(:each) { full_data_set }

      it {{{q}}}should rows with valid ids exist{{{q}}} do
        expect { described_class.where(id: [{{snake entity.model_name}}_{{snake entity.trait1}}.id, {{snake entity.model_name}}_{{snake entity.trait2}}.id]).destroy_all }
        .to change { described_class.count }.by(-2)
      end
    end
  end

  # data set for general unit tests
  def full_data_set
    {{snake entity.model_name}}_{{snake entity.trait1}}
    {{snake entity.model_name}}_{{snake entity.trait2}}
  end

  context "factories" do
    before(:each) do
      full_data_set
    end

    describe "check factory data" do
      it "validate test data" do
        print_data_set

        expect({{snake entity.model_name}}_{{snake entity.trait1}}).to_not be_nil
        expect({{snake entity.model_name}}_{{snake entity.trait2}}).to_not be_nil
      end
    end
  end

  def print_data_set
    {{#if settings.parent_dependencies}}
    # print higher level parents
    {{/if}}
    {{#each settings.parent_dependencies}}
    print_{{snake this}}_as_table
    {{/each}}
    {{#if (or entity.has_one enity.belongs_to)}}
    # print related tables
{{#each entity.has_one}}
    print_{{snake this.model_name_plural}}_as_table
{{/each}}
{{#each entity.belongs_to}}
    print_{{snake this.model_name_plural}}_as_table
{{/each}}
{{/if}}

    print_{{snake entity.name_plural}}_as_table
  end
end
