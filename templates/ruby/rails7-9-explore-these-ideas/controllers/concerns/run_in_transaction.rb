module RunInTransaction
  extend ActiveSupport::Concern
  included do
    around do |interactor|
      begin
        ActiveRecord::Base.transaction do
          interactor.call
        end
      rescue StandardError => e
        context.fail!(message: "Unexpected uncaught exception: #{e}", errors: [e]) unless context.failure?
      end
    end
  end
end
