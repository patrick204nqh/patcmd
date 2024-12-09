# frozen_string_literal: true

module Patcmd
  module CLI
    module Commands
      class ListCommand < BaseCommand
        default_task :list

        desc "list", "List all configured tasks"
        def list
          tasks = config_manager.all_tasks
          if tasks.empty?
            logger.info("No tasks configured.")
          else
            presenter = Presenters::TaskPresenter.new($stdout)
            tasks.each { |task| presenter.display(task) }
          end
        rescue StandardError => e
          logger.error("An error occurred while listing tasks: #{e.message}")
          exit(1)
        end
      end
    end
  end
end
