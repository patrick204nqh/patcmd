# frozen_string_literal: true

require_relative "base"
require "patcmd/configuration"

module Patcmd
  module Commands
    class Init < Base
      desc "init", "Initialize configuration file"
      def execute(*)
        if Configuration.exists?
          say("Configuration file already exists at #{Configuration::CONFIG_PATH}", :yellow)
        else
          Configuration.create_default
          say("Initialized configuration file at #{Configuration::CONFIG_PATH}", :green)
        end
      end
    end
  end
end
