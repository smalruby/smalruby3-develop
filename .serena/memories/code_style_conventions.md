# Code Style and Conventions

## JavaScript/React (GUI & VM)
### ESLint Configuration
- **Config**: Extends `scratch`, `scratch/node`, `scratch/es6` configurations
- **Standards**: ES6+, React best practices, Node.js patterns
- **Enforcement**: Automatic linting on test runs and development

### Code Conventions
- **React Components**: Functional and class components with PropTypes
- **State Management**: Redux patterns with immutable state
- **File Extensions**: `.js` for JavaScript, `.jsx` for React components
- **Imports**: ES6 module imports/exports
- **Testing**: Jest for unit tests, integration tests with headless Chrome

### Formatting
- **Line Length**: Standard JavaScript conventions
- **Semicolons**: Required
- **Quotes**: Consistent quote usage
- **Indentation**: Standard JavaScript indentation

## Ruby (Library)
### RuboCop Configuration
- **Config File**: `.rubocop.yml` with custom rules
- **Line Length**: Max 120 characters
- **Method Length**: Max 50 lines
- **Class Length**: Max 250 lines
- **Complexity**: Max 10 for cyclomatic and perceived complexity

### Style Preferences (Disabled Rules)
- **Documentation**: Style/Documentation disabled
- **String Literals**: Style/StringLiterals disabled (flexible quote usage)
- **Frozen String Literals**: Not enforced
- **Guard Clauses**: Style/GuardClause disabled
- **Block Delimiters**: Style/BlockDelimiters disabled (flexible `{}` vs `do..end`)
- **Trailing Commas**: Not enforced in arrays/hashes

### Enabled Conventions
- **Dot Position**: Trailing dots for method chaining
- **Symbol Arrays**: EnforcedStyle: brackets (`[:a, :b]`)
- **ASCII Comments**: Disabled (allows Japanese comments)
- **Numeric Literals**: Disabled (flexible number formatting)

### Special Considerations
- **Examples Directory**: Relaxed alignment and global variable rules
- **Spec Files**: Relaxed global variable rules
- **Gemspec**: Multiple style exceptions for formatting

## Testing Conventions
### JavaScript
- **Framework**: Jest with enzyme for React testing
- **Coverage**: Integration with coverage reporting
- **File Patterns**: `test/unit/*.js`, `test/integration/*.js`
- **Mocking**: Mock files for assets and modules

### Ruby
- **Framework**: RSpec (implied from gemspec dependencies)
- **Default Task**: Includes both RuboCop and tests
- **File Patterns**: `spec/**/*_spec.rb`

## File Organization
### JavaScript Projects
- **src/**: Source code
- **test/**: Test files with subdirectories (unit, integration)
- **dist/**: Built output
- **build/**: Production build output

### Ruby Projects
- **lib/**: Library source code
- **spec/**: Test specifications
- **examples/**: Example code with relaxed style rules

## Commit and Release
- **Conventional Commits**: Uses commitizen with conventional changelog
- **Semantic Release**: Automated versioning and releases
- **Git Hooks**: Husky for pre-commit checks