# frozen_string_literal: true

module Patcmd
  module CLI
    module Tasks
      class TaskManager
        attr_reader :config, :logger

        def initialize(config)
          @config = config
          @logger = Logger.new
        end

        def add_task(task)
          existing_task = find_task_by_category_and_name(task.category, task.name)

          if existing_task
            updated_task = update_existing_task(existing_task, task)
            merge_task_info_config(updated_task)
          else
            add_new_task(task)
          end
        end

        def find_action(category, name, action)
          task = find_task_by_category_and_name(category, name)
          raise "Task not found for category '#{category}' and name '#{name}'." unless task

          task_action(task, action)
        end

        def all_tasks
          config["tasks"].map { |task_data| Task.new(task_data) }
        end

        private

        def find_task_by_category_and_name(category, name)
          raw_task = config["tasks"].find { |task| task["category"] == category && task["name"] == name }
          raw_task && Task.new(raw_task)
        end

        def task_action(task, action_name)
          action = task.actions.find { |item| item.name == action_name }
          raise "Action '#{action.name}' not found for task '#{task.name}'." unless action
          raise "No path defined for action '#{action}' in task '#{task.name}'." unless action.path

          action
        end

        def add_new_task(task)
          config["tasks"] << task.to_h
          logger.info("Added new task '#{task.name}' under category '#{task.category}'.")
        end

        def update_existing_task(existing_task, new_task_data)
          update_task_path(existing_task, new_task_data.path)
          add_or_update_actions(existing_task, new_task_data.actions)

          existing_task
        end

        def merge_task_info_config(updated_task)
          config["tasks"].each_with_index do |task, index|
            next unless task["category"] == updated_task.category && task["name"] == updated_task.name

            config["tasks"][index] = updated_task.to_h
            logger.info("Merged updated task '#{updated_task.name}' back into the configuration.")
          end
        end

        def update_task_path(existing_task, new_path)
          return unless new_path && existing_task.path != new_path

          logger.info("Updating path for task '#{existing_task.name}' to '#{new_path}'.")
          existing_task.path = new_path
        end

        def add_or_update_actions(existing_task, new_actions)
          new_actions.each do |new_action|
            if existing_task.actions.any? { |item| item.name == new_action.name }
              raise "Action '#{new_action.name}' already exists in task '#{existing_task.name}'."
            end

            existing_task.actions << new_action
            logger.info("Updated task '#{existing_task.name}' with new action: '#{new_action.name}'.")
          end

          # TODO: Update config
        end
      end
    end
  end
end
