# frozen_string_literal: true

module Patcmd
  module CLI
    class FileManager
      require "yaml"
      require "fileutils"

      attr_reader :config_path

      def initialize(config_path)
        @config_path = config_path
        ensure_config_file
      end

      def init_config
        create_default_config unless config_file_exists?
      end

      def load_config
        YAML.load_file(config_path)
      end

      def save_config(config)
        File.write(config_path, config.to_yaml)
      end

      private

      def ensure_config_file
        init_config unless config_file_exists?
      end

      def config_file_exists?
        File.exist?(config_path)
      end

      def create_default_config
        default_config = {
          "tasks" => [
            {
              "category" => "Default",
              "name" => "HelloWorld",
              "description" => "A simple Hello World task",
              "path" => "/usr/local/bin",
              "actions" => [
                "name" => "say",
                "command" => "echo",
                "args" => ["Hello, World!"],
                "environments" => { "ENV" => "development" },
              ],
            },
          ],
        }
        FileUtils.mkdir_p(File.dirname(config_path))
        File.write(config_path, default_config.to_yaml)
      end
    end
  end
end
