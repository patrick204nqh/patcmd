# frozen_string_literal: true

module Patcmd
  module CLI
    module Commands
      class AddCommand < BaseCommand
        default_task :add

        desc "add", "Add a new task to the config"
        method_option :name,         aliases: "-n", required: true, desc: "Task name"
        method_option :description,  aliases: "-d", required: true, desc: "Task description"
        method_option :category,     aliases: "-c", required: true, desc: "Category name"
        method_option :path,         aliases: "-p", required: true, desc: "Execution path"
        method_option :action,       aliases: "-a", required: true, desc: "Action name"
        method_option :command,      aliases: "-m", required: true, desc: "Command to execute"
        method_option :args,         aliases: "-g", type: :array, default: [], desc: "Arguments for the command"
        method_option :environments, aliases: "-e", type: :hash, default: {}, desc: "Environment variables"

        def add
          task = Services::TaskBuilder.build_from_options(options)
          Services::TaskValidator.validate(task)
          config_manager.add_task(task)
          Presenters::TaskPresenter.new($stdout).display(task)
          logger.success(
            "Added task '#{task["name"]}' under category '#{task["category"]}' with action '#{task["action"]}'.",
          )
        rescue Services::TaskValidator::ValidationError => e
          logger.error("Error: #{e.message}")
          exit(1)
        end
      end
    end
  end
end
