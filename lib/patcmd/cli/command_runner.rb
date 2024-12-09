# frozen_string_literal: true

module Patcmd
  module CLI
    class CommandRunner
      def initialize(task, options, env_vars)
        @task = task
        @options = options
        @env_vars = env_vars
      end

      def execute
        command = prepare_command
        path = PathResolver.expand(@task.path)

        unless Dir.exist?(path)
          puts "Path not found: #{path}"
          exit(1)
        end

        puts "Executing '#{@task.description}' in #{path}"
        puts "Command: #{command}" if @options[:verbose]
        puts "Environment Variables: #{@env_vars}" if @options[:verbose] && @env_vars.any?

        Dir.chdir(path) do
          result = system(@env_vars, command)
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
        substitution_vars = @options[:options] ? @options[:options].transform_keys(&:to_sym) : {}
        cmd = @task.command % substitution_vars
        args = @task.args.map { |arg| arg % substitution_vars }
        ([cmd] + args).join(" ")
      end
    end
  end
end
