# frozen_string_literal: true

module Patcmd
  module CLI
    class PathResolver
      class << self
        def expand(path)
          return if path.nil? || path.strip.empty?

          # Expand tilde (~) and substitute environment variables
          expanded_path = path.gsub("~", Dir.home)
          expanded_path.gsub!(/\$\{([^\}]+)\}/) { ENV[::Regexp.last_match(1)] || "" }

          # Ensure the path does not double-resolve
          File.expand_path(expanded_path)
        end
      end
    end
  end
end
