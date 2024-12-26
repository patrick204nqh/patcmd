# frozen_string_literal: true

module Patcmd
  module CLI
    module Tasks
      class TaskBuilder
        class << self
          def build_from_options(options)
            validate_options(options)

            Task.new(build_raw_task(options))
          end

          private

          def build_raw_task(options)
            {
              "category" => options[:category],
              "name" => options[:name],
              "description" => options[:description],
              "actions" => [build_raw_action(options)],
            }
          end

          def build_raw_action(options)
            {
              "name" => options[:action],
              "command" => options[:command],
              "path" => options[:path],
              "args" => options[:args] || [],
              "environments" => options[:environments] || {},
            }
          end

          def validate_options(options)
            TaskValidator.validate(options)
          end
        end
      end
    end
  end
end
