# frozen_string_literal: true

require "patcmd/cli/task"
require "patcmd/cli/environment_preparer"
require "patcmd/cli/command_runner"
require "patcmd/cli/path_resolver"

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
