# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "patcmd/version"

Gem::Specification.new do |spec|
  spec.name = "patcmd"
  spec.version = Patcmd::VERSION
  spec.authors = ["Huy Nguyen"]
  spec.email = ["patrick204nqh@gmail.com"]

  spec.summary = "A CLI tool to manage tasks using a YAML configuration."
  spec.description = "Patcmd is a Ruby CLI tool that centralizes command execution via a YAML config file."
  spec.homepage = "https://github.com/patrick204nqh/patcmd"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/patrick204nqh/patcmd"
  spec.metadata["changelog_uri"] = "https://github.com/patrick204nqh/patcmd/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(["git", "ls-files", "-z"], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?("bin/", "spec/", ".git", ".github", "Gemfile")
    end
  end
  spec.bindir = "bin"
  spec.executables = ["patcmd"]
  spec.require_paths = ["lib"]

  spec.add_dependency("thor")
end
