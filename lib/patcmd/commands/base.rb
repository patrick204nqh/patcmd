# frozen_string_literal: true

require "thor"

module Patcmd
  module Commands
    class Base < Thor
      default_task :execute

      desc "execute", "Execute the command"
      def execute
        raise NotImplementedError
      end
    end
  end
end
