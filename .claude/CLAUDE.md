# CLAUDE.md

This file provides guidance to Claude Code when working in your projects.

## Repository Context

This is the Claude Code configuration directory (`~/.claude`). This directory contains:

- `settings.json`: Custom commands, hooks, and agent preferences
- Session data and project-specific configurations
- User-specific customizations and workflow automations

## Custom Commands

- `github-milestone`: Analyze GitHub milestones and break them into incremental issues
- `github-issue`: **Intelligent orchestrator** that automatically routes GitHub issue implementation through complete workflow - from planning to execution to documentation. Features automatic agent handoffs, workflow phase management, and seamless transitions between github-issue-planner → implementation-executor → pattern-documenter
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

### GitHub Issue Orchestration Workflow

The `github-issue` command provides intelligent orchestration through complete development lifecycle:

**Phase 1: Planning** 
- Auto-detects existing PR/branch state for the issue
- Routes to `github-issue-planner` for comprehensive analysis
- Creates detailed action plan with acceptance criteria
- Generates PR with structured checklist after user approval

**Phase 2: Implementation**
- Automatic handoff to `implementation-executor` agent
- Executes tasks with focused, atomic commits
- Routes to specialized agents as needed:
  - `postgres-ecto-architect` for database work
  - `liveview-frontend-expert` for UI components
  - `elixir-phoenix-dev` for general Elixir code
- Continuous progress tracking via PR checklist updates

**Phase 3: Documentation**
- Routes to `pattern-documenter` for milestone completion
- Captures implementation learnings and patterns
- Updates related issues with context and insights
- Final quality review with `elixir-code-reviewer`

**Workflow States:**
- **Fresh Issue**: `github-issue` → `github-issue-planner` → `implementation-executor`
- **Existing PR**: `github-issue` → `implementation-executor` (resumes from current state)
- **Complete Work**: `github-issue` → `pattern-documenter` → final review

**Usage:**
```bash
github-issue #123        # Start or continue issue #123
/continue               # Resume current PR work  
github-review PR#45     # Comprehensive PR review
```

## Dotfiles Management Notes

**⚠️ Special Workflow for Configuration Files:**

When working on dotfiles or Claude Code configuration changes:
1. **DO** work on files within this repository (e.g., `/Users/guitsaru/code/dotfiles/.claude/settings.json`)
2. **DO NOT** work directly on deployed files in their live locations (e.g., `~/.claude/settings.json`)
3. **DO** use standard `git add`, `git commit`, `git push` commands within this repository
4. **DO** use `dotfiles pull` after pushing to deploy changes to the live system

**Example Workflow:**
```bash
# Edit configuration files within the repository
nvim /Users/guitsaru/code/dotfiles/.claude/settings.json

# Stage and commit using standard Git commands
git add .claude/settings.json
git commit -m "Update Claude Code configuration"
git push

# Deploy changes to live system
dotfiles pull
```

**Reasoning:** Work on the source files in the repository, then deploy them to the live system. This maintains proper version control and prevents conflicts between the repository state and deployed configuration.

## Agent Preferences

- **elixir-phoenix-dev**: Auto-selected for .ex/.exs/.heex files
- **liveview-frontend-expert**: Auto-selected for LiveView templates
- **postgres-ecto-architect**: Auto-selected for database files
- **elixir-code-reviewer**: Manual trigger for PR reviews