# frozen_string_literal: true

require_relative "base"
require "patcmd/configuration"
require "patcmd/task"

module Patcmd
  module Commands
    class Exec < Base
      desc "exec NAME", "Exec a specific task"
      def execute(name)
        tasks = Configuration.load_tasks
        unless tasks[name]
          say("Task '#{name}' not found.", :red)
          exit(1)
        end
        task = Task.new(name, tasks[name])
        say("Running task '#{name}'...", :green)
        task.execute
      end
    end
  end
end
