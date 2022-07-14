# New Rails 7 App

```bash
# create a new rails 7 application
k_templates/templates/rails_app

# after creating the new application

# 

```

## list of templates to work through

Rails App Generator Code:

```
https://github.com/rails/rails/blob/main/railties/lib/rails/generators/rails/app/app_generator.rb
or
https://github.dev/rails/rails
then
railties/lib/rails/generators/rails/app/app_generator.rb
or

cd /Users/davidcruwys/dev/gems_3rd/rails
c .
then
railties/lib/rails/generators/rails/app/app_generator.rb
```

## Kickoff Tailwind

https://dev.to/eclecticcoding/new-rails-template-1dp
https://github.com/justalever/kickoff_tailwind/blob/main/template.rb

## Rails 7 MattBrictson

https://github.com/mattbrictson/rails-template


## Command line formulas

```bash
rm -rf kweb02-tailwind && rails new kweb02-tailwind --skip-test --javascript esbuild --css tailwind

# esbuild, tailwindcss, no rails addons
# ./bin/dev
rm -rf kweb02-tailwind && rails new kweb02-tailwind --skip-test --javascript esbuild --css tailwind --skip-action-mailer --skip-action-mailbox --skip-action-text --skip-active-storage --skip-active-job --skip-action-cable  -m ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb

# hotwire, bootstrap, no rails addons
# ./bin/dev
rm -rf kweb03-bootstrap && rails new kweb03-bootstrap --skip-test --css bootstrap --skip-action-mailer --skip-action-mailbox --skip-action-text --skip-active-storage --skip-active-job --skip-action-cable  -m ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb

# hotwire, active-storage/text addons
rm -rf kweb04-active-storage && rails new kweb04-active-storage --skip-test --skip-action-cable  -m ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb && c kweb04-active-storage/.

# hotwire, devise, integration_tests
rm -rf kweb05-devise-unit-test \
  && rails new kweb05-devise-unit-test \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-storage \
  --skip-action-cable \
  --template ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb \
  && c kweb05-devise-unit-test/.

# hotwire, devise, integration_tests, tailwind
rm -rf kweb06-devise-unit-test-tailwind \
  && \
  rails new kweb06-devise-unit-test-tailwind \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-storage \
  --skip-action-cable \
  --template ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb \
  && \
  c kweb06-devise-unit-test-tailwind/.

# hotwire, devise
rm -rf printspeak-r7 && \
  rails new printspeak-r7 \
  --skip-test \
  --css tailwind \
  --template ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb \
  && \
  c printspeak-r7/.
```

```bash
asdf local ruby 2.7.1 / 
&&  km2 new kweb01-devise -t rails_app \
    --description "Xyz Application" \
&&  asdf local ruby 3.1.1

ASDF_RUBY_VERSION=2.7.1 && km2 new kweb01-devise -t rails_app 

asdf shell ruby 2.7.1 && km2 new kweb01-devise -t rails_app 

\
    --description "Xyz Application" \
&&  asdf local ruby 3.1.1

```

```bash
# sets
--skip-action-mailer --skip-action-mailbox 
--skip-action-text --skip-active-storage
--skip-active-record
--skip-active-job
--skip-action-cable 

--skip-action-mailer --skip-action-mailbox --skip-action-text --skip-active-storage --skip-active-job --skip-action-cable 

--skip-action-mailer          # Skip Action Mailer files
--skip-action-mailbox         # Skip Action Mailbox gem
--skip-action-text            # Skip Action Text gem
--skip-active-record          # Skip Active Record files
--skip-active-job             # Skip Active Job
--skip-active-storage         # Skip Active Storage files
--skip-action-cable           # Skip Action Cable files
--skip-test                   # Skip test files
```



```ruby
 if options[:minimal]
  self.options = options.merge(
    skip_action_cable: true,
    skip_action_mailer: true,
    skip_action_mailbox: true,
    skip_action_text: true,
    skip_active_job: true,
    skip_active_storage: true,
    skip_bootsnap: true,
    skip_dev_gems: true,
    skip_javascript: true,
    skip_jbuilder: true,
    skip_system_test: true,
    skip_hotwire: true).freeze
end
```