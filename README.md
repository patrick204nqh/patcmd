# PatCmd

[![Gem Version](https://badge.fury.io/rb/patcmd.svg)](https://badge.fury.io/rb/patcmd)
[![Build Status](https://github.com/patrick204nqh/patcmd/actions/workflows/ruby.yml/badge.svg)](https://github.com/patrick204nqh/patcmd/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

PatCmd is a Ruby-based command-line interface (CLI) tool built with Thor, designed to manage and execute tasks efficiently. Whether you're automating scripts, managing deployments, or handling routine operations, PatCmd provides a streamlined and customizable solution.

## Features

- **Task Management:** Easily add, list, and execute tasks.
- **Configurable Environments:** Define environment variables per task.
- **Extensible:** Add new commands and functionalities as needed.
- **User-Friendly:** Intuitive CLI with clear help documentation.

## Installation

Ensure you have [Ruby](https://www.ruby-lang.org/en/downloads/) (version 3.0 or higher) installed on your system.

### Install via RubyGems

```bash
gem install patcmd
```

### From Source

1. Clone the Repository:

```bash
git clone https://github.com/yourusername/patcmd.git
cd patcmd
```

2. Build the Gem:

```bash
gem build patcmd.gemspec
```

3. Install the Gem Locally:

```bash
gem install ./patcmd-0.1.0.gem
```

## Usage

After installation, you can use `patcmd` directly from your terminal.

### Initialize Configuration

Initialize the PatCmd configuration file. This creates a default configuration file where tasks are stored.

```bash
patcmd init
```

Example Output:

```bash
Configuration initialized at /home/username/.patcmd/config.yml
```

### Add a New Task

```bash
patcmd add \                   
  --name "Backup" \
  --description "Backup the database" \
  --category "Utility" \
  --path "/usr/local/bin" \
  --action "execute" \
  --command "backup_db" \
  --args db1 db2 \
  --environments NOdE
```

### List All Tasks

Display all configured tasks.

```bash
patcmd list
```

### Execute a Task

```bash
patcmd exec Utility Backup execute
```

### Help

Access help information for all commands or a specific command.

```bash
patcmd help
patcmd help add
patcmd help list
```

### Configuration

PatCmd uses a YAML configuration file to store tasks and settings. The default configuration file is located at `~/.patcmd/config.yml`. You can specify a different configuration file using the --config option.

**Example:**

```bash
patcmd list --config=/path/to/custom_config.yml
```