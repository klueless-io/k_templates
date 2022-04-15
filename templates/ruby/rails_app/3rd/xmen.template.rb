require 'uri'
require 'net/http'

REPO = 'https://raw.githubusercontent.com/nhcasanova/stonerun'.freeze

def go_bundle
  # puts 'go RICKY*********************************1'
  # Bundler.with_unbundled_env { run 'bundle install' }
  # puts 'go RICKY*********************************2'
end

gem 'devise'
gem 'aws-sdk-s3'
gem 'image_processing', '~> 1.2'
gem 'figaro'

gem_group :development, :test do
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end

go_bundle

webpack_rails = File.directory?('config/webpack')

if webpack_rails
  run 'yarn add @tabler/core'
  inject_into_file "app/javascript/packs/application.js" do <<~EOF
      import tabler from "@tabler/core"
      require("@tabler/core/dist/css/tabler.css")
    EOF
  end

  inject_into_file "app/views/layouts/application.html.erb", before: "</head>" do <<~EOF
    <%= stylesheet_pack_tag "application", media: "all", "data-turbolinks-track": "reload" %>
    EOF
  end
end

rails_command 'db:create'
rails_command 'generate controller dashboard index'
route "root to: 'dashboard#index'"

rails_command 'generate devise:install'
rails_command 'generate devise:views'
rails_command 'generate devise user first_name last_name'
rails_command 'generate devise:controllers users -c=registrations'
inject_into_file 'app/controllers/users/registrations_controller.rb', "layout 'layouts/application', only: [:edit]\n", after: "class Users::RegistrationsController < Devise::RegistrationsController\n"
gsub_file 'config/routes.rb', 'devise_for :users', "devise_for :users, controllers: { registrations: 'users/registrations' }"

rails_command 'db:migrate'

extra_devise_cols = <<~RUBY
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    sign_up_attrs = [:first_name, :last_name]
    update_attrs = [:first_name, :last_name, :avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: update_attrs)
  end
RUBY

inject_into_file 'app/controllers/application_controller.rb', extra_devise_cols, after: "class ApplicationController < ActionController::Base\n"
inject_into_file 'app/controllers/dashboard_controller.rb', "before_action :authenticate_user!\n", after: "class DashboardController < ApplicationController\n"
inject_into_file 'app/models/user.rb', "has_one_attached :avatar\n", before: 'end'

run 'rm app/views/layouts/application.html.erb'
run 'rm app/views/devise/sessions/new.html.erb'
run 'rm app/views/devise/registrations/new.html.erb'
run 'rm app/views/devise/registrations/edit.html.erb'

layouts = %w[application devise _avatar _footer _header _title]

layouts.each do |layout|
  create_file "app/views/layouts/#{layout}.html.erb" do
    Net::HTTP.get(URI("#{REPO}/main/views/layouts/#{layout}.html.erb"))
  end
end

create_file 'app/views/devise/sessions/new.html.erb' do
  Net::HTTP.get(URI("#{REPO}/main/views/devise/sessions/new.html.erb"))
end

create_file 'app/views/devise/registrations/new.html.erb' do
  Net::HTTP.get(URI("#{REPO}/main/views/devise/registrations/new.html.erb"))
end

create_file 'app/views/devise/registrations/edit.html.erb' do
  Net::HTTP.get(URI("#{REPO}/main/views/devise/registrations/edit.html.erb"))
end

inject_into_file 'app/views/dashboard/index.html.erb' do <<~EOF
 <% provide(:pretitle, 'Index') %>
 <% provide(:title, 'Dashboard') %>
EOF
end

run 'rails action_text:install'
run 'rails active_storage:install'
run 'bundle exec figaro install'

rails_command 'db:migrate'

gsub_file 'config/environments/production.rb', 'config.active_storage.service = :local', 'config.active_storage.service = :amazon'
