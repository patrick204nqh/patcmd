# frozen_string_literal: true

module Patcmd
  class CLI < Thor
    CONFIG_PATH = File.expand_path("~/.patcmd/config.yml")

    class_option :config, type: :string, default: CONFIG_PATH, desc: "Path to configuration file"

    desc "init", "Initialize the PatCmd configuration"
    def init
      config_manager = ConfigManager.new(options[:config])
      config_manager.init_config
      puts "Configuration initialized at #{options[:config]}"
    end

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
      config_manager = ConfigManager.new(options[:config])
      task = {
        "name" => options[:name],
        "description" => options[:description],
        "category" => options[:category],
        "path" => options[:path],
        "action" => options[:action],
        "command" => options[:command],
        "args" => options[:args],
        "environments" => options[:environments],
      }

      validate_task(task)
      config_manager.add_task(task)
      puts "Added task '#{task["name"]}' under category '#{task["category"]}' with action '#{task["action"]}'."
    end

    desc "list", "List all configured tasks"
    def list
      config_manager = ConfigManager.new(options[:config])
      tasks = config_manager.all_tasks

      if tasks.empty?
        puts "No tasks configured."
      else
        tasks.each do |task|
          puts "Category: #{task["category"]}"
          puts "  Name: #{task["name"]}"
          puts "  Action: #{task["action"]}"
          puts "  Description: #{task["description"]}"
          puts "  Path: #{task["path"]}"
          puts "  Command: #{task["command"]}"
          puts "  Args: #{task["args"]&.join(" ")}" if task["args"]&.any?
          if task["environments"]&.any?
            envs = task["environments"].map { |k, v| "#{k}=#{v}" }.join(", ")
            puts "  Environments: #{envs}"
          end
          puts "-" * 40
        end
      end
    end

    desc "exec CATEGORY NAME ACTION", "Execute a defined task"
    method_option :options, aliases: "-o", type: :hash, default: {}, desc: "Options for command substitution"
    method_option :verbose, aliases: "-v", type: :boolean, default: false, desc: "Enable verbose output"
    def exec(category, name, action)
      config_manager = ConfigManager.new(options[:config])
      task = config_manager.find_task(category, name, action)

      if task
        executor = TaskExecutor.new(task, options)
        executor.execute
      else
        puts "Task not found for category '#{category}', name '#{name}', and action '#{action}'."
        exit(1)
      end
    end

    private

    def validate_task(task)
      required_fields = ["name", "description", "category", "path", "action", "command"]
      missing_fields = required_fields.select { |field| task[field].nil? || task[field].strip.empty? }
      unless missing_fields.empty?
        puts "Missing required fields: #{missing_fields.join(", ")}"
        exit(1)
      end

      # Validate that args is an array if provided
      if task["args"] && !task["args"].is_a?(Array)
        puts "The 'args' field must be an array."
        exit(1)
      end

      # Validate that environments is a hash if provided
      if task["environments"] && !task["environments"].is_a?(Hash)
        puts "The 'environments' field must be a hash."
        exit(1)
      end
    end
  end
end
