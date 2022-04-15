# require 'uri'
# require 'net/http'
require 'active_model'
require 'pry'
require_relative 'base_template'

class R7HotwireTemplate < BaseTemplate
  attr_reader :host
  
  def customize_template
    gac('Base Rails 7 image created')

    settings_for_asset_management

    ask_questions
    add_gems
    add_gem_groups
  end
  # ./bin/rails javascript:install:esbuild
  def after_bundle
    add_action_text               if action_text?
    add_active_storage            if active_storage?
    add_devise                    if devise?
    add_rspec                     if rspec?
    add_javascript_libraries      if javascript_libraries?
    
    gac('Base Rails 7 default structure created')
    
    setup_models                  if sample_models?
    setup_common_pages            if common_pages?
    
    rails_command("db:migrate")   if db_migrate?
  end

  private

  def add_devise
    run "bundle add devise"

    Bundler.with_unbundled_env { run "bundle install" }

    rails_command "generate devise:install"

    run "rails generate devise User role:integer"
    
    alter_first_file('db/migrate/*_create_users.rb') do |file|
      host.in_root do
        host.gsub_file(file,
          't.integer :role',
          't.integer :role, default: 0')
      end
    end

    rails_command "generate devise:views"
  end

  def ask_questions
    self.include_action_text          = no?("Add action text 'Rails'?")
    self.include_active_storage       = no?("Add active storage 'Rails'?")
    self.include_javascript_libraries = no?("Add javascript libraries 'Pinned'?") # this is if using importmap
    self.include_sample_models        = no?("Add sample models?")
    self.include_common_pages         = yes?("Add common pages?")
    self.include_devise               = no?("Add devise?") # Alter t.integer :role, default: 0
    self.include_rspec                = no?("Add rspec?")
    self.run_db_migrate               = yes?("Run db:migrate?")
  end

  def setup_models
    g_scaffold("post", 'title', 'content:text')
    g_scaffold("book", 'title', 'content:text')
    g_resource("comment", "post:references", 'content:text')
    g_mailer("posts", "submitted", "broken")
  end

  def setup_common_pages
    g_controller("home", "index")
    host.route("root to: 'home#index'")
    # g_controller("pages", "home", "about")
    # host.route("root to: 'pages#home'")
  end

  def add_javascript_libraries
    # see: https://youtube.com/clip/Ugkx_tDcsUclZ-GR1Ck6liDKrlvmf38r92mw
    # host.run("bin/importmap pin local-time")
    host.run("bin/importmap pin local-time --download")
  end
end

setup_rails = R7HotwireTemplate.new(self)
setup_rails.customize_template

after_bundle do
  setup_rails.after_bundle
end
