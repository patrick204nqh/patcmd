# frozen_string_literal: true

module Patcmd
  module CLI
    module Commands
      class BaseCommand < Thor
        CONFIG_PATH = File.expand_path("~/.patcmd/config.yml")

        # Define global options
        class_option :config, type: :string, default: CONFIG_PATH, desc: "Path to configuration file"

        def initialize(*args)
          super
          @config_manager = ConfigurationManager.new(options[:config])
          @logger = Logger.new(verbose: options[:verbose])
        end

        private

        attr_reader :config_manager, :logger
      end
    end
  end
end
