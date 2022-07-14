# frozen_string_literal: true

# COMMENT AFTER SEED HAS RUN FOR FIRST TIME
AdminUser.create!(email: "admin@admin.com", password: "password", password_confirmation: "password") if Rails.env.development?
puts 'AdminUser.create!(email: "admin@admin.com", password: "password")'

# This file contains all the record creation needed to seed the database with its default values.
#
# Usage:
#   load seed data
#   rails db:seed
#
#   load sample data, useful in developer environments
#   rails db:seed sample=true
#
#   reset database
#   rails db:seed reset=true
#

# UNCOMMENT AFTER ADMIN USER CREATED
# require_relative "import_data/import_data"

# puts "ENV['sample'] #{ENV['sample']}"
# puts "ENV['reset'] #{ENV['reset']}"

# is_sample = ENV["sample"].to_bool == true || ENV["samples"].to_bool == true
# is_reset = ENV["reset"].to_bool == true

# seed = ImportData.new(is_sample)

# if is_reset
#   seed.reset_all
# else
#   seed.run
# end
