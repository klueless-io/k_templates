module ResponseErrorHandling
  extend ActiveSupport::Concern

  included do
    def not_found(msg = 'Not found')
      log_formatted(__callee__, msg)
      render_404
    end

    def unacceptable(msg = 'Permission denied')
      log_formatted(__callee__, msg)

      render_404
    end

    def bad_request(msg = 'Bad_request')
      log_formatted(__callee__, msg)
      render_400
    end

    def not_found!(msg = 'Not found', parameters = nil)
      honeybadger(ActiveRecord::RecordNotFound, msg, parameters)
      log_formatted(__callee__, msg)

      render_404
    end

    def unacceptable!(msg = 'Permission denied', parameters = nil)
      honeybadger(RuntimeError, msg, parameters)
      log_formatted(__callee__, msg)

      # Render 404 instead of 401/403 to prevent path disclosure.
      render_404
    end

    def bad_request!(msg = 'Bad request', parameters = nil)
      honeybadger(RuntimeError, msg, parameters)
      log_formatted(__callee__, msg)

      render_400
    end
  end

  def render_404
    respond_to do |format|
      format.html do
        render 'errors/not_found', status: :not_found, layout: 'error'
      end

      format.json do
        out = '{"errors":[{"detail":"Not found","title":"Not found"}]}'
        response.headers['Content-Length'] = out.size
        render plain: out, status: :not_found
      end

      format.any { render plain: 'Not found', status: :not_found }
    end
  end

  def render_400
    respond_to do |format|
      format.html do
        render 'errors/bad_request', status: :bad_request, layout: 'error'
      end

      format.json do
        out = '{"errors":[{"detail":"Bad request","title":"Bad request"}]}'
        response.headers['Content-Length'] = out.size
        render plain: out, status: :not_found
      end

      format.any { render plain: 'Bad request', status: :bad_request }
    end
  end

  def honeybadger(error, msg, params = {})
    # do something
  end

  def log_formatted(called_from, msg = '')
    logger.info do
      context = {
        tracker_user: current_user&.as_json(only: %i[id email]),
        path: request&.path,
        controller: controller_name,
        action: action_name
      }

      "#{self.class.name}##{called_from} #{msg} ```<)(>``` #{context.to_json}"
    end
  end
end
