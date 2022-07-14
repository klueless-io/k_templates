{{#*inline "defaultScope"}}{{#if entity.rails_model.default_scope}}
  default_scope {{{entity.rails_model.default_scope}}}
{{/if}}{{/inline~}}
{{#*inline "missing"}}
  # TODO: full coverage list
  # validates :action, MISSING OPTIONS
  # before_create :update_source_created_at
  # before_save :update_source_created_at
  # before_destroy :cleanup_temporary_files
  # after_create :update_last_contact
  # after_save :update_last_contact
  # after_destroy :remove_from_s3
  # after_destroy { |record| record.tasks.update_all(task_type_id: nil) }
  # attr_accessor :file
  # quoted data: belongs_to :user, class_name: User, foreign_key: id, primary_key: sales_rep_user_id
  # delegate :tenant, to: :meeting, allow_nil: true
  # acts_as_readable on: :created_at
  # enum status: { Live: 1, Draft: 2, Locked: 3 }
  # acts_as_list scope: :lead_type, column: "version_no"
{{/inline~}}
{{#*inline "validations"}}
{{#if (or entity.validates entity.validate)}}

  # Validations
{{/if}}
{{#each entity.validates}}
  validates   :{{./name}}{{#if presence}}, presence: {{{format_presence}}}{{/if}}{{#if length}}, length: {{{format_length}}}{{/if}}{{#if format}}, format: {{{format_format}}}{{/if}}{{#if unless}}, unless: {{{format_unless}}}{{/if}}
{{/each}}
{{#each entity.validate}}
  validate    {{#each methods}}:{{.}}{{#if @last}}{{else}}, {{/if}}{{/each}}{{#if on}}, on: {{{format_on}}}{{/if}}
{{/each}}
{{~/inline}}
{{#*inline "scopes"}}
{{#if entity.rails_model.scopes}}

  # Scopes
{{#each entity.rails_model.scopes}}
  {{#if ./code_duplicate}}# {{/if}}scope     :{{./name}}, {{{./scope}}}
{{/each}}{{/if}}
{{~/inline}}
{{#*inline "belongsTo"}}
{{#if entity.belongs_to}}

  # Belongs To
{{#each entity.belongs_to}}
  {{#if ./code_duplicate}}# {{/if}}belongs_to :{{padr ./name 30}}{{#if inverse_of}}, inverse_of: :{{inverse_of}}{{/if}}{{#if ./polymorphic}}, polymorphic: {{./polymorphic}}{{/if}}{{#if ./class_name}}, class_name: "{{./class_name}}"{{/if}}{{#if ./foreign_key}}, foreign_key: "{{./foreign_key}}"{{/if}}{{#if ./primary_key}}, primary_key: "{{./primary_key}}"{{/if}}{{#if ./with_deleted}}# , with_deleted: {{./with_deleted}} # (only needed if using with paranoid){{/if}}
{{/each}}{{/if}}
{{~/inline}}
{{#*inline "hasOne"}}
{{#if entity.has_one}}

  # Has one
{{#each entity.has_one}}
  {{#if ./code_duplicate}}# {{/if}}has_one   :{{padr ./name 30}}{{#if class_name}}, class_name: "{{class_name}}"{{/if}}{{#if ./foreign_key}}, foreign_key: "{{./foreign_key}}"{{/if}}{{#if ./primary_key}}, primary_key: "{{./primary_key}}"{{/if}}
{{/each}}{{/if}}
{{~/inline}}
{{#*inline "hasMany"}}
{{#if entity.has_many}}

  # Has many
{{#each entity.has_many}}
  {{#if ./code_duplicate}}# {{/if}}has_many  :{{padr ./name 30}}{{#if ./inverse_of}}, inverse_of: :{{./inverse_of}}{{/if}}{{#if ./as}}, as: :{{./as}}{{/if}}{{#if ./class_name}}, class_name: "{{./class_name}}"{{/if}}{{#if ./foreign_key}}, foreign_key: "{{./foreign_key}}"{{/if}}{{#if ./primary_key}}, primary_key: "{{./primary_key}}"{{/if}}{{#if ./dependant}}, dependant: :{{./dependant}}{{/if}}{{#if ./through}}, through: :{{./through}}{{/if}}{{#if ./source}}, source: :{{./source}}{{/if}}
{{/each}}{{/if}}
{{~/inline}}
{{#*inline "publicMethods"}}
{{#if entity.rails_model.public_instance_methods}}

  # Public API
{{#each entity.rails_model.public_instance_methods}}
  def {{{./name}}}; end{{#if @last}}{{else}}

{{/if}}
{{/each}}{{/if}}
{{/inline}}
{{#*inline "privateMethods"}}
{{#if entity.rails_model.private_instance_methods}}

  private

{{#each entity.rails_model.private_instance_methods}}
  def {{{./name}}}; end{{#if @last}}{{else}}

{{/if}}
{{/each}}{{/if}}
{{/inline}}
{{#*inline "classMethods"}}
{{#if entity.rails_model.public_class_methods}}

  class << self
    # Class methods maybe extractable out into their own query/action classes
{{#each entity.rails_model.public_class_methods}}
    def {{{./name}}}; end{{#if @last}}{{else}}

{{/if}}
{{/each}}

  end{{/if}}
{{/inline}}
# frozen_string_literal: true

class {{camelU entity.name}} < ActiveRecord::Base
{{~> defaultScope}}
{{> validations}}
{{> scopes}}
{{> belongsTo}}
{{> hasOne}}
{{> hasMany}}
{{> publicMethods}}
{{> classMethods}}
{{> privateMethods}}
{{> missing}}
end
