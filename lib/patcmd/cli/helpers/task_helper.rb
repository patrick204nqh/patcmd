# frozen_string_literal: true

module Patcmd
  module CLI
    module Helpers
      module TaskHelper
        class ValidationError < StandardError; end

        def validate_task(task)
          required_fields = ["name", "description", "category", "path", "action", "command"]
          missing_fields = required_fields.select { |field| task[field].nil? || task[field].strip.empty? }

          unless missing_fields.empty?
            raise ValidationError, "Missing required fields: #{missing_fields.join(", ")}"
            exit(1)
          end

          unless task["args"].is_a?(Array)
            rails(ValidationError, "The 'args' field must be an array.")
            exit(1)
          end

          unless task["environments"].is_a?(Hash)
            rails(ValidationError, "The 'environments' field must be a hash.")
            exit(1)
          end
        end

        def display_task(task)
          puts "Category: #{task["category"]}"
          puts "  Name: #{task["name"]}"
          puts "  Action: #{task["action"]}"
          puts "  Description: #{task["description"]}"
          puts "  Path: #{task["path"]}"
          puts "  Command: #{task["command"]}"
          puts "  Args: #{task["args"].join(" ")}" if task["args"].any?
          if task["environments"].any?
            envs = task["environments"].map { |k, v| "#{k}=#{v}" }.join(", ")
            puts "  Environments: #{envs}"
          end
          puts "-" * 40
        end
      end
    end
  end
end
