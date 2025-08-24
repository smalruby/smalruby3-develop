# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is Smalruby 3 Development Environment - a containerized development environment for Smalruby 3.0, which is a Ruby-based visual programming environment forked from MIT's Scratch 3.0. The project consists of three main components:

- **GUI (smalruby3-gui)**: React-based web interface forked from scratch-gui
- **Virtual Machine (scratch-vm)**: JavaScript virtual machine for executing programs
- **Ruby Library (smalruby3)**: 2D game development library for Ruby

## Architecture

The project uses a Docker-based development environment with two main services:

- `gui`: Frontend development server running on port 8601
- `lib`: Ruby library development environment with VNC access on port 15900

The GUI component is a customized version of Scratch 3.0 that:

- Integrates with Ruby through Opal transpilation
- Includes custom blocks and extensions for Ruby programming
- Uses ace-builds for code editing capabilities
- Supports both visual block programming and Ruby code

The project structure includes git submodules for `gui/scratch-vm` and `gui/smalruby3-gui`.

## Development Commands

### Docker Environment
```bash
# Build the GUI service
docker compose build gui

# Start development server (GUI available at http://localhost:8601)
docker compose up gui

# Start with debug configuration
docker compose --env-file ./config/.env.debug up gui

# Stop services
docker compose stop gui
```

### GUI Development (smalruby3-gui)
```bash
# Navigate to GUI directory
cd gui/smalruby3-gui

# Install dependencies
npm install

# Development server (port 8601)
npm start

# Build production bundle
npm run build

# Run tests
npm test
npm run test:unit
npm run test:integration
npm run test:lint

# Setup Opal (Ruby-to-JavaScript transpiler)
npm run setup-opal

# Setup scratch-vm dependency
npm run setup-scratch-vm
```

### Virtual Machine Development (scratch-vm)

```bash
# Navigate to VM directory
cd gui/scratch-vm

# Install dependencies
npm install

# Development server with playground (port 8073)
npm start

# Build standalone
npm run build

# Run tests
npm test
npm run tap:unit
npm run tap:integration
npm run lint

# Generate documentation
npm run docs
```

### Ruby Library Development (smalruby3)

```bash
# Navigate to Ruby library
cd lib/smalruby3

# Install Ruby dependencies
bundle install

# Run Ruby tests
rake test
```

## Key Files and Directories

- `docker-compose.yml`: Docker services configuration
- `gui/smalruby3-gui/`: React-based web interface with Ruby integration
  - `opal/`: Opal transpiler configuration and build files
  - `scripts/make-setup-opal.js`: Opal setup automation
- `gui/scratch-vm/`: Virtual machine for executing programs
  - `src/`: VM source code including extensions
  - `playground/`: Development playground interface
- `lib/smalruby3/`: Ruby 2D game development library
- `config/`: Environment configuration files

## Testing

The project uses different testing frameworks for different components:

- **GUI**: Jest for unit tests, integration tests with headless Chrome
- **VM**: TAP testing framework with coverage reporting
- **Ruby**: Standard Ruby testing with Rake

## Merge Conflicts

Note: The smalruby3-gui package.json contains merge conflict markers from upstream scratch-gui integration. These should be resolved before making changes to the GUI component.

## Dependencies

- Node.js for JavaScript components
- Docker for containerized development
- Ruby 2.5.3+ for Ruby library
- Chrome/Chromium for integration testing
