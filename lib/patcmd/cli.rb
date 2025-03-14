# frozen_string_literal: true

require "thor"
require_relative "commands/version"
require_relative "commands/init"
require_relative "commands/list"
require_relative "commands/add"
require_relative "commands/exec"

module Patcmd
  class CLI < Thor
    class << self
      def exit_on_failure?
        true
      end
    end

    # Register subcommands with Thor
    register(Commands::Version, "version", "version", "Show Patcmd gem version")
    register(Commands::Init, "init", "init", "Initialize configuration file")
    register(Commands::List, "list", "list", "List all tasks")
    register(Commands::Add, "add", "add NAME", "Add a new task")
    register(Commands::Exec, "exec", "exec NAME", "Exec a specific task")
  end
end
