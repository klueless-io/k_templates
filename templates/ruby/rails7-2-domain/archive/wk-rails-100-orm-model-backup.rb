

# frozen_string_literal: true

class {{camel entity.model_name}} < ApplicationRecord
  {{#if (eq settings.model_type 'admin_user')}}
  # ----------------------------------------------------------------------
  # Devise configuration (+ optional configs)
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ----------------------------------------------------------------------
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  {{/if}}
  {{#if (eq settings.model_type 'basic_user')}}
  # ----------------------------------------------------------------------
  # Devise configuration (+ optional configs)
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ----------------------------------------------------------------------
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  {{/if}}

  # ----------------------------------------------------------------------
  # Relationships
  # ----------------------------------------------------------------------

{{#each relations_one_to_one}}
  belongs_to :{{snake this.name}}{{#if (eq json.optional true)}}, optional: true{{/if}}
{{/each}}
{{#each relations_has_one}}
  has_one :{{snake this.name}}{{#if (eq json.optional true)}}, optional: true{{/if}}
{{/each}}
{{#each relations_one_to_many}}
  has_many :{{snake this.name_plural}}
{{/each}}
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

  {{#each entity.columns}}
  {{#if (eq ../settings.model_type 'admin_user')}}
  {{else if (eq ../../settings.model_type 'basic_user')}}
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

  {{#if (eq settings.model_type 'admin_user')}}
  def display_name
    return self.email
  end
  {{/if}}
  {{#if (eq settings.model_type 'basic_user')}}
  def display_name
    return self.email
  end
  {{/if}}

  # Can be useful in active admin
  # def name
  #   return self.name
  # end
end
