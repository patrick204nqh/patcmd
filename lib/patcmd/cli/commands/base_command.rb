# frozen_string_literal: true

module Patcmd
  module CLI
    class BaseCommand < Thor
      include Helpers::TaskHelper
      include Helpers::Logger

      CONFIG_PATH = File.expand_path("~/.patcmd/config.yml")

      # Define global options
      class_option :config, type: :string, default: CONFIG_PATH, desc: "Path to configuration file"

      def initialize(*args)
        super
        @config_manager = ConfigurationManager.new(options[:config])
      end

      private

      attr_reader :config_manager
    end
  end
end
