# CLAUDE.md

This file provides guidance to Claude Code when working in your projects.

## Repository Context

This is the Claude Code configuration directory (`~/.claude`). This directory contains:

- `settings.json`: Custom commands, hooks, and agent preferences
- Session data and project-specific configurations
- User-specific customizations and workflow automations

## Custom Commands

- `work`: **Collaborative pair programming** for GitHub issues/PRs with interactive decision making
- `plan`: Create implementation plans with architectural discussions and user input
- `implement`: Execute tasks with pattern discussions and naming decisions
- `review`: Interactive code review with collaborative feedback and learning
- `document`: Capture patterns and architectural decisions together
- `continue`: Resume work from current state with context and user direction
- `milestone`: Break down GitHub milestones into actionable issues with dependency planning

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

### Pair Programming Approach

Claude Code now operates as a collaborative pair programming partner with frequent interaction and decision points:

**Core Philosophy:**
- **Interactive Development**: Ask for input on patterns, naming, and architectural decisions
- **Collaborative Planning**: Present options and get user preference before proceeding
- **Incremental Progress**: Work in small, reviewable chunks with regular check-ins
- **Pattern Learning**: Discover and discuss patterns together as they emerge

**Workflow Commands:**

**`/work [issue/PR]`** - Collaborative issue implementation:
- Analyze requirements together
- Present architectural options for user choice
- Implement with frequent decision points
- Ask about naming conventions and patterns

**`/plan [feature/issue]`** - Interactive planning:
- Understand requirements collaboratively
- Discuss technology and architecture choices
- Create action plans with user input
- Define success criteria together

**`/implement [task]`** - Pair programming execution:
- Present approach options before coding
- Discuss patterns as they emerge
- Get input on naming and structure
- Show changes before committing

**`/review [code/PR]`** - Collaborative code review:
- Discuss findings and suggestions
- Present improvement options
- Learn from user's architectural reasoning
- Document decisions and patterns

**`/document [work]`** - Capture learnings together:
- Identify patterns worth documenting
- Discuss architectural decisions made
- Create knowledge for future reference
- Update project documentation

**`/continue`** - Resume from current state:
- Understand current progress together
- Present options for next steps
- Maintain established patterns
- Continue collaborative approach

**`/milestone [name]`** - Break down milestones:
- Analyze milestone scope collaboratively
- Create logical issue breakdown with dependencies
- Plan for incremental value delivery
- Sequence work to minimize blocking

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

## Interactive Features

### Hooks for Pair Programming
- **pre-task**: Ask about approach before starting tasks
- **pattern-detected**: Confirm pattern usage when code patterns emerge
- **naming-decision**: Get input on naming for new components
- **architecture-choice**: Present options for architectural decisions
- **implementation-checkpoint**: Regular progress check-ins every 2 tasks

### Output Styles for Clear Communication
- **pair-programming**: Interactive format for all collaborative work
- **pattern-discussion**: Format for exploring code patterns together
- **decision-point**: Structure for presenting architectural choices
- **implementation-plan**: Format for collaborative planning sessions

### Workflow Settings
- **pair_programming_mode**: Always on for interactive development
- **decision_frequency**: High frequency of decision points
- **pattern_confirmation**: Always confirm patterns before applying
- **checkpoint_interval**: Ask for input every 2 tasks
- **explain_reasoning**: Always explain options and trade-offs