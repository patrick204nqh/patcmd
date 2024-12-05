# frozen_string_literal: true

module Patcmd
  module CLI
    class ExecCommand < BaseCommand
      default_task :exec

      desc "exec CATEGORY NAME ACTION", "Execute a defined task"
      def exec(category, name, action)
        task = config_manager.find_task(category, name, action)
        if task
          executor = TaskExecutor.new(task, options)
          executor.execute
        else
          puts "Task not found for category '#{category}', name '#{name}', and action '#{action}'."
          exit(1)
        end
      end
    end
  end
end
