# frozen_string_literal: true

module Patcmd
  module CLI
    class ConfigManager
      attr_reader :file_manager, :task_manager

      def initialize(config_path)
        @file_manager = FileManager.new(config_path)
        @task_manager = Tasks::TaskManager.new(file_manager.load_config)
      end

      def init_config
        file_manager.init_config
      end

      def add_task(task)
        task_manager.add_task(task)
        file_manager.save_config(task_manager.config)
      end

      def find_task(category, name, action)
        task_manager.find_action(category, name, action)
      end

      def all_tasks
        task_manager.all_tasks
      end

      def path
        file_manager.config_path
      end
    end
  end
end
