# frozen_string_literal: true

module SetCurrent
  extend ActiveSupport::Concern
  include FindCurrentSession
  include ApplicationHelper

  included do
    extend Memoist

    prepend_before_action do
      Current.session = find_session(session[:sid])
      Current.request_id = request.uuid
      Current.user_agent = request.user_agent
      Current.ip_address = request.remote_ip
      Current.path_info = request.path_info
      Current.controller_name = controller_name

      Current.identity = current_identity
      Current.user = current_user

      Current.tenant = current_tenant
    end
  end

  def current_identity
    current_user&.identity
  end

  def current_tenant
    # 
  end
end
