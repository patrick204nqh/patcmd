# frozen_string_literal: true

require_relative "base"
require "patcmd/configuration"
require "patcmd/task"

module Patcmd
  module Commands
    class List < Base
      desc "list", "List all tasks"
      def execute(*)
        tasks = Configuration.load_tasks
        if tasks.empty?
          say("No tasks found. Use 'patcmd add <name>' to add tasks.", :yellow)
        else
          tasks.each do |name, task_data|
            task = Task.new(name, task_data)
            say("#{name} - #{task.description}", :blue)
          end
        end
      end
    end
  end
end
