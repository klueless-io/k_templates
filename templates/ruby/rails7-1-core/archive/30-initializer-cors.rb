# frozen_string_literal: true

# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # Allow development SPA's to talk to the local server
  if Rails.env.development?
    allow do
      origins "*"
      resource "*", headers: :any, methods: %i[get post options]
    end
  end
end
