# frozen_string_literal: true

require "spec_helper"

RSpec.describe(Patcmd::CLI::TaskExecutor) do
  let(:task) do
    {
      "description" => "Test Task",
      "command" => "echo",
      "args" => ["HelloWorld"],
      "path" => Dir.pwd,
      "environments" => { "TASK_NAME" => "Default" },
    }
  end

  let(:options) { { verbose: true } }

  subject { described_class.new(task, options) }

  describe "#execute" do
    it "executes the task successfully" do
      expect { subject.execute }.to(output(/HelloWorld/).to_stdout)
    end

    context "when the path does not exist" do
      before { allow(Dir).to(receive(:exist?).and_return(false)) }

      it "raises a path not found error" do
        expect { subject.execute }.to(raise_error(SystemExit)
          .and(output(/Path not found/).to_stdout))
      end
    end
  end
end
