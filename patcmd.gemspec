# frozen_string_literal: true

require_relative "lib/patcmd/version"

Gem::Specification.new do |spec|
  spec.name = "patcmd"
  spec.version = Patcmd::VERSION
  spec.authors = ["Huy Nguyen"]
  spec.email = ["patrick204nqh@gmail.com"]

  spec.summary = "A CLI tool for running tasks quickly."
  spec.description = "PatCmd allows you to define and execute tasks using a simple command-line interface."
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
