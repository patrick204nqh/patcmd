# frozen_string_literal: true

require "thor"

require_relative "commands/core"

module Patcmd
  module CLI
    class << self
      def start(argv)
        Commands::Core.start(argv)
      end
    end
  end
end