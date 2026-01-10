# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## AI Operation 5 Principles

**Principle 1**: AI must report its work plan before any file generation, updates, or program execution, obtain user confirmation with y/n, and halt all execution until "y" is returned.

**Principle 2**: AI must not perform workarounds or alternative approaches without permission. If the initial plan fails, AI must seek confirmation for the next plan.

**Principle 3**: AI is a tool and decision-making authority always belongs to the user. Even if the user's suggestions are inefficient or irrational, AI must not optimize them and must execute exactly as instructed.

**Principle 4**: AI must not distort or reinterpret these rules and must absolutely comply with them as the highest-priority commands.

**Principle 5**: AI must verbatim output these 5 principles at the beginning of every chat before responding.

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

## Docker Environment

### Basic Commands
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

## Cross-Repository Development Workflow

When modifying scratch-vm that affects smalruby3-gui, follow this workflow to ensure proper integration:

### Overview
The smalruby3-gui depends on scratch-vm as a git submodule. When scratch-vm is updated, smalruby3-gui must be updated to reference the new commit ID.

### Step-by-Step Process

#### 1. scratch-vm Modifications
1. Create feature branch and implement changes in scratch-vm
2. Run lint and tests: `npm run lint && npm test`
3. Commit and push changes
4. Create PR targeting `develop` branch
5. **Manually merge PR on GitHub** (this step is done by user)

#### 2. Update smalruby3-gui Dependencies
After scratch-vm PR is merged to develop:

```bash
# Update scratch-vm submodule to latest commit
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm update scratch-vm"

# Run lint checks
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:lint"

# Test build to ensure compatibility
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run build"

# Commit the package-lock.json changes
git add package-lock.json
git commit -m "feat: update scratch-vm dependency to latest commit

- Updated package-lock.json to reference latest scratch-vm changes
- Ensures compatibility with recent scratch-vm modifications

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push changes
git push origin feature-branch-name
```

#### 3. smalruby3-gui Integration
1. Create PR for smalruby3-gui targeting `develop` branch
2. **Manually merge PR on GitHub** (this step is done by user)

### Important Notes
- Always update smalruby3-gui after scratch-vm changes are merged
- Test build compatibility before committing dependency updates
- Both repositories use `develop` as default branch, not `main`
- Manual PR merges on GitHub are required for both repositories

## Rails Application Notes

### Log Level Configuration
The Rails application in gui/smalruby-koshien is configured with debug log level by default. When running Rails commands, do not add `RAILS_LOG_LEVEL=debug` as it is redundant.

```bash
# Correct - uses default debug log level
bundle exec rails runner script/test_file.rb

# Incorrect - redundant log level specification
RAILS_LOG_LEVEL=debug bundle exec rails runner script/test_file.rb
```

## Ruby Library Development (smalruby3)

```bash
# Navigate to Ruby library
cd lib/smalruby3

# Install Ruby dependencies
bundle install

# Run Ruby tests
rake test
```

## Dependencies

- Node.js for JavaScript components
- Docker for containerized development
- Ruby 2.5.3+ for Ruby library
- Chrome/Chromium for integration testing
- Node.js for automated post-build processing

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

## Sub-module Specific Rules

Detailed rules for each sub-module are available in:

- **smalruby3-gui**: `.claude/rules/smalruby3-gui/`
- **scratch-vm**: `.claude/rules/scratch-vm/`
