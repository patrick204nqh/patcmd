# frozen_string_literal: true

require_relative "base"
require "patcmd/version"

module Patcmd
  module Commands
    class Version < Base
      desc "version", "Show Patcmd gem version"
      def execute(*)
        say("Patcmd version #{Patcmd::VERSION}", :green)
      end
    end
  end
end
