# frozen_string_literal: true

module Patcmd
  module CLI
    module Tasks
      class TaskAction
        attr_reader :name, :description, :path, :command, :args, :environments

        def initialize(options)
          @name = options["name"]
          @description = options["description"]
          @command = options["command"]
          @args = options["args"] || []
          @environments = options["environments"] || {}
          @path = options["path"]
        end

        def to_h
          hash = {
            "name" => name,
            "description" => description,
            "command" => command,
            "args" => args,
            "environments" => environments,
            "path" => path,
          }
          hash.reject { |_, value| value.nil? }
        end
      end
    end
  end
end
