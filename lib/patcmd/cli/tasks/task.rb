# frozen_string_literal: true

module Patcmd
  module CLI
    module Tasks
      class Task
        attr_reader :category, :name, :description, :path, :actions

        def initialize(options)
          @category = options["category"]
          @name = options["name"]
          @description = options["description"]
          @path = options["path"]
          @actions = build_actions(options["actions"])
        end

        def to_h
          hash = {
            "category" => category,
            "name" => name,
            "description" => description,
            "path" => path,
            "actions" => actions.map(&:to_h),
          }
          hash.reject { |_, value| value.nil? }
        end

        private

        def build_actions(actions)
          actions.map do |action|
            build_action(action)
          end
        end

        def build_action(action)
          action["path"] ||= path

          TaskAction.new(action)
        end
      end
    end
  end
end
