# Project Structure

## Root Directory
```
smalruby3-develop/
├── config/              # Environment configuration files
├── gui/                 # Frontend components (git submodules)
│   ├── smalruby3-gui/   # Main React application
│   └── scratch-vm/      # Virtual machine for program execution
├── lib/                 # Ruby libraries
│   ├── dxruby_sdl/      # DXRuby SDL wrapper
│   └── smalruby3/       # Main Ruby library
├── .github/             # GitHub workflows and templates  
├── .vscode/             # VS Code configuration
├── docker-compose.yml   # Docker services definition
├── CLAUDE.md           # AI assistant instructions
└── README.md           # Project documentation
```

## GUI Structure (`gui/smalruby3-gui/`)
```
smalruby3-gui/
├── src/                 # Source code
│   ├── components/      # React components
│   ├── containers/      # Redux containers
│   ├── lib/             # Utility libraries
│   │   └── ruby-to-blocks-converter/  # Ruby code conversion
│   ├── locales/         # Internationalization
│   └── examples/        # Example extensions
├── test/                # Test files
│   ├── unit/            # Unit tests
│   └── integration/     # Integration tests
├── opal/                # Opal (Ruby-to-JS) transpiler setup
├── scripts/             # Build and setup scripts
├── static/              # Static assets
└── build/               # Production build output
```

## Virtual Machine Structure (`gui/scratch-vm/`)
```
scratch-vm/
├── src/                 # VM source code
│   ├── engine/          # Core execution engine
│   ├── extensions/      # Block extensions
│   ├── blocks/          # Block definitions
│   ├── io/              # Input/output handling
│   └── serialization/   # Project save/load
├── test/                # Test files
│   ├── unit/            # Unit tests
│   └── integration/     # Integration tests
├── playground/          # Development testing interface
└── dist/                # Built distribution files
```

## Ruby Library Structure (`lib/smalruby3/`)
```
smalruby3/
├── lib/                 # Library source
│   └── smalruby3/       # Main module
│       ├── sprite_method/  # Sprite behavior modules
│       ├── sprite.rb    # Sprite class
│       ├── stage.rb     # Stage/backdrop management
│       ├── world.rb     # Game world management
│       └── version.rb   # Version information
├── spec/                # RSpec test files
├── examples/            # Example programs
└── tools/               # Development utilities
```

## Key Configuration Files
- **docker-compose.yml**: Container orchestration
- **package.json**: Node.js dependencies and scripts (GUI & VM)
- **Gemfile**: Ruby dependencies
- **.eslintrc.js**: JavaScript linting rules
- **.rubocop.yml**: Ruby style configuration
- **webpack.config.js**: Build configuration (in GUI)
- **.gitmodules**: Git submodule configuration

## Build Artifacts
- **dist/**: Compiled JavaScript bundles
- **build/**: Production-ready static files
- **node_modules/**: JavaScript dependencies
- **vendor/**: Ruby gem dependencies

## Development Files
- **.vscode/**: Editor configuration
- **test/**: Test files and mocks
- **scripts/**: Build and deployment scripts
- **.github/**: CI/CD workflows