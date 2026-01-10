---
paths:
  - "gui/scratch-vm/src/**/*.js"
  - "gui/scratch-vm/package.json"
---

# scratch-vm 開発ワークフロー

**Important**: All npm commands for VM development must be run inside Docker containers.

## 開発コマンド

### 依存関係のインストール
```bash
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm install"
```

### 開発サーバー起動
```bash
# Development server with playground (port 8073)
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm start"
```

### スタンドアロンビルド
```bash
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run build"
```

### ドキュメント生成
```bash
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run docs"
```

## Application Code Modification Workflow

When modifying application code, follow this systematic workflow to ensure quality and reliability:

### 1. Implement Automated Tests First (TDD Approach)
- Create unit tests in appropriate test directories
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
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run lint"

# Fix any lint errors before proceeding
```

### 4. Final Test Execution
```bash
# Run all tests
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm test"
```

**IMPORTANT: Test Implementation Rule**
When implementing tests, you MUST ensure both tests and lint pass before committing and pushing:
1. Run the specific test to verify it passes
2. Run lint checks to ensure code quality
3. Only after confirming all tests pass and lint is clean, proceed with commit and push

### 5. Version Control and Pull Request
```bash
# Create feature branch (if not already created)
cd gui/scratch-vm
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
gh pr create --repo smalruby/scratch-vm --base develop --head feature/descriptive-name --title "Title" --body "Detailed description including implementation details, test coverage, and usage examples"
```

### 6. Pull Request Description Guidelines
Include in the PR description:
- **Summary**: Brief overview of changes
- **Implementation details**: How the feature works
- **Test coverage**: What tests were added/modified
- **Usage examples**: Code snippets or usage patterns
- **Breaking changes**: If any (with migration guide)

## Key Directories

- `src/`: VM source code including extensions
  - `engine/`: Core execution engine
  - `blocks/`: Block implementations
  - `extensions/`: Extension implementations
- `playground/`: Development playground interface
- `test/`: Test files
  - `unit/`: Unit tests
  - `integration/`: Integration tests

## Cross-Repository Impact

When making changes to scratch-vm, consider the impact on smalruby3-gui:
1. Complete and merge scratch-vm changes first
2. Update smalruby3-gui dependency to latest commit
3. Test compatibility with smalruby3-gui
4. Create PR for smalruby3-gui if needed

See `.claude/CLAUDE.md` for detailed cross-repository development workflow.
