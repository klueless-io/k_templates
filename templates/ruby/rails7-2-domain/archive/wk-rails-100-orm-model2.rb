# frozen_string_literal: true

class {{camel entity.model_name}} < ApplicationRecord
  # Relationships
{{#belongs_to}}
  belongs_to :{{snake this.name}}{{#if (eq json.optional true)}}, optional: true{{/if}}
{{/belongs_to}}
{{#entity.has_one}}
  has_one :{{snake this.name}}{{#if (eq json.optional true)}}, optional: true{{/if}}
{{/entity.has_one}}
{{#entity.has_many}}
  has_many :{{snake this.name_plural}}
{{/entity.has_many}}
{{#if relations_many_to_many}}

  # Many to Many
{{#each relations_many_to_many}}
  has_many :{{this.through}}
  has_many :{{this.name_plural}}, through: :{{this.through}}
{{/each}}
{{/if}}
  # ----------------------------------------------------------------------
  # Validations
  # ----------------------------------------------------------------------

  {{#each entity.column_validation}}
  {{#if (eq ../entity.model_type 'admin_user')}}
  {{else if (eq ../../entity.model_type 'basic_user')}}
  {{else if (eq type 'boolean')}}
  validates :{{snake this.name}}, inclusion: { in: [true, false], message: "%{value}must be provided", allow_nil: false }
  {{else if (eq type 'primary_key')}}
  {{else if (eq type 'foreign_key')}}
  {{else if (eq db_type '==' 'jsonb')}}
  validates :{{snake this.name}}, presence: true, json_hash: true
  {{else}}
  validates :{{snake this.name}}, presence: true
{{/if}}
  {{/each}}

  # ----------------------------------------------------------------------
  # Accessors XYZ
  # ----------------------------------------------------------------------

  {{#if (eq entity.model_type 'admin_user')}}
  def display_name
    return self.email
  end
  {{/if}}
  {{#if (eq entity.model_type 'basic_user')}}
  def display_name
    return self.email
  end
  {{/if}}

  # Can be useful in active admin
  # def name
  #   return {{entity.main_key}}
  # end
end
