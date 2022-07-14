# require 'uri'
# require 'net/http'
require 'active_model'
require 'pry'

# see: https://guides.rubyonrails.org/rails_application_templates.html

class BaseTemplate
  attr_reader :host

  attr_accessor :include_action_text
  alias_method :action_text?, :include_action_text

  attr_accessor :include_active_storage
  alias_method :active_storage?, :include_active_storage

  attr_accessor :include_sample_models
  alias_method :sample_models?, :include_sample_models

  attr_accessor :include_javascript_libraries
  alias_method :javascript_libraries?, :include_javascript_libraries

  attr_accessor :include_devise
  alias_method :devise?, :include_devise

  attr_accessor :include_rspec
  alias_method :rspec?, :include_rspec

  attr_accessor :include_common_pages
  alias_method :common_pages?, :include_common_pages

  attr_accessor :run_db_migrate
  alias_method :db_migrate?, :run_db_migrate

  def initialize(host)
    @host = host
  end

  private
  
  def gac(message)
    host.git add: "."
    host.git commit: " -m '#{message}'"
  end

  def add_action_text
    # see: https://youtube.com/clip/UgkxzZBvcxkIX9zvWTi21KEJSTDMlC25LY0y
    rails_command "action_text:install"
  end

  def add_active_storage
    rails_command "active_storage:install"
  end

  def add_devise
    # run('bundle add devise')
    # Bundler.with_unbundled_env do
    #   run 'bundle install'
    #   rails_command("devise:install")
    # end
    rails_command("devise:install")
    # run("bundle install")
  end

  def add_gems
    gem 'devise'                            if devise?
    # gem 'friendly_id'           if 
    # gem 'sidekiq'               if 
    # gem 'name_of_person'        if 
    # gem 'cssbundling-rails'
    # gem 'pay'                   if 
    # gem 'stripe'                if 
  end

  def add_gem_groups
    is_rspec = rspec?
    host.gem_group :development, :test do
      gem "rspec-rails"                     if is_rspec
    end
  end

  # def add_gems
  #   gem 'devise', '~> 4.8'
  #   gem 'friendly_id', '~> 5.4', '>= 5.4.2'
  #   gem 'sidekiq', '~> 6.3', '>= 6.3.1'
  #   gem 'name_of_person', '~> 1.1', '>= 1.1.1'
  #   gem 'cssbundling-rails'
  #   gem 'pay', '~> 3.0' # https://github.com/pay-rails/
  #   gem 'stripe', '>= 2.8', '< 6.0' # I prefer Stripe but you can opt for braintree or paddle too. https://github.com/pay-rails/pay/blob/master/docs/1_installation.md#gemfile
  # end

  def add_rspec
    host.generate("rspec:install")
  end

  def bundle_add(name)
    host.run("bundle add #{name}")
  end

  # Generate - Controller, model, and view
  def g_scaffold(name, *args)
    host.generate(:scaffold, name, *args)
  end

  # Generate - Controller and model
  def g_resource(name, *args)
    host.generate(:resource, name, *args)
  end

  # Generate - Mailer for sending emails
  def g_mailer(name, *args)
    # see: https://youtube.com/clip/UgkxV9uIgkL7fbHYWAAN6UiwdS8dFXSO1j5y
    host.generate(:mailer, name, *args)
  end

#   ```bash
# rm -rf kweb02-tailwind && rails new kweb02-tailwind --minimal
# --javascript esbuild --css tailwind
# ```

  def g_controller(name, *args)
    host.generate(:controller, name, *args)
  end

  def alter_first_file(glob, &block)
    file = Dir[glob].first
    instance_exec(file, &block)
    # yield(file) if file
  end

  def add_environment(value, env: 'development')
    # injects value into corresponding config/environment file.
    host.environment(value, env: env)
  end

  def add_file(path, content)
    host.file(path, content)
  end

  # env: 'production'
  # sudo: true
  # abort_on_failure: true
  def rails_command(command, **args)
    host.rails_command(command, **args)
  end

  def run(command)
    host.run(command)
  end

  def yes?(question, default: true)
    # see: https://github.com/rails/thor/blob/main/lib/thor/shell/basic.rb
    answer = host.ask(question, default: default)
    ActiveModel::Type::Boolean.new.cast(answer) 
  end

  def no?(question, default: false)
    answer = host.ask(question, default: default)
    ActiveModel::Type::Boolean.new.cast(answer) 
  end

  def settings_for_asset_management
    # see: https://noelrappin.com/blog/2021/09/rails-7-and-javascript/

    # This needs to be handled using command line options at the moment,
    # in future I may call AppGenerator.new directly with these options.

    # if you need transpiling then you need to install the esbuild-rails
    # if you don't need transpiling (or node dependencies) then you can use importmap-rails
    # see: https://d31d9mzh2cw851.cloudfront.net/wp-content/uploads/2022/02/10014354/Do-I-need-Importmap-FINAL2.jpg

    # if using javascript bundling then you can use:
    #   webpack (old/bad)
    #   esbuild (new/good)
    #   rollup (good)
    #
    #   use this if you are working with react or vue:
    #   is a single page app
    
    # alternative: importmap-rails does not do mapping and has a one to one relationship between files and browser
    #   use this if you are working with hotwire (turbo/stimulas)
    #   feels like a single page app, but using dynamic server side

    # css bundling (investigate cssbundling-rails)

    # hotwire: hotwire-rails

    # Use importmap if you are not using much JS, you’ll get a great developer experience
    # at the cost of some limited interaction with the JS world.
    
    # Use one of the jsbundler tools if you want more interaction with the JS world.
  end
end
