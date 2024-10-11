KManager.action :bootstrap do
  action do
    application_name = :{{snake name}}

    # Svelte App
    director = KDirector::Dsls::BasicDsl
      .init(k_builder,
        template_base_folder:       'svelte',
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
        repo_name: application_name.to_s{{#if repo_organization}},
        organization: '{{repo_organization}}'{{/if}}
      ) do
        create_repository
        run_command('git init')
        run_command('git add .')
        run_command('git commit -m "Initial commit"')
        run_command('git branch -M main')
        run_command("git remote add origin #{dom[:github][:link]}")
        run_command('git push -u origin main')
        run_command("gh repo edit -d \"#{dom[:application_description]}\"")
        open_repository

        # delete_repository
        # list_repositories
      end
      .package_json(
        active: false,
        package_created_via: :vite # %i[vite sveltekit degit raw] - default: :vite - [npm init vite | npm create svelte | npx degit sveltejs/template | npm init]
      ) do
        npm_init if options.package_created_via == :raw

        settings(
          version:     dom[:initial_semver],
          description: dom[:application_description],
          author:      dom[:author],
          name:        dom[:application])

        sort

        if options.package_created_via == :raw
          development
          npm_add_group('svelte')

          production
          npm_add('sirv-cli')
        end
        # remove_package_lock
        # create_yarn_lock
      end
      .blueprint(
        active: false,
        name: :javascript_packages,
        description: 'add default svelte files',
        on_exist: :write) do

        # don't have support for image assets yet
        # add('public/favicon.png')
        add('public/global.css')
        add('public/index.html')

        add('src/App.svelte')
        # add('src/components/App.svelte')
        add('src/main.js')
        add('README.md')
        add('rollup.config.js')

        # run_command('yarn add -D semantic-release @semantic-release/changelog @semantic-release/git')

        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      .blueprint(
        active: false,
        name: :bin_hook,
        description: 'BIN/Hook structures',
        on_exist: :write) do

        cd(:app)
        
        self.dom = OpenStruct.new(parent.options.to_h.merge(options.to_h))

        run_template_script('.runonce/git-setup.sh', dom: dom)

        add('.gitignore')

        # add('.githooks/commit-msg')
        # add('.githooks/pre-commit')

        # run_command('chmod +x .githooks/commit-msg')
        # run_command('chmod +x .githooks/pre-commit')

        # run_command('git config core.hooksPath .githooks') # enable sharable githooks (developer needs to turn this on before editing rep)
        run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
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

