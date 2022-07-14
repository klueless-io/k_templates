# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout 'error'

  before_action :clear_location

  def bad_request
    render status: :bad_request
  end

  def not_found
    render status: :not_found
  end

  def unacceptable
    render status: :unacceptable
  end

  def internal_error
    render status: :internal_error
  end

  protected

  def clear_location
    session.delete(:previous_location)
  end
end
