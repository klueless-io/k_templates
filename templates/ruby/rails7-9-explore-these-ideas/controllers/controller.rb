# frozen_string_literal: true

# This is a sample {{downcase (titleize model.name)}} controller following a REST pattern.
#
# All methods are thin in nature, the demonstrate patterns PSEUDO code for
# :index, show, new, create, edit, update, and delete.
# 
# SRP is used when need, queries, presenters, commands, form_objects
# Cross-cutting issues such as Event Publishing, Instrumentation, 
# Current<User, Tenant, ***>, exception handling and logging are implemented
# via concerns either the ApplicationController or here in the {{camelU model.name_plural}}Controller
class {{camelU model.name_plural}}Controller < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  # before_action :load_parent_name

  def index
    @{{dasherize model.name_plural}} = {{camelU model.name_plural}}.all
    # or
    # @{{dasherize model.name_plural}} = {{camelU model.name_plural}}Query.new(index_params).results
    # or
    # @{{dasherize model.name_plural}} = Presenters::{{camelU model.name_plural}}Presenter.present_collection({{camelU model.name_plural}}.all)
  end

  def show
    @{{dasherize model.name}} = Presenters::{{camelU model.name}}Presenter.present(find_resource)
    # @{{dasherize model.name}} = Presenters::{{camelU model.name}}Presenter.new(user: current_user).present(find_resource) # Variant for security role based presenters

    respond_to do |format|
      format.html
      format.json { render json: @{{camelU model.name}} }
    end
  end

  def new
    @{{dasherize model.name}} = @{{dasherize model.name}}.new
  end

  def create
    # @{{dasherize model.name}} = @{{dasherize model.name}}.create(create_params)
    # redirect_to xyz_path
    # or
    result = create_{{snake model.name}}

    if result.success?
      redirect_to abc_path(@result.{{dasherize model.name}}.id)
    else
      flash[:error] = result.message
      redirect_to xyz_path
    end
  end

  def update
    # @{{dasherize model.name}} = @{{dasherize model.name}}.create(create_params)
    # redirect_to xyz_path
    # or
    result = update_{{snake model.name}}

    if result.success?
      redirect_to abc_path(@result.{{dasherize model.name}}.id)
    else
      flash[:error] = result.message
      redirect_to xyz_path
    end
  end

  private

  # PATTERN: Parent Loader
  def load_parent_name
    @parent_name ||= ::ParentName.find_by!(parent_key: params[:parent_key])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def find_resource
    @{{dasherize model.name}} ||= @{{dasherize model.name}}.find(params[:id])
  end

  def create_params
    params.require(:{{snake model.name}}).permit(:list, :of, :create, :attributes)
  end

  def create_{{snake model.name}}
    Commands::{{camelU model.name_plural}}Commands::Create.call(create_params)
  end

  def update_params
    params.require(:{{snake model.name}}).permit(:list, :of, :update, :attributes)
  end

  def update_{{snake model.name}}
    Commands::{{camelU model.name_plural}}Commands::Update.call({{snake model.name}}: find_resource, **update_params)
  end

  def publish_event
    # Custom honey badger or event logic
    # honeybadger(xyz)
  end
end
