---
paths:
  - "gui/smalruby3-gui/src/**/*.{js,jsx}"
  - "gui/smalruby3-gui/scripts/**/*.js"
  - "gui/smalruby3-gui/package.json"
  - "gui/smalruby3-gui/webpack.config.js"
---

# smalruby3-gui 開発ワークフロー

**CRITICAL: ALL npm commands MUST be run inside Docker containers. Never run npm commands directly on the host system.**

## 開発コマンド

### 依存関係のインストール
```bash
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm install"
```

### 開発サーバー起動
```bash
# Development server (port 8601)
docker compose up gui
```

### プロダクションビルド
```bash
# Build production bundle (takes ~300 seconds, increase timeout accordingly)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run build"

# Build with specific PUBLIC_PATH
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && PUBLIC_PATH='/smalruby3-gui/' npm run build"
```

### Setup コマンド
```bash
# Setup Opal (Ruby-to-JavaScript transpiler)
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run setup-opal"

# Setup scratch-vm dependency
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run setup-scratch-vm"
```

## Application Code Modification Workflow

When modifying application code, follow this systematic workflow to ensure quality and reliability:

### 1. Implement Automated Tests First (TDD Approach)
- Create integration tests in `test/integration/`
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

# Fix any lint errors before proceeding
```

### 4. Final Test Execution
```bash
# Build and run integration tests
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run build && npm run test:integration"
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
cd gui/smalruby3-gui
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

## Key Directories

- `src/`: React components and application source code
- `scripts/`: Build and setup scripts
- `test/integration/`: Integration test files
- `opal/`: Opal transpiler configuration and build files
