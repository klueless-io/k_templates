{{#*inline "defaultScope"}}{{#if entity.default_scope}}
  default_scope {{entity.default_scope}}
{{/if}}{{/inline}}
{{#*inline "missing"}}
  # ToDo:
  # validates :action, presence: true
  # reverse the escaping on default_scope
  # before_create :update_source_created_at
  # before_save :update_source_created_at
  # after_create :update_last_contact
  # after_save :update_last_contact
  # after_destroy :remove_from_s3
  # attr_accessor :file
  # missing options: scope :by_tenant, -> (tenant) { where('assets.tenant_id = ? OR assets.global = true', tenant.id) }
  # quoted data: belongs_to :user, class_name: User, foreign_key: id, primary_key: sales_rep_user_id
  # delegate :tenant, to: :meeting, allow_nil: true
  # acts_as_readable on: :created_at
  # enum status: { Live: 1, Draft: 2, Locked: 3 }
  # acts_as_list scope: :lead_type, column: "version_no"
	
{{/inline}}
{{#*inline "belongsTo"}}
{{#if entity.belongs_to}}

  # Belongs To
{{#each entity.belongs_to}}
  belongs_to :{{./name}}{{./generate_belongs_options}}
{{/each}}{{/if}}
{{~/inline}}
{{#*inline "scopes"}}
{{#if entity.scopes}}

  # Scopes
{{#each entity.scopes}}
  scopes :{{./name}}
{{/each}}{{/if}}
{{~/inline}}
{{#*inline "publicMethods"}}
{{#if entity.public_instance_methods}}

  # Public API
{{#each entity.public_instance_methods}}
  def {{./name}}; end{{#if @last}}{{else}}

{{/if}}
{{/each}}{{/if}}
{{/inline}}
{{#*inline "privateMethods"}}
{{#if entity.private_instance_methods}}

  private

{{#each entity.private_instance_methods}}
  def {{./name}}; end{{#if @last}}{{else}}

{{/if}}
{{/each}}{{/if}}
{{/inline}}
{{#*inline "classMethods"}}
{{#if entity.public_class_methods}}

  class << self
    # Class methods maybe extractable out into their own query/action classes
{{#each entity.public_class_methods}}
    def {{./name}}; end{{#if @last}}{{else}}

{{/if}}
{{/each}}
  
  end{{/if}}
{{/inline}}
# frozen_string_literal: true

class {{camelU entity.name}} < ActiveRecord::Base
{{~> defaultScope}}
{{> belongsTo}}
{{> scopes}}
{{> publicMethods}}
{{> privateMethods}}
{{> classMethods}}
{{> missing}}
end
