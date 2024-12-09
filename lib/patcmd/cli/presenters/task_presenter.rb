# frozen_string_literal: true

module Patcmd
  module CLI
    module Presenters
      class TaskPresenter
        def initialize(output = $stdout)
          @output = output
        end

        def display(task)
          @output.puts "Category: #{task["category"]}"
          @output.puts "  Name: #{task["name"]}"
          @output.puts "  Action: #{task["action"]}"
          @output.puts "  Description: #{task["description"]}"
          @output.puts "  Path: #{task["path"]}"
          @output.puts "  Command: #{task["command"]}"
          @output.puts "  Args: #{task["args"].join(" ")}" if task["args"]&.any?
          if task["environments"]&.any?
            envs = task["environments"].map { |k, v| "#{k}=#{v}" }.join(", ")
            @output.puts "  Environments: #{envs}"
          end
          @output.puts "-" * 40
        end
      end
    end
  end
end
