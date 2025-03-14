# frozen_string_literal: true

require_relative "base"
require "patcmd/configuration"

module Patcmd
  module Commands
    class Add < Base
      desc "add NAME", "Add a new task"
      option :description, desc: "Task description"
      option :group, desc: "Task group"
      option :command, required: true, desc: "The command to run"
      option :args, type: :array, default: [], desc: "Command arguments"
      option :env, type: :hash, default: {}, desc: "Environment variables"
      def execute(name)
        new_task = {
          "description" => options[:description] || "",
          "group" => options[:group] || "default",
          "command" => options[:command],
          "args" => options[:args],
          "env" => options[:env],
        }
        Configuration.add_task(name, new_task)
        say("Task '#{name}' added successfully.", :green)
      end
    end
  end
end
