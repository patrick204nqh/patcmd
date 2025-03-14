# Patcmd

[![Gem Version](https://badge.fury.io/rb/patcmd.svg)](https://badge.fury.io/rb/patcmd)
[![Build Status](https://github.com/patrick204nqh/patcmd/actions/workflows/ruby.yml/badge.svg)](https://github.com/patrick204nqh/patcmd/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Patcmd is a Ruby gem that provides a command-line interface (CLI) for managing and executing tasks from a YAML configuration file. It helps centralize your terminal commands into one file, making it easy to trigger frequently used tasks with memorable aliases.

## Features

- **Centralized Task Management:** Store your commands and scripts in a single YAML configuration file.
- **Preconfigured Default Task:** When initialized, the configuration file includes a default "hello" task that prints "Hello World."
- **Flexible Task Definitions:** Each task can have a command, arguments, environment variables, description, and group.
- **Easy Command-Line Interface:** Use Thor to quickly add, list, and run tasks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'patcmd'
```

Then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install patcmd
```

## Usage

### Initializing the Configuration File

To create the configuration file (located at `~/.patcmd/config.yml`), run:

```bash
patcmd init
```

This command creates the file with a default task named **hello**. The default task is defined as follows:

```yaml
---
tasks:
  hello:
    command: bash
    args:
    - "-c"
    - '''echo "$GREETING, $TARGET! Args: $ARG1, $ARG2"'''
    env:
      GREETING: Hello
      TARGET: World
      ARG1: Foo
      ARG2: Bar
    description: Print Hello World with multiple arguments and environment variables
    group: default
```

### Listing Tasks

To list all available tasks, run:

```bash
patcmd list
```

### Adding a Task with Multiple Arguments and Environment Variables

You can add custom tasks using the CLI. For example, to add a task called **complex** that demonstrates multiple arguments and environment variables, run:

```bash
patcmd add complex \
  --command "bash" \
  --args "-c" "echo 'Value1: $VAL1, Value2: $VAL2, extra args: arg1 arg2'" \
  --env VAL1=value1,VAL2=value2 \
  --description "A complex task with many args and env variables" \
  --group custom
```

*Note:* The `--env` option is expected to be passed as a hash. Adjust the input format as needed based on your CLI parsing.

### Running a Task

To execute a task, for example the default **hello** task, run:

```bash
patcmd exec hello
```

This command executes the task, applying the defined environment variables and arguments.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/patrick204nqh/patcmd](https://github.com/patrick204nqh/patcmd).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
