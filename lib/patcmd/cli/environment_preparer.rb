# frozen_string_literal: true

module Patcmd
  module CLI
    class EnvironmentPreparer
      def initialize(options = {})
        @options = options
      end

      def prepare(env_vars)
        substitution_vars = prepare_substitution_vars
        env_vars.transform_values { |v| v % substitution_vars }
      end

      private

      def prepare_substitution_vars
        return {} unless @options[:options]

        @options[:options].transform_keys(&:to_sym)
      end
    end
  end
end
