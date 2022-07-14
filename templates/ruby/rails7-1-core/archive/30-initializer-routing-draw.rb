# frozen_string_literal: true

# config/initializers/routing_draw.rb

# Adds draw method into Rails routing
# It allows us to keep routing split out into files
module ActionDispatch
  module Routing
    # Mapper each group of routes and evaluate
    class Mapper
      def draw(routes_name)
        instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
      end
    end
  end
end
