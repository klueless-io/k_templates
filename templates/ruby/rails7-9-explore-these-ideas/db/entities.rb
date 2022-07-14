class Entities{{camel ./klass_name}}
  include EntityMethods

  def initialize
    @entities = []

    definition

    apply_aliases
  end

  def definition
    {{#each entities}}
    entity model_name: :{{./name}},
           model_name_plural: :{{./name_plural}},
           model_exists?: {{./meta/has_old_ruby_model}},
           model_path: :'{{./meta/old_ruby_model_path}}',
           timestamp: :{{./meta/timestamp_type}}{{#if ./default_scope}},
           default_scope: "{{./default_scope}}"{{/if}} do

    {{#if ../show_stats}}
      statistics do
        code_counts     flag: :{{./meta/code_counts/flag}}, instance: {{./meta/code_counts/instance}}, public_instance: {{./meta/code_counts/public_instance}}, private_instance: {{./meta/code_counts/private_instance}}, class: {{./meta/code_counts/class}}, public_class: {{./meta/code_counts/public_class}}, private_class: {{./meta/code_counts/private_class}}
        code_dsl_counts scopes: {{./meta/code_dsl_counts/scopes}}, has_many: {{./meta/code_dsl_counts/has_many}}, has_and_belongs_to_many: {{./meta/code_dsl_counts/has_and_belongs_to_many}}, belongs: {{./meta/code_dsl_counts/belongs}}, has_one: {{./meta/code_dsl_counts/has_one}}, validates: {{./meta/code_dsl_counts/validates}}, validate: {{./meta/code_dsl_counts/validate}}
        column_counts   flag: :{{./meta/column_counts/flag}}, all: {{./meta/column_counts/all}}, id: {{./meta/column_counts/id}}, timestamp: {{./meta/column_counts/timestamp}}, data: {{./meta/column_counts/data}}, foreign_key: {{./meta/column_counts/foreign_key}}
        row_counts      au: {{default ./meta/data_counts/au -1}}, us: {{default ./meta/data_counts/us -1}}, eu: {{default ./meta/data_counts/eu -1}}
        issues          {{#each ./meta/issues}}:{{.}}{{#if @last}}{{else}}, {{/if}}{{/each}}
      end
    {{/if}}
    {{#if ../show_columns}}{{#each data_columns}}
      column      :{{padr ./name 40}}, type: :{{padr ./type 10}}{{/each}}
      {{/if}}
    {{#if validates}}{{#each validates}}
      validates   :{{padr ./name 40}}{{#if ./options}}, {{{./options}}}{{/if}}{{/each}}{{/if}}
    {{#if validate}}{{#each validate}}
      validate    {{./line}}{{/each}}{{/if}}
    {{#if ../show_relations}}{{#each foreign_columns}}
      foreign     :{{padr ./name 40}}, type: :{{padr ./type 10}}, table: :{{padr ./foreign_table 20}}, belongs_to: :{{padr ./belongs_to 20}}{{/each}}
      {{/if}}
    {{#if ../show_belongs}}{{#each belongs}}
      belongs_to  :{{padr ./name 40}}{{#if ./options}}, {{{./options}}}{{/if}}{{#if ./code_duplicate}}, code_duplicate: {{./code_duplicate}}{{/if}}{{/each}}
      {{/if}}
    {{#if ../show_has_one}}{{#each has_one}}
      has_one     :{{padr ./name 40}}{{#if ./options}}, {{{./options}}}{{/if}}{{#if ./code_duplicate}}, code_duplicate: {{./code_duplicate}}{{/if}}{{/each}}
      {{/if}}
    {{#if ../show_has_many}}{{#each has_many}}
      has_many    :{{padr ./name 40}}{{#if ./options}}, {{{./options}}}{{/if}}{{#if ./code_duplicate}}, code_duplicate: {{./code_duplicate}}{{/if}}{{/each}}
      {{/if}}
    {{#if ../show_has_and_belongs_to_many}}{{#each has_and_belongs_to_many}}
      has_and_belongs_to_many :{{padr ./name 40}}{{#if ./options}}, {{{./options}}}{{/if}}{{#if ./code_duplicate}}, code_duplicate: {{./code_duplicate}}{{/if}}{{/each}}
      {{/if}}
    {{#if ../show_scopes}}{{#each scopes}}
      scope       :{{padr ./name 40}}, scope: '{{{./scope}}}'{{/each}}
      {{/if}}
    {{#if ../show_methods}}
      public_instance_methods({{#if public_instance_methods}}{{#each public_instance_methods}}
        { name: :{{padr ./name 40}}, arguments: '{{{./arguments}}}' }{{#if @last}}){{else}},{{/if}}{{/each}}
      {{^}}){{/if}}
    
      private_instance_methods({{#if private_instance_methods}}{{#each private_instance_methods}}
        { name: :{{padr ./name 40}}, arguments: '{{{./arguments}}}' }{{#if @last}}){{else}},{{/if}}{{/each}}
      {{^}}){{/if}}

      public_class_methods({{#if public_class_methods}}{{#each public_class_methods}}
        { name: :{{padr ./name 40}}, arguments: '{{{./arguments}}}' }{{#if @last}}){{else}},{{/if}}{{/each}}
      {{^}}){{/if}}
    {{/if}}
    end

    {{/each}}
  end
end
