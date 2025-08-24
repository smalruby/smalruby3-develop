# Smalruby 3 Development Environment - Project Overview

## Purpose
Smalruby 3 is a Ruby-based visual programming environment for educational purposes, forked from MIT's Scratch 3.0. It allows users to create 2D games and interactive programs using both visual block programming and Ruby code.

## Architecture
The project uses a Docker-based development environment with three main components:

### 1. GUI (smalruby3-gui)
- **Location**: `gui/smalruby3-gui/` (git submodule)
- **Purpose**: React-based web interface forked from scratch-gui
- **Technology**: React, Redux, JavaScript ES6, Webpack
- **Features**:
  - Visual block programming interface
  - Code editor using ace-builds
  - Ruby integration through Opal transpilation
  - Custom blocks and extensions for Ruby programming
- **Port**: 8601

### 2. Virtual Machine (scratch-vm)
- **Location**: `gui/scratch-vm/` (git submodule)
- **Purpose**: JavaScript virtual machine for executing programs
- **Technology**: JavaScript, TAP testing framework
- **Features**:
  - Program execution engine
  - Extensions and block definitions
  - Integration with GUI components
- **Port**: 8073 (playground mode)

### 3. Ruby Library (smalruby3)
- **Location**: `lib/smalruby3/`
- **Purpose**: 2D game development library for Ruby
- **Technology**: Ruby 2.5.3+, DXRuby SDL
- **Features**:
  - Sprite and stage management
  - Game development utilities
  - Ruby-to-JavaScript transpilation support
- **Port**: 15900 (VNC access)

## Docker Services
- `gui`: Frontend development server with hot reloading
- `lib`: Ruby library development environment with VNC access

## Key Integration Points
- **Opal**: Ruby-to-JavaScript transpiler enabling Ruby code execution in browser
- **Git Submodules**: GUI components are managed as separate repositories
- **Custom Extensions**: Ruby-specific blocks and functionality added to Scratch base

## Development Workflow
The project follows a containerized development approach where:
1. Docker containers provide consistent development environments
2. Hot reloading enables rapid development iteration
3. Git submodules allow independent development of GUI components
4. Ruby and JavaScript codebases are integrated through Opal transpilation