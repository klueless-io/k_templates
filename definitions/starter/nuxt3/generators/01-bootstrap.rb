KManager.action :bootstrap do
  action do
    application_name = :{{snake name}}
    director = KDirector::Dsls::Nuxt3Dsl
      .init(k_builder,
        on_exist:                   :skip,                      # %i[skip write compare]
        on_action:                  :queue                      # %i[queue execute]
      )
      .data(
        application:                application_name,
        application_description:    '{{description}}',
        application_lib_path:       application_name.to_s,
        author:                     'David Cruwys',
        author_email:               'david@ideasmen.com.au',
        initial_semver:             '1.0.0',
        main_story:                 '{{user_story}}',
        copyright_date:             '2024',
        website:                    'http://appydave.com/websites/{{dashify name}}'
      )
      .github(
        active: true,
        repo_name: application_name.to_s,
        organization: 'klueless-sites'
      ) do
        # create_repository
        # delete_repository
        # list_repositories
        # open_repository
        # run_command('git init')
        # run_command("gh repo edit -d \"#{dom[:application_description]}\"")
      end
      .package_json(
        active: false
      ) do
        settings(
          version:     dom[:initial_semver],
          description: dom[:application_description],
          author:      dom[:author],
          name:        dom[:application])
        sort
        development

        npm_add_group('tailwind-nuxt')
        npm_add_group('semver-nuxt')
        npm_add('@lhci/cli')
        npm_add_group('storybook-nuxt')
        npm_add('@storybook/addon-docs@6.4.18 --force')
        npm_add('@storybook/addon-essentials@6.4.18 --force')

        add_script('storybook', 'start-storybook -p 6007 -s ./assets')
        add_script('release', 'semantic-release')
        add_script('lhci:mobile', 'lhci autorun')
        add_script('lhci:desktop', 'lhci autorun --collect.settings.preset=desktop')

        remove_package_lock
        create_yarn_lock
        # set('resolve', '1.20.0')

      end
      .blueprint(
        name: :javascript_packages,
        description: 'install tailwind, storybook and lighthouse packages',
        on_exist: :write) do

        # run_command('npx tailwindcss init -p')
        # add('tailwind.config.js')
        # add('assets/styles/tailwind.css')
        # add('.storybook/main.js')
        # add('.storybook/preview.js')
        # add('lighthouserc.js')

        # run_command('yarn add -D semantic-release @semantic-release/changelog @semantic-release/git')

        # add('nuxt.config.ts')
        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      # .blueprint(
      #   name: :bin_hook,
      #   description: 'BIN/Hook structures',
      #   on_exist: :write) do

      #   cd(:app)
      #   # binding.pry
      #   # debug
        
      #   # self.dom = OpenStruct.new(parent.options.to_h.merge(options.to_h))

      #   # run_template_script('.runonce/git-setup.sh', dom: dom)

      #   # run_template_script('.runonce/git-setup.sh', dom: dom)

      #   # add('.gitignore')

      #   # add('.githooks/commit-msg')
      #   # add('.githooks/pre-commit')

      #   # run_command('chmod +x .githooks/commit-msg')
      #   # run_command('chmod +x .githooks/pre-commit')

      #   # run_command('git config core.hooksPath .githooks') # enable sharable githooks (developer needs to turn this on before editing rep)
      #   # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      # end
      # .blueprint(
      #   name: :ci_cd,
      #   description: 'github actions (CI/CD)',
      #   on_exist: :write) do

      #   cd(:app)
      #   # self.dom = OpenStruct.new(parent.options.to_h.merge(options.to_h))

      #   # run_command("gh secret set SLACK_WEBHOOK --body \"$SLACK_REPO_WEBHOOK\"")
      #   # run_command("gh secret set LHCI_GITHUB_APP_TOKEN --body \"$LHCI_GITHUB_APP_TOKEN\"")
      #   # add('.github/workflows/main.yml')
      #   # add('.github/workflows/semver.yml')
      #   # add('.releaserc.json')

      #   # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      # end

    # director.k_builder.debug
    # director.builder.logit
    director.play_actions
  end
end

KManager.opts.app_name                    = '{{name}}.com'
KManager.opts.sleep                       = 2
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'

