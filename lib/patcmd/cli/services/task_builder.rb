# frozen_string_literal: true

module Patcmd
  module CLI
    module Services
      class TaskBuilder
        class << self
          def build_from_options(options)
            {
              "name" => options[:name],
              "description" => options[:description],
              "category" => options[:category],
              "path" => options[:path],
              "action" => options[:action],
              "command" => options[:command],
              "args" => options[:args],
              "environments" => options[:environments],
            }
          end
        end
      end
    end
  end
end
