# frozen_string_literal: true

require "dry/cli"

module {{project_namespace}}
  module Cli
    module Commands
      extend Dry::CLI::Registry

      class Version < Dry::CLI::Command
        desc "Print version"

        def call(*)
          puts KManager::VERSION
        end
      end

      class Watch < Dry::CLI::Command
        desc "Watch folder"
        argument :watch_folder, default: '.builders', desc: "Folder to watch, defaults to (.builders)"
        option :boot_file, default: "boot.rb", aliases: ['-b'], desc: "The boot file used for k_manager configuration"

        example [
          "                           # will watch .builders folder and boot from ./builders/boot.rb",
          "-b ../config/boot.rb       # will watch .builders folder and boot from ./config/boot.rb",
          ".xmen                      # will watch .xmen folder",
        ]

        def call(watch_folder:, boot_file:, **)
          # pathname = Pathname.new(watch_folder)
          # watch_folder = pathname.absolute? ? watch_folder : File.expand_path(watch_folder, Dir.pwd)
          watch_folder = absolute_path(watch_folder, Dir.pwd)
          boot_file = absolute_path(boot_file, watch_folder)
          puts watch_folder
          puts boot_file
      
          watcher = KManager::Watcher.new(watch_folder, boot_file)
          watcher.start
        end

        private

        def absolute_path(path, base_path)
          pathname = Pathname.new(path)
          pathname.absolute? ? path : File.expand_path(path, base_path)
        end
      end

      register 'version', Version, aliases: %w[v -v --version]
      register 'watch',    Watch

      # register 'generate', aliases: ['g'] do |prefix|
      #   prefix.register 'config', Generate::Configuration
      # end

    end
  end
end