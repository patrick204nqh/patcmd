# frozen_string_literal: true

module Patcmd
  module CLI
    class ListCommand < BaseCommand
      default_task :list

      desc "list", "List all configured tasks"
      def list
        tasks = config_manager.all_tasks
        if tasks.empty?
          puts "No tasks configured."
        else
          tasks.each { |task| display_task(task) }
        end
      end
    end
  end
end
