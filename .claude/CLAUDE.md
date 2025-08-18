# CLAUDE.md

This file provides guidance to Claude Code when working in your projects.

## Repository Context

This is the Claude Code configuration directory (`~/.claude`). This directory contains:

- `settings.json`: Custom commands, hooks, and agent preferences
- Session data and project-specific configurations
- User-specific customizations and workflow automations

## Custom Commands

- `github-milestone`: Analyze GitHub milestones and break them into incremental issues
- `github-issue`: Implement GitHub issues with atomic commits and quality checks
- `github-review`: Provide comprehensive PR reviews with expert feedback

## Tech Stack Patterns

### Elixir/Phoenix Projects

**Common Commands:**
```bash
mix deps.get          # Install dependencies
mix compile           # Build project
mix test              # Run tests
mix format            # Format code
mix credo --strict    # Static analysis
mix ecto.migrate      # Run migrations
mix phx.server        # Start server
```

**Architecture Patterns:**
- **Contexts**: Business logic grouped in bounded contexts (Accounts, Blog, etc.)
- **Schemas**: Ecto schemas with embedded validation and relationships
- **LiveView**: Real-time UI with server-rendered components
- **GenServers**: Stateful processes for background tasks and caching
- **Phoenix Channels**: WebSocket connections for real-time features
- **Multi-tenant**: Organization-scoped data access patterns

**Quality Standards:**
- 80%+ test coverage with ExUnit
- Credo compliance (strict mode)
- Formatted code with `mix format`
- Proper documentation with @doc and @spec
- Database indexes for query performance

### Swift/SwiftUI Projects

**Common Commands:**
```bash
swift build           # Build project
swift test            # Run tests  
swift package init    # Initialize package
swift-format --in-place  # Format code
swiftlint             # Static analysis
xcodebuild            # Xcode build (iOS/macOS)
```

**Architecture Patterns:**
- **MVVM**: Model-View-ViewModel with ObservableObject
- **SwiftUI Views**: Declarative UI with state management
- **Combine**: Reactive programming for data flow
- **Core Data**: Local persistence with CloudKit sync
- **Async/Await**: Modern concurrency patterns
- **Package Manager**: SPM for dependency management

**Quality Standards:**
- Unit tests with XCTest
- SwiftLint compliance
- Proper error handling with Result types
- Memory management with ARC
- Accessibility support

## Development Workflow

1. **Planning**: Use `github-milestone` to break down features
2. **Implementation**: Use `github-issue` for atomic development
3. **Review**: Use `github-review` for quality assurance
4. **Quality**: Automated hooks ensure code standards

## Agent Preferences

- **elixir-phoenix-dev**: Auto-selected for .ex/.exs/.heex files
- **liveview-frontend-expert**: Auto-selected for LiveView templates
- **postgres-ecto-architect**: Auto-selected for database files
- **elixir-code-reviewer**: Manual trigger for PR reviews