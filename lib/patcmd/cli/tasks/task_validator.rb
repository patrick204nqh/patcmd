# frozen_string_literal: true

module Patcmd
  module CLI
    module Tasks
      class TaskValidator
        class ValidationError < StandardError; end

        REQUIRED_OPTIONS = ["category", "name", "description", "path", "action", "command"].freeze

        class << self
          def validate(options)
            missing_options = REQUIRED_OPTIONS.select { |option| options[option].nil? || options[option].strip.empty? }

            unless missing_options.empty?
              raise ValidationError, "Missing required options: #{missing_options.join(", ")}"
            end

            unless options["args"].is_a?(Array)
              raise ValidationError, "The 'args' option must be an array."
            end

            unless options["environments"].is_a?(Hash)
              raise ValidationError, "The 'environments' option must be a hash."
            end

            true
          end
        end
      end
    end
  end
end
