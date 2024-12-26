# frozen_string_literal: true

require "patcmd/cli/environment_preparer"
require "patcmd/cli/command_runner"

module Patcmd
  module CLI
    module Tasks
      class TaskExecutor
        def initialize(task, options)
          @task = task
          @options = options
        end

        def execute
          env_vars = EnvironmentPreparer.new(@options).prepare(@task.environments)
          CommandRunner.new(@task, @options, env_vars).execute
        end
      end
    end
  end
end
