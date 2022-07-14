# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ResponseErrorHandling
  include SecureActions
  include SetCommonHeaders
  include SetCurrent
  include Instrumentation # ScoutAVM context

  respond_to :html
  layout 'public'

  protect_from_forgery with: :exception, prepend: true

  if ENV['BASIC_AUTH_ENABLED']
    http_basic_authenticate_with(
      name: ENV['BASIC_AUTH_USERNAME'],
      password: ENV['BASIC_AUTH_PASSWORD']
    )
  end

  helper_method :current_user
end
