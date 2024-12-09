# frozen_string_literal: true

module Patcmd
  module CLI
    module Services
      class TaskValidator
        class ValidationError < StandardError; end

        REQUIRED_FIELDS = ["name", "description", "category", "path", "action", "command"].freeze

        class << self
          def validate(task)
            missing_fields = REQUIRED_FIELDS.select { |field| task[field].nil? || task[field].strip.empty? }

            unless missing_fields.empty?
              raise ValidationError, "Missing required fields: #{missing_fields.join(", ")}"
            end

            unless task["args"].is_a?(Array)
              raise ValidationError, "The 'args' field must be an array."
            end

            unless task["environments"].is_a?(Hash)
              raise ValidationError, "The 'environments' field must be a hash."
            end

            true
          end
        end
      end
    end
  end
end
