# frozen_string_literal: true

module Patcmd
  module CLI
    class Logger
      COLORS = {
        info: "\e[34m", # Blue
        success: "\e[32m", # Green
        error: "\e[31m", # Red
        warn: "\e[33m", # Yellow
        reset: "\e[0m", # Reset
      }.freeze

      def initialize(verbose: false)
        @verbose = verbose
      end

      def info(message)
        log(:info, message)
      end

      def success(message)
        log(:success, message)
      end

      def error(message)
        log(:error, message)
      end

      def warn(message)
        log(:warn, message)
      end

      private

      def log(level, message)
        return unless @verbose || level == :error

        color = COLORS[level] || COLORS[:info]
        puts "#{color}[#{level.to_s.upcase}]#{COLORS[:reset]} #{message}"
      end
    end
  end
end
