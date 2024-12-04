# frozen_string_literal: true

module Patcmd
  class ConfigManager
    require "yaml"
    require "fileutils"

    def initialize(config_path)
      @config_path = config_path
      ensure_config_file
      @config = load_config
    end

    def init_config
      unless File.exist?(@config_path)
        default_config = { "tasks" => [] }
        FileUtils.mkdir_p(File.dirname(@config_path))
        File.write(@config_path, default_config.to_yaml)
      end
    end

    def add_task(task)
      @config["tasks"] << task
      save_config
    end

    def find_task(category, name, action)
      @config["tasks"].find do |task|
        task["category"] == category && task["name"] == name && task["action"] == action
      end
    end

    def all_tasks
      @config["tasks"]
    end

    private

    def ensure_config_file
      unless File.exist?(@config_path)
        init_config
      end
    end

    def load_config
      YAML.load_file(@config_path)
    end

    def save_config
      File.write(@config_path, @config.to_yaml)
    end
  end
end
