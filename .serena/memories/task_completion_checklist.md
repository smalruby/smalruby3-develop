# Task Completion Checklist

## When a Development Task is Complete

### For GUI Changes (smalruby3-gui)
1. **Lint Check**: Run `npm run test:lint` to ensure code style compliance
2. **Unit Tests**: Run `npm run test:unit` to verify functionality
3. **Integration Tests**: Run `npm run test:integration` for end-to-end testing
4. **Build Verification**: Run `npm run build` to ensure production build works
5. **Full Test Suite**: Run `npm test` (combines all above)
6. **Manual Testing**: Start development server with `npm start` and test in browser

### For VM Changes (scratch-vm)
1. **Lint Check**: Run `npm run lint` (ESLint + format-message)
2. **Unit Tests**: Run `npm run tap:unit` for focused unit testing
3. **Integration Tests**: Run `npm run tap:integration` for integration testing
4. **Full Test Suite**: Run `npm test` (lint + all TAP tests)
5. **Build Verification**: Run `npm run build` to create distribution files
6. **Documentation**: Run `npm run docs` if public API changed
7. **Coverage Check**: Run `npm run coverage` to verify test coverage

### For Ruby Library Changes (smalruby3)
1. **Style Check**: Run `rake rubocop` to verify Ruby style compliance
2. **Tests**: Run `rake test` or `rake spec` to run test suite
3. **Default Task**: Run `rake` (combines rubocop + tests)
4. **Bundle Check**: Ensure `bundle install` works without issues

### Docker Environment
1. **Container Build**: Run `docker compose build gui` if Dockerfile changed
2. **Service Start**: Verify `docker compose up gui` works without errors
3. **Port Access**: Confirm http://localhost:8601 is accessible
4. **Clean Restart**: Test `docker compose stop gui` and restart

### Git and Submodules
1. **Submodule Status**: Check `git submodule status` for consistency
2. **Git Status**: Verify `git status` shows expected changes
3. **Submodule Updates**: If submodules changed, update parent repository
4. **Merge Conflicts**: Resolve any merge conflict markers (especially in package.json)

### Cross-Component Integration
1. **Opal Setup**: Run `npm run setup-opal` if Ruby integration changed
2. **VM Setup**: Run `npm run setup-scratch-vm` if VM dependencies changed
3. **End-to-End Testing**: Test complete workflow from blocks to execution

### Performance and Quality
1. **Build Size**: Check webpack bundle analyzer if significant changes
2. **Memory Usage**: Monitor for memory leaks in long-running tests
3. **Loading Time**: Verify application startup time remains reasonable

### Documentation
1. **Code Comments**: Ensure complex logic is documented
2. **API Changes**: Update documentation for public API modifications
3. **README**: Update if setup or usage instructions changed

## Before Committing
1. All relevant tests pass
2. Code style checks pass
3. Build process completes successfully
4. Manual testing confirms expected behavior
5. No TODO comments or debugging code left in
6. Commit message follows conventional commit format