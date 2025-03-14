# frozen_string_literal: true

require "spec_helper"

RSpec.describe(Patcmd::Task) do
  let(:task_data) do
    {
      "command" => "echo",
      "args" => ["Hello"],
      "env" => { "GREETING" => "Hello" },
      "description" => "Test task",
      "group" => "default",
    }
  end
  subject { Patcmd::Task.new("test", task_data) }

  describe "#execute" do
    it "builds and calls the system command correctly" do
      # Stub system to prevent executing an actual command
      expect(subject).to(receive(:system).with("echo Hello"))
      subject.execute
    end

    it "sets and restores environment variables" do
      original_env = ENV.to_hash.dup
      allow(subject).to(receive(:system))
      subject.execute
      expect(ENV.to_hash).to(eq(original_env))
    end
  end
end
