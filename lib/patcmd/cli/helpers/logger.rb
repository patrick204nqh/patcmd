# frozen_string_literal: true

module Patcmd
  module CLI
    module Helpers
      module Logger
        # Logs an informational message with a timestamp.
        #
        # @param message [String] The message to log.
        # @return [void]
        def log_info(message)
          puts "[INFO] #{Time.now.strftime("%Y-%m-%d %H:%M:%S")} - #{message}"
        end

        # Logs an error message with a timestamp.
        #
        # @param message [String] The message to log.
        # @return [void]
        def log_error(message)
          puts "[ERROR] #{Time.now.strftime("%Y-%m-%d %H:%M:%S")} - #{message}"
        end
      end
    end
  end
end
