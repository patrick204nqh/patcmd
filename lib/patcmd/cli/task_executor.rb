# frozen_string_literal: true

require_relative "task"
require_relative "environment_preparer"
require_relative "command_runner"
require_relative "path_resolver"

module Patcmd
  module CLI
    class TaskExecutor
      def initialize(task, options)
        @task = Task.new(task)
        @options = options
      end

      def execute
        env_vars = EnvironmentPreparer.new(@options).prepare(@task.environments)
        CommandRunner.new(@task, @options, env_vars).execute
      end
    end
  end
end
