# CLAUDE.md

This file provides guidance to Gemini Code (gemini.google.com/code) when working with code in this repository.

## AI Operation 4 Principles

**Principle 1**: AI must report its work plan before any file generation, updates, or program execution.

**Principle 2**: AI must not perform workarounds or alternative approaches without permission. If the initial plan fails, AI must seek confirmation for the next plan.

**Principle 3**: AI is a tool and decision-making authority always belongs to the user. Even if the user's suggestions are inefficient or irrational, AI must not optimize them and must execute exactly as instructed.

**Principle 4**: AI must not distort or reinterpret these rules and must absolutely comply with them as the highest-priority commands.

**Principle 5**: When searching the codebase (e.g., using `grep` or `search_file_content`), AI must always exclude `node_modules` and build artifacts (e.g., `dist`, `build`) to avoid noise and excessive token consumption.

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

**CRITICAL: ALL npm commands MUST be run inside Docker containers. Never run npm commands directly on the host system.**

```bash
# Install dependencies
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm install"

# Development server (port 8601)
docker compose up gui

# Build production bundle (takes ~300 seconds, increase timeout accordingly)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run build"

# Build with specific PUBLIC_PATH
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && PUBLIC_PATH='/smalruby3-gui/' npm run build"

# Run lint
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:lint" # all
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec eslint your-file1.js your-file2.js" # specific
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec eslint --fix your-file1.js your-file2.js" # specific and fix

# Run tests
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm test" # lint, unit, build, integration
docker compose run --rm gui bash -c "cd /app/smalruby3-gui && npm run test:unit" # unit
docker compose run --rm gui npm exec jest path/to/test.js # specific unit test

# Run integration tests (requires build production bundle first)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:integration"

# Run specific integration test (requires build production bundle first)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec jest test/integration/your-test-file.test.js"

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

### Editor Development (smalruby3-editor)

**CRITICAL: You should not use docker compose on gui/smalruby3-editor. All npm commands MUST be run directly on the host system.**

```bash
# Install dependencies for the monorepo
cd gui/smalruby3-editor && npm install

# Build all packages in the monorepo
cd gui/smalruby3-editor && npm run build

# Run all tests in the monorepo
cd gui/smalruby3-editor && npm test

# Run tests for a specific package (e.g., scratch-vm)
cd gui/smalruby3-editor/packages/scratch-vm && npm test

# Run specific tap tests in scratch-vm
cd gui/smalruby3-editor/packages/scratch-vm && npm run tap:unit
cd gui/smalruby3-editor/packages/scratch-vm && npm run tap:integration

# Run lint for a specific package (e.g., scratch-vm)
cd gui/smalruby3-editor/packages/scratch-vm && npm run lint

# Integration tests for scratch-gui
# IMPORTANT: You MUST run build:dev before integration tests if application code has changed.
# build:dev is faster than build and sufficient for testing.
cd gui/smalruby3-editor/packages/scratch-gui && npm run build:dev
cd gui/smalruby3-editor/packages/scratch-gui && npm run test:integration
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

- **GUI (smalruby3-gui)**: Jest for unit tests, integration tests with headless Chrome
- **VM (scratch-vm and editor monorepo packages)**: TAP testing framework with coverage reporting
- **Ruby**: Standard Ruby testing with Rake

## Merge Conflicts

Note: The smalruby3-gui package.json contains merge conflict markers from upstream scratch-gui integration. These should be resolved before making changes to the GUI component.

## GitHub Operations

**IMPORTANT**: All GitHub operations (issues, pull requests, comments, etc.) must be performed against the Smalruby organization repositories, NOT the upstream Scratch Foundation repositories. Always use the `gh` command for GitHub access.

**IMPORTANT: Message Escaping Rule**: When using the `gh` command to create issues or pull requests, always store the commit message or PR description in a temporary file first, and then use the `-F` (or `--body-file`) and `-F` (or `--title-file`) flags. Do not pass long or complex messages directly as command-line arguments to avoid shell escaping issues.

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
# or for Editor monorepo (run on host)
cd gui/smalruby3-editor/packages/scratch-vm && npm test
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

Co-Authored-By: Gemini <noreply@google.com>"

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

## GitHub Pages publicPath Local Testing

When testing GitHub Pages subdirectory deployments locally (e.g., for `/smalruby3-gui/` path), use the following workflow:

### 1. Build with PUBLIC_PATH
```bash
# Build with GitHub Pages subdirectory path (worker paths are automatically fixed)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && PUBLIC_PATH=/smalruby3-gui/ npm run build"
```

**Note**: The build process now includes an automated post-build script (`scripts/postbuild.mjs`) that detects the `PUBLIC_PATH` environment variable and automatically fixes fetch-worker paths. No manual `sed`/`gsed` commands are needed.

### 2. Setup Test Environment
```bash
# Create test directory structure
mkdir -p /private/tmp/github-pages-test/smalruby3-gui

# Copy build output to test structure
cp -R build/* /private/tmp/github-pages-test/smalruby3-gui/

# Start Python HTTP server
cd /private/tmp/github-pages-test
python3 -m http.server 8080
```

### 3. Test URLs
- **Main page**: `http://localhost:8080/smalruby3-gui/`
- **Japanese page**: `http://localhost:8080/smalruby3-gui/ja.html`
- **Player page**: `http://localhost:8080/smalruby3-gui/player.html`

### 4. Verify Functionality
1. Open browser developer tools (F12) → Network tab
2. Click sprite selection button (cat icon in bottom right)
3. Confirm `fetch-worker.xxxxx.js` loads from `/smalruby3-gui/chunks/` path
4. Verify no 404 errors for worker files
5. Test sprite library loads correctly

This workflow replicates the GitHub Pages deployment environment for local testing and debugging.

## Cross-Repository Development Workflow

When modifying scratch-vm that affects smalruby3-gui, follow this workflow to ensure proper integration:

### Overview
The smalruby3-gui depends on scratch-vm as a git submodule. When scratch-vm is updated, smalruby3-gui must be updated to reference the new commit ID.

**Note on local development**: In this environment, `npm link scratch-vm` is used within the Docker container. This means that local changes made to `gui/scratch-vm` are immediately reflected in `gui/smalruby3-gui` without needing to run `npm update scratch-vm` or commit `package-lock.json` changes for development purposes. You only need to update the submodule reference and `package-lock.json` when preparing for a final PR integration.

```bash
docker compose run --rm gui bash -c "npm update scratch-vm && npm link scratch-vm"
```

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

🤖 Generated with [Gemini Code](https://gemini.google.com/code)

Co-Authored-By: Gemini <noreply@google.com>"

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

## Repository Management Rules

**CRITICAL: Do not perform any git operations on the `smalruby3-develop` repository unless explicitly instructed by the user.**
This includes, but is not limited to:
- Creating branches
- Making commits
- Pushing to remote
- Creating Pull Requests (PRs)

These operations are strictly prohibited for the `smalruby3-develop` repository. Always perform these operations in the respective component repositories (e.g., `gui/scratch-vm`, `gui/smalruby3-gui`, `infra/mesh-v2`) as instructed in their specific workflows.

## Dependencies

- Node.js for JavaScript components
- Docker for containerized development
- Ruby 2.5.3+ for Ruby library
- Chrome/Chromium for integration testing
- Node.js for automated post-build processing
