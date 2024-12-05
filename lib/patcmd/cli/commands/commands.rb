# frozen_string_literal: true

require "thor"

require_relative "core"

module Patcmd
  module CLI
    class << self
      def start(argv)
        Core.start(argv)
      end
    end
  end
end
