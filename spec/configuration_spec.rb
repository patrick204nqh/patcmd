# frozen_string_literal: true

require "spec_helper"
require "yaml"
require "fileutils"

RSpec.describe(Patcmd::Configuration) do
  describe ".exists?" do
    it "returns false if the config file does not exist" do
      expect(Patcmd::Configuration.exists?).to(eq(false))
    end
  end

  describe ".create_default" do
    it "creates a default config file with the hello task" do
      Patcmd::Configuration.create_default
      expect(Patcmd::Configuration.exists?).to(eq(true))
      config = YAML.load_file(Patcmd::Configuration::CONFIG_PATH)
      expect(config["tasks"]).to(have_key("hello"))
    end
  end

  describe ".load_config" do
    context "when the config file does not exist" do
      it "creates and loads the default configuration" do
        config = Patcmd::Configuration.load_config
        expect(config).to(have_key("tasks"))
        expect(config["tasks"]).to(have_key("hello"))
      end
    end

    context "when the config file exists" do
      it "loads the existing configuration" do
        custom_config = {
          "tasks" => {
            "sample" => {
              "command" => "echo",
              "args" => ["Test"],
              "env" => {},
              "description" => "sample",
              "group" => "default",
            },
          },
        }
        File.write(Patcmd::Configuration::CONFIG_PATH, custom_config.to_yaml)
        config = Patcmd::Configuration.load_config
        expect(config["tasks"]).to(have_key("sample"))
      end
    end
  end

  describe ".add_task" do
    it "adds a new task to the configuration file" do
      Patcmd::Configuration.create_default
      new_task = {
        "command" => "echo",
        "args" => ["New Task"],
        "env" => { "KEY" => "value" },
        "description" => "A new task",
        "group" => "default",
      }
      Patcmd::Configuration.add_task("new_task", new_task)
      config = YAML.load_file(Patcmd::Configuration::CONFIG_PATH)
      expect(config["tasks"]).to(have_key("new_task"))
      expect(config["tasks"]["new_task"]["command"]).to(eq("echo"))
    end
  end
end
