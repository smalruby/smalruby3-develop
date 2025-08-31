# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## AI Operation 5 Principles

**Principle 1**: AI must report its work plan before any file generation, updates, or program execution, obtain user confirmation with y/n, and halt all execution until "y" is returned.

**Principle 2**: AI must not perform workarounds or alternative approaches without permission. If the initial plan fails, AI must seek confirmation for the next plan.

**Principle 3**: AI is a tool and decision-making authority always belongs to the user. Even if the user's suggestions are inefficient or irrational, AI must not optimize them and must execute exactly as instructed.

**Principle 4**: AI must not distort or reinterpret these rules and must absolutely comply with them as the highest-priority commands.

**Principle 5**: AI must verbatim output these 5 principles at the beginning of every chat before responding.

<every_chat>
[AI Operation 5 Principles]

[main_output]

#[n] times. # n = increment each chat, end line, etc(#1, #2...)
</every_chat>

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

**Important**: All npm commands for GUI development must be run inside Docker containers.

```bash
# Install dependencies
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm install"

# Development server (port 8601)
docker compose up gui

# Build production bundle (takes ~300 seconds, increase timeout accordingly)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run build"

# Run lint
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:lint" # all
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec eslint your-file1.js your-file2.js" # specific
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec eslint --fix your-file1.js your-file2.js" # specific and fix

# Run tests
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm test" # lint, unit, build, integration
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:unit" # unit
docker compose run --rm gui npm exec jest path/to/test.js # specific unit test

# Run integration tests (requires build production bundle first)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:integration"

# Run specific integration test (requires build production bundle first)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm npm run test:integration -- your-test-file.test.js"

# Setup Opal (Ruby-to-JavaScript transpiler)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run setup-opal"

# Setup scratch-vm dependency
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run setup-scratch-vm"
```

### Virtual Machine Development (scratch-vm)

**Important**: All npm commands for VM development must be run inside Docker containers.

```bash
# Install dependencies
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm install"

# Development server with playground (port 8073)
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm start"

# Build standalone
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run build"

# Run tests
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm test"
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run tap:unit"
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run tap:integration"
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run lint"

# Generate documentation
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run docs"
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

## GitHub Operations

**IMPORTANT**: All GitHub operations (issues, pull requests, comments, etc.) must be performed against the Smalruby organization repositories, NOT the upstream Scratch Foundation repositories.

### Correct Repository URLs
- **scratch-vm**: https://github.com/smalruby/scratch-vm
- **smalruby3-gui**: https://github.com/smalruby/smalruby3-gui

### Incorrect Repository URLs (DO NOT USE)
- ❌ https://github.com/scratchfoundation/scratch-vm
- ❌ https://github.com/scratchfoundation/scratch-gui

### Command Examples
```bash
# Correct - Create issue in Smalruby repository
gh issue create --repo smalruby/scratch-vm --title "Issue title" --body "Issue body"

# Correct - Create PR in Smalruby repository
gh pr create --repo smalruby/scratch-vm --title "PR title" --body "PR body"

# Incorrect - Avoid operations on Scratch Foundation repositories
gh issue create --repo scratchfoundation/scratch-vm  # DON'T DO THIS
```

When working with submodules (gui/scratch-vm and gui/smalruby3-gui), always ensure GitHub operations target the corresponding Smalruby fork, not the upstream Scratch Foundation repository.

## Git Branching Strategy

**IMPORTANT**: Both `gui/smalruby3-gui` and `gui/scratch-vm` use `develop` as their default branch instead of `main`.

### Branch Creation Rules
When making commits or creating pull requests:

1. **Always check current branch first**: Use `git branch` to verify your current branch
2. **Never commit directly to develop**: If you're on the `develop` branch, create a feature branch first
3. **Feature branch naming**: Use descriptive names like `fix/issue-description` or `feature/new-functionality`

### Recommended Workflow
```bash
# Check current branch
git branch

# If on develop, create a feature branch
git checkout -b fix/your-issue-description

# Make your changes and commit
git add .
git commit -m "your commit message"

# Push feature branch
git push origin fix/your-issue-description

# Create PR targeting develop branch
gh pr create --repo smalruby/smalruby3-gui --base develop --head fix/your-issue-description
```

### Why This Matters
- The `develop` branch may have repository rules that prevent direct pushes
- Feature branches allow for proper code review and CI/CD processes
- This follows standard Git Flow practices for development workflows

## Application Code Modification Workflow

When modifying application code, follow this systematic workflow to ensure quality and reliability:

### 1. Implement Automated Tests First (TDD Approach)
- **For GUI (smalruby3-gui)**: Create integration tests in `test/integration/`
- **For VM (scratch-vm)**: Create unit tests in appropriate test directories
- If test data preparation is complex or requires significant setup, delegate to the user
- Ensure tests fail initially (RED) to validate they're testing the right functionality
- For refactoring: tests should remain GREEN throughout

### 2. Implement Application Code
- Modify application code to meet requirements
- Follow existing code patterns and conventions
- Iterate until all automated tests pass (GREEN)

### 3. Code Quality Checks
```bash
# Run lint checks
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:lint"
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run lint"

# Fix any lint errors before proceeding
```

### 4. Final Test Execution
```bash
# GUI: Build and run integration tests
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run build && npm run test:integration"

# VM: Run unit tests
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm test"
```

**IMPORTANT: Test Implementation Rule**
When implementing tests, you MUST ensure both tests and lint pass before committing and pushing:
1. Build the application if required for integration tests
2. Run the specific test to verify it passes
3. Run lint checks to ensure code quality
4. Only after confirming all tests pass and lint is clean, proceed with commit and push

### 5. Version Control and Pull Request
```bash
# Create feature branch (if not already created)
git checkout -b feature/descriptive-name

# Commit changes with descriptive message
git add .
git commit -m "feat: descriptive commit message

Details about the implementation, including:
- What functionality was added/changed
- How it works
- Any important implementation details

Fixes #issue-number

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to remote
git push origin feature/descriptive-name

# Create pull request with detailed description
gh pr create --repo smalruby/smalruby3-gui --base develop --head feature/descriptive-name --title "Title" --body "Detailed description including implementation details, test coverage, and usage examples"
```

### 6. Pull Request Description Guidelines
Include in the PR description:
- **Summary**: Brief overview of changes
- **Implementation details**: How the feature works
- **Test coverage**: What tests were added/modified
- **Usage examples**: Code snippets or URL examples
- **Breaking changes**: If any (with migration guide)

## Dependencies

- Node.js for JavaScript components
- Docker for containerized development
- Ruby 2.5.3+ for Ruby library
- Chrome/Chromium for integration testing
