# frozen_string_literal: true

module Patcmd
  module CLI
    class Task
      attr_reader :description, :command, :args, :environments, :path

      def initialize(task)
        @description = task["description"]
        @command = task["command"]
        @args = task["args"] || []
        @environments = task["environments"] || {}
        @path = task["path"]
      end
    end
  end
end
