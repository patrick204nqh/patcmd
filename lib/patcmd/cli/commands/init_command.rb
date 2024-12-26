# frozen_string_literal: true

module Patcmd
  module CLI
    module Commands
      class InitCommand < BaseCommand
        default_task :init

        desc "init", "Initialize the PatCmd configuration"
        def init
          config_manager.init_config
          puts "Configuration initialized at #{config_manager.path}"
        end
      end
    end
  end
end
