# Suggested Development Commands

## Docker Environment Commands
```bash
# Build GUI service
docker compose build gui

# Start GUI development server (http://localhost:8601)
docker compose up gui

# Start with debug configuration
docker compose --env-file ./config/.env.debug up gui

# Stop GUI service
docker compose stop gui

# Access GUI container shell
docker compose run --rm gui bash

# Start Ruby library service (VNC on port 15900)
docker compose up lib
```

## GUI Development (smalruby3-gui)
```bash
cd gui/smalruby3-gui

# Install dependencies
npm install

# Development server (alternative to docker)
npm start

# Build production bundle
npm run build

# Clean build artifacts
npm run clean

# Setup Opal (Ruby-to-JavaScript transpiler)
npm run setup-opal

# Setup scratch-vm dependency
npm run setup-scratch-vm

# Testing
npm test              # Run all tests (lint + unit + build + integration)
npm run test:unit     # Unit tests only
npm run test:integration  # Integration tests only
npm run test:lint     # ESLint only

# Deployment
npm run deploy
npm run deploy:smalruby.app
```

## Virtual Machine Development (scratch-vm)
```bash
cd gui/scratch-vm

# Install dependencies
npm install

# Development server with playground (http://localhost:8073)
npm start

# Build standalone
npm run build

# Testing
npm test              # Run all tests (lint + tap)
npm run tap           # All TAP tests
npm run tap:unit      # Unit tests only
npm run tap:integration  # Integration tests only
npm run lint          # ESLint + format-message lint

# Generate documentation
npm run docs

# Coverage reporting
npm run coverage
```

## Ruby Library Development (smalruby3)
```bash
cd lib/smalruby3

# Install Ruby dependencies
bundle install

# Run Ruby tests
rake test

# Run RuboCop (style checking)
rake rubocop

# Default task (rubocop + tests)
rake
```

## System Utilities (macOS Darwin)
```bash
# File operations
ls -la                # List files with details
find . -name "*.js"   # Find JavaScript files
grep -r "pattern" .   # Search for patterns

# Git operations
git status            # Check repository status
git submodule update --init --recursive  # Update submodules
git log --oneline     # View commit history

# Process management
ps aux | grep node    # Find Node.js processes
lsof -ti:8601         # Find process using port 8601
kill -9 <pid>         # Kill process by ID
```