# frozen_string_literal: true

module Patcmd
  class Task
    attr_accessor :name, :group, :description, :command, :args, :env

    def initialize(name, attributes = {})
      @name        = name
      @description = attributes["description"] || ""
      @group       = attributes["group"] || "default"
      @command     = attributes["command"]
      @args        = attributes["args"] || []
      @env         = attributes["env"] || {}
    end

    def execute
      # Save original environment variables
      original_env = ENV.to_hash
      # Set the specified environment variables
      @env.each { |key, value| ENV[key] = value }

      # Build and run the command string
      full_command = [@command, *@args].join(" ")
      system(full_command)

      # Restore original environment.
      ENV.replace(original_env)
    end
  end
end
