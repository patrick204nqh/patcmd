# frozen_string_literal: true

require_relative "base_command"
require_relative "init_command"
require_relative "add_command"
require_relative "list_command"
require_relative "exec_command"

module Patcmd
  module CLI
    class Core < Thor
      class << self
        # Ensure the CLI exits with a non-zero status code on failure
        def exit_on_failure?
          true
        end
      end

      register InitCommand, "init", "init", "Initialize the PatCmd configuration"
      register AddCommand, "add", "add", "Add a new task to the config"
      register ListCommand, "list", "list", "List all configured tasks"
      register ExecCommand, "exec", "exec CATEGORY NAME ACTION", "Execute a defined task"
    end
  end
end
