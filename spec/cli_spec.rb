# frozen_string_literal: true

require "spec_helper"

RSpec.describe(Patcmd::CLI) do
  describe "init command" do
    it "initializes configuration if it does not exist" do
      output = capture_stdout { Patcmd::CLI.start(["init"]) }
      expect(output).to(include("Initialized configuration file"))
    end

    it "warns if the configuration already exists" do
      Patcmd::Configuration.create_default
      output = capture_stdout { Patcmd::CLI.start(["init"]) }
      expect(output).to(include("Configuration file already exists"))
    end
  end

  describe "list command" do
    it "lists tasks when tasks exist" do
      Patcmd::Configuration.create_default
      output = capture_stdout { Patcmd::CLI.start(["list"]) }
      expect(output).to(include("hello -"))
    end

    it "warns when no tasks are found" do
      # Write an empty configuration.
      File.write(Patcmd::Configuration::CONFIG_PATH, { "tasks" => {} }.to_yaml)
      output = capture_stdout { Patcmd::CLI.start(["list"]) }
      expect(output).to(include("No tasks found"))
    end
  end

  describe "add command" do
    it "adds a new task with proper options" do
      output = capture_stdout do
        Patcmd::CLI.start(
          [
            "add",
            "test_task",
            "--command",
            "echo",
            "--args",
            "Hello",
            "World",
            "--env",
            "KEY:value",
            "--description",
            "Test task",
            "--group",
            "test",
          ],
        )
      end

      expect(output).to(include("Task 'test_task' added successfully"))

      tasks = Patcmd::Configuration.load_tasks
      expect(tasks).to(have_key("test_task"))
      expect(tasks["test_task"]["command"]).to(eq("echo"))
      expect(tasks["test_task"]["args"]).to(eq(["Hello", "World"]))
      expect(tasks["test_task"]["env"]).to(eq({ "KEY" => "value" }))
      expect(tasks["test_task"]["description"]).to(eq("Test task"))
      expect(tasks["test_task"]["group"]).to(eq("test"))
    end
  end

  describe "exec command" do
    context "when the task exists" do
      before do
        # Add a task directly into the configuration.
        Patcmd::Configuration.add_task("exec_test", {
          "command" => "echo",
          "args" => ["ExecTest"],
          "env" => {},
          "description" => "Exec test task",
          "group" => "default",
        })
      end

      it "executes the task and prints the running message" do
        # Stub out the actual execution to avoid running real commands.
        expect_any_instance_of(Patcmd::Task).to(receive(:execute))
        output = capture_stdout { Patcmd::CLI.start(["exec", "exec_test"]) }
        expect(output).to(include("Running task 'exec_test'"))
      end
    end

    context "when the task does not exist" do
      it "prints an error message and exits" do
        expect do
          capture_stdout { Patcmd::CLI.start(["exec", "nonexistent"]) }
        end.to(raise_error(SystemExit))
      end
    end
  end
end
