# frozen_string_literal: true

# Base controller for all API calls
class ApiController < ApplicationController
  respond_to :json

  # http_basic_authenticate_with name: "klueless", password: "password"

  protected

  # Return a list of sample endpoints for our developers to explore what is available on
  # the current API controller they are working on
  #
  # A default sample is generally specified which can be modified or added too
  def sample(type, endpoints)
    if Rails.env.production?
      render locals: { result: status_error("Samples unavailable") }, status: 404
    else
      render locals: { endpoints: endpoints, result: status_success("Sample end points for #{type}") }
    end
  end

  # rubocop:disable Metrics/MethodLength
  def build_sample_endpoints(type, main_key: "name")
    type_plural = type.pluralize
    type_snake_plural = ActiveSupport::Inflector.parameterize(type.underscore.pluralize, separator: "_")
    port = request.port
    [
      { key: :index,
        type: "GET" , description: "Get a full list of #{type_plural}",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}" },
      { key: :index_filter ,
        type: "GET" , description: "Get a full list of #{type_plural} with filter, sorting and pagination",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}?options={'page':{'active':true,'no':1,'size':50},'filter':{'search':''},'sort':[{'field':'#{main_key}'','sort':'asc'}]}" },
      { key: :show ,
        type: "GET" , description: "Get a single, #{type}",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}/1" },
      { key: :show_failure ,
        type: "GET" , description: "Get a single #{type}, with invalid ID",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}/10000069" },
      { key: :multi,
        type: "GET" , description: "Get multiple #{type_plural} by ID",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}/multi?ids=1,2" },
      { key: :create,
        type: "POST" , description: "Create #{type}",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}" },
      { key: :update,
        type: "PUT" , description: "Update #{type}",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}/1" },
      { key: :destroy,
        type: "DELETE", description: "Destroy #{type}",
        url: "http://localhost:#{port}/api/v1/#{type_snake_plural}/id" }
    ]
  end
  # rubocop:enable Metrics/MethodLength

  def build_data
    @data = {
      success: false,
      error: nil,
      messages: nil
    }
  end

  # @param error [String or Exception] the error message to return
  # @param messages [Array<string>] List of extra messages to return
  def error(error, messages = nil)
    build_data

    @data[:success] = false

    case error
    when String
      @data[:error] = error
    when StandardError
      @data[:error] = error.message
    end

    return unless messages.present?

    case error
    when String
      @data[:messages] = [messages]
    when Array
      @data[:messages] = messages
    end
  end

  # Helper to render a success based response on a single row, used by show, create and update
  def render_success(data = {}, message = nil)
    render locals: { result: status_success(message) }.merge(data)
  end

  def render_success_row(row, message = nil)
    render_success({ row: row }, message)
  end

  # Helper to render a success based response for multiple rows
  def render_success_rows(rows, message = nil)
    render_success({ rows: rows }, message)
  end

  # Helper to render a success based response paginated queries
  def render_success_query(rows, page, message = nil)
    render_success({ rows: rows, page: page }, message)
  end

  # Helper to render a success based response for multiple rows, used by index / query methods
  def render_success_destroy(row, message = nil)
    render_success({ id: row.id }, message)
  end

  # Helper to render error based responses
  def render_error(message = nil, errors = [])
    render locals: { result: status_error(message, errors) }, status: 404
  end

  # Helper to format a successful status, message is optional
  def status_success(message = nil)
    result = { success: true }
    result[:message] = message if message.present?

    result
  end

  # Helper to format a successful status, message is optional
  def status_error(message = nil, errors = [])
    result = { success: false }
    result[:message] = message if message.present?
    result[:errors] = errors if errors.any?

    result
  end
end
