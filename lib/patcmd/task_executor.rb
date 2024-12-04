# frozen_string_literal: true

module Patcmd
  class TaskExecutor
    require "shellwords"

    def initialize(task, options)
      @task = task
      @options = options
    end

    def execute
      command = prepare_command
      env_vars = prepare_environment_variables
      path = expand_path(@task["path"])

      unless Dir.exist?(path)
        puts "Path not found: #{path}"
        exit(1)
      end

      puts "Executing '#{@task["description"]}' in #{path}"
      puts "Command: #{command}" if @options[:verbose]
      puts "Environment Variables: #{env_vars}" if @options[:verbose] && env_vars.any?

      Dir.chdir(path) do
        result = system(env_vars, command)
        unless result
          puts "Command execution failed."
          exit(1)
        end
      end
    rescue KeyError => e
      puts "Missing option for command substitution: #{e.message}"
      exit(1)
    end

    private

    def prepare_command
      cmd = @task["command"]
      args = @task["args"] || []

      # Handle command substitution
      if @options[:options] && !@options[:options].empty?
        substitution_vars = @options[:options].transform_keys(&:to_sym)
        cmd %= substitution_vars
        args = args.map { |arg| arg % substitution_vars }
      end

      ([cmd] + args).join(" ")
    end

    def prepare_environment_variables
      env_vars = @task["environments"] || {}

      if @options[:options] && !@options[:options].empty?
        substitution_vars = @options[:options].transform_keys(&:to_sym)
        env_vars = env_vars.transform_values { |v| v % substitution_vars }
      end

      env_vars
    end

    def expand_path(path)
      File.expand_path(path.gsub("~", Dir.home))
    end
  end
end
