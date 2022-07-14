# frozen_string_literal: true

module SetCommonHeaders
  extend ActiveSupport::Concern

  included do
    before_action :set_no_cache_headers, if: -> { user_signed_in? }
  end

  def set_no_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
