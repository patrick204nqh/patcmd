# frozen_string_literal: true

module Patcmd
  module CLI
    class CommandRunner
      def initialize(task, options, env_vars)
        @task = task
        @options = options
        @env_vars = env_vars
        @logger = Logger.new(verbose: options[:verbose])
      end

      def execute
        command = prepare_command
        path = PathResolver.expand(@task.path)

        unless Dir.exist?(path)
          @logger.error("Path not found: #{path}")
          exit(1)
        end

        @logger.info("Executing '#{@task.description}' in #{path}")
        @logger.info("Command: #{command}") if @options[:verbose]
        @logger.info("Environment Variables: #{@env_vars}") if @options[:verbose] && @env_vars.any?

        Dir.chdir(path) do
          result = system(@env_vars, command)
          unless result
            @logger.error("Command execution failed.")
            exit(1)
          end
        end
        @logger.success("Command executed successfully.")
      rescue KeyError => e
        @logger.error("Missing option for command substitution: #{e.message}")
        exit(1)
      end

      private

      def prepare_command
        substitution_vars = @options[:options] ? @options[:options].transform_keys(&:to_sym) : {}
        cmd = @task.command % substitution_vars
        args = @task.args.map { |arg| arg % substitution_vars }
        ([cmd] + args).join(" ")
      end
    end
  end
end
