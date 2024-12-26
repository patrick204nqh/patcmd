# frozen_string_literal: true

module Patcmd
  module CLI
    module Presenters
      class TaskPresenter
        def initialize(output = $stdout)
          @output = output
        end

        def display(task)
          @output.puts "Category: #{task.category}"
          @output.puts "  Name: #{task.name}"
          @output.puts "  Description: #{task.description}" if task.description
          @output.puts "  Path: #{task.path}" if task.path
          @output.puts "  Actions:"
          task.actions.each do |action|
            @output.puts "    Name: #{action.name}"
            @output.puts "    Description: #{action.description}" if action.description
            @output.puts "    Command: #{action.command}"
            @output.puts "    Path: #{action.path}" if action.path
            @output.puts "    Args: #{action.args.join(" ")}" unless action.args.empty?
            @output.puts "    Environments:"
            action.environments.each do |key, value|
              @output.puts "      #{key}: #{value}"
            end
          end
          @output.puts "-" * 40
        end
      end
    end
  end
end
