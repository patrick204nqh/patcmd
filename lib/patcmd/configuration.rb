# frozen_string_literal: true

require "yaml"
require "fileutils"

module Patcmd
  class Configuration
    CONFIG_PATH = File.expand_path("~/.patcmd/config.yml")

    class << self
      def exists?
        File.exist?(CONFIG_PATH)
      end

      def create_default
        default_config = {
          "tasks" => {
            "hello" => {
              "command" => "bash",
              "args" => ["-c", "'echo \"$GREETING, $TARGET! Args: $ARG1, $ARG2\"'"],
              "env" => {
                "GREETING" => "Hello",
                "TARGET" => "World",
                "ARG1" => "Foo",
                "ARG2" => "Bar",
              },
              "description" => "Print Hello World with multiple arguments and environment variables",
              "group" => "default",
            },
          },
        }
        File.write(CONFIG_PATH, default_config.to_yaml)
      end

      def load_config
        if exists?
          YAML.load_file(CONFIG_PATH) || { "tasks" => {} }
        else
          create_default
          load_config
        end
      end

      def load_tasks
        load_config["tasks"] || {}
      end

      def add_task(name, task_data)
        config = load_config
        config["tasks"] ||= {}
        config["tasks"][name] = task_data
        File.write(CONFIG_PATH, config.to_yaml)
      end

      # TODO: Implement update and remove methods as needed.
    end
  end
end
