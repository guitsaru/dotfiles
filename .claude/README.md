# Claude Code Configuration

A comprehensive multi-agent orchestration system for Claude Code with **16 specialized agents** supporting **Elixir/Phoenix**, **Swift/SwiftUI**, and **Ruby/Rails** development. Features intelligent workflow routing, interactive approval gates, and complete SDLC automation.

## 🚀 Quick Start

```bash
# Full issue implementation with planning → execution → documentation
claude github-issue #127

# Create GitHub milestone from project requirements
claude create-milestone "User Authentication v2.0 - OAuth & TOTP"

# Break down existing milestone into actionable issues
claude github-milestone "User Authentication System"

# Comprehensive PR review with specialist coordination
claude github-review PR#89

# Resume work from current state (auto-detects context)
claude continue
```

## 🎯 Core Philosophy

This configuration transforms Claude Code from a simple assistant into an **intelligent workflow orchestrator** that:

- **Seeks your approval** at every major decision point
- **Routes work** to specialized agents based on file patterns and complexity
- **Maintains context** across multi-step workflows
- **Enforces quality gates** with automated testing and linting
- **Documents learnings** for future reference and team sharing

## 📋 Available Commands

### Primary Workflows

#### `claude github-issue <issue-number>`
**Complete issue implementation orchestrator**

**Flow:**
1. **Planning Phase**: Analyzes issue, asks clarification questions, creates action plan
2. **👤 USER APPROVAL**: Review plan and type `APPROVED` to continue
3. **Implementation Phase**: Executes tasks with focused commits
4. **👤 USER REVIEW**: Review each change, type `COMMIT` to proceed
5. **Documentation Phase**: Captures patterns and updates knowledge base

**Example:**
```bash
claude github-issue #127
# → Analyzes "Add rate limiting to API endpoints"
# → Asks clarifying questions about rate limits and Redis usage
# → Creates detailed action plan with 6 implementation steps
# → Waits for your approval before creating PR
# → Executes each step with commit approval checkpoints
# → Documents patterns for future rate limiting features
```

#### `claude github-milestone "<milestone-name>"`
**Intelligent milestone breakdown orchestrator**

**Flow:**
1. **Analysis Phase**: Fetches milestone, analyzes scope and complexity
2. **👤 SCOPE CONFIRMATION**: Validates understanding before breakdown
3. **Breakdown Phase**: Creates small, deliverable issues with dependencies
4. **👤 USER APPROVAL**: Review breakdown before GitHub issue creation
5. **Creation Phase**: Generates GitHub issues with proper labels and links

**Example:**
```bash
claude github-milestone "User Authentication System"
# → Analyzes milestone scope and current requirements
# → Confirms: "This involves OAuth, TOTP, and session management. Correct?"
# → Creates 8 issues: database schema, OAuth integration, TOTP setup, etc.
# → Shows dependency graph and thin-slice delivery plan
# → Creates GitHub issues only after your approval
```

#### `claude github-review <pr-number>`
**Multi-specialist PR review orchestrator**

**Flow:**
1. **Analysis Phase**: Detects PR scope (UI, database, security, etc.)
2. **Specialist Routing**: Routes to appropriate expert agents
3. **Review Synthesis**: Combines findings from multiple specialists
4. **Report Generation**: Creates actionable improvement checklist

**Example:**
```bash
claude github-review PR#89
# → Detects LiveView components + database migrations
# → Routes to liveview-frontend-expert + postgres-ecto-architect
# → Analyzes UI patterns, accessibility, and database performance
# → Synthesizes review with prioritized recommendations
```

### Workflow Shortcuts

#### `claude continue`
**Resume work from current state**

Auto-detects your current PR context and resumes implementation:
```bash
# On branch feature/user-auth with existing PR
claude continue
# → Detects PR #45, reads action plan progress
# → Resumes from "Step 4: Implement password validation"
# → Shows exactly where you left off
```

#### `claude plan <issue-number>`
**Direct access to planning phase**

Bypass orchestration for quick planning:
```bash
claude plan #127
# → Routes directly to github-issue-planner
# → Creates implementation plan without full workflow
```

#### `claude document <pr-number>`
**Direct access to documentation phase**

Document completed work patterns:
```bash
claude document PR#89
# → Routes to pattern-documenter
# → Captures implementation learnings
# → Updates related issues with insights
```

## 🤖 Specialized Agents (16 Total)

### Planning & Orchestration (4 agents)

**`github-issue-planner`** - Issue Analysis & Implementation Planning
- Converts GitHub issues into detailed implementation plans with interactive approval
- Intelligent routing to specialist agents and quality-focused acceptance criteria

**`github-milestone-creator`** - Strategic Milestone Creation  
- Creates GitHub milestones from project requirements with scope analysis
- Timeline estimation, success criteria definition, and GitHub API integration

**`milestone-breakdown-planner`** - Milestone Decomposition
- Breaks large milestones into small, deliverable issues with dependency mapping
- Risk assessment, thin-slice delivery design, and parallel work optimization

**`implementation-executor`** - Systematic Implementation
- Executes action plans with focused commits and interactive approval gates
- Multi-language specialist routing and automatic debug agent escalation

### Multi-Language Development (4 agents)

**`elixir-phoenix-dev`** - Elixir/Phoenix Development
- OTP patterns, functional programming, Phoenix conventions, multi-tenant architecture
- GenServers, Supervisors, contexts, and performance optimization

**`swift-swiftui-dev`** - iOS Application Development
- SwiftUI patterns, iOS architecture (MVVM), Core Data, CloudKit integration
- Xcode project management, Swift Package Manager, accessibility, and performance

**`ruby-rails-dev`** - Ruby/Rails Web Development  
- Rails MVC architecture, ActiveRecord optimization, modern Rails patterns
- Hotwire/Stimulus/Turbo, RSpec testing, caching strategies, background jobs

**`liveview-frontend-expert`** - LiveView UI Specialist
- Real-time UI patterns, Tailwind CSS, DaisyUI integration, component architecture
- Accessibility compliance, responsive design, performance optimization

### Infrastructure & Operations (2 agents)

**`devops-infrastructure`** - Production Operations
- Multi-platform deployment (Phoenix, Rails, Swift), container orchestration
- CI/CD pipelines, monitoring setup, database operations, security compliance

**`postgres-ecto-architect`** - Database Architecture
- Multi-tenant database design, Ecto patterns, query optimization, indexing
- Migration strategies, performance tuning, data modeling excellence

### Quality Assurance (3 agents)

**`test-architect`** - Advanced Testing Strategies
- Property-based testing (StreamData), integration testing, performance benchmarks
- Multi-language test patterns (ExUnit, XCTest, RSpec), quality metrics

**`security-audit`** - Security & Compliance
- OWASP Top 10 assessment, multi-framework vulnerability analysis
- Compliance frameworks (SOC 2, HIPAA), penetration testing automation

**`debug-agent`** - Systematic Troubleshooting
- Multi-language debugging (Elixir, Swift, Ruby), root cause analysis
- Production troubleshooting, automatic escalation integration

### Documentation & Knowledge (3 agents)

**`elixir-code-reviewer`** - Comprehensive Code Review
- Multi-dimensional analysis (architecture, security, performance)
- Best practices enforcement, actionable feedback with code examples

**`elixir-docs-architect`** - Technical Documentation
- ExDoc expertise, architecture documentation, API documentation
- Knowledge management systems, team collaboration documentation  

**`pattern-documenter`** - Implementation Learning Capture
- Multi-agent workflow documentation, pattern extraction and sharing
- Cross-issue knowledge transfer, reusable architectural decisions

## 🎮 User Interaction Controls

### Approval Keywords

**Proceed with action:**
- `APPROVED` - Approve plans and proceed with workflow
- `COMMIT` - Approve file changes and commit
- `CONTINUE` - Move to next task
- `YES` - Confirm routing or action

**Request modifications:**
- `MODIFY` - Request changes to plan or approach
- `CHANGE` - Modify specific aspects
- `ADJUST` - Fine-tune the approach
- `NO` - Reject routing or action

**Control workflow:**
- `REVIEW` - Inspect current state before deciding
- `STOP` - Pause current action
- `PAUSE` - Halt workflow
- `WAIT` - Stop and wait for input

### Interactive Checkpoints

**Planning Approval:**
```
🔍 PLANNING APPROVAL NEEDED
Please review this implementation plan and confirm:

1. Action Plan Approval: Do you approve of the proposed implementation steps?
2. Agent Routing: Are you comfortable with the suggested specialist agent routing?
3. Scope & Approach: Does the scope and technical approach align with your expectations?

Type 'APPROVED' to proceed with PR creation, or provide feedback for modifications.
```

**Implementation Checkpoint:**
```
⚡ IMPLEMENTATION CHECKPOINT
Review these changes and type 'COMMIT' to proceed or 'MODIFY' to adjust:

=== CHANGES MADE ===
lib/my_app/accounts/user.ex | 15 +++++++++++++++
test/my_app/accounts_test.exs | 8 ++++++++

Task completed. Continue to next action item, or would you like to review/modify the approach?
Options: 'CONTINUE' for next task, 'REVIEW' to inspect results, or 'MODIFY' to adjust approach
```

## ⚙️ Configuration

### Interactive Mode Settings

```json
{
  "interaction_mode": {
    "user_approval_required": true,
    "confirmation_checkpoints": [
      "planning_complete",
      "before_file_changes", 
      "before_commit",
      "task_complete",
      "specialist_routing"
    ]
  },
  "workflow_controls": {
    "auto_continue": false,
    "require_explicit_approval": true,
    "pause_on_specialist_routing": true,
    "pause_on_file_modifications": true,
    "pause_on_github_operations": true
  }
}
```

### Intelligent Agent Auto-Selection

Agents are automatically selected based on file patterns and content analysis:

**Multi-Language Routing:**
- **Elixir/Phoenix**: `*.ex, *.exs, mix.exs` → `elixir-phoenix-dev`
- **Swift/iOS**: `*.swift, *.swiftui, Package.swift, *.xcodeproj` → `swift-swiftui-dev`  
- **Ruby/Rails**: `*.rb, *.erb, *.haml, Gemfile, config/routes.rb` → `ruby-rails-dev`

**Specialized Domain Routing:**
- **LiveView/UI**: `*_live.ex, *.heex, assets/**/*.js` → `liveview-frontend-expert`
- **Database**: `**/migrations/, *_schema.ex, **/repo.ex` → `postgres-ecto-architect`
- **Testing**: `test/**/*.exs, *_test.exs, spec/**/*.rb` → `test-architect`
- **Security**: `**/auth*.ex, **/session*.ex, **/permission*.ex` → `security-audit`
- **Infrastructure**: `Dockerfile, *.tf, *.k8s.yml, .github/workflows/` → `devops-infrastructure`
- **Documentation**: `*.md, docs/, guides/` → `elixir-docs-architect`

**Intelligent Escalation:**
- **Compilation/Runtime errors** → `debug-agent`
- **Technical blockers** → `debug-agent`
- **Security-sensitive changes** → `security-audit`
- **Performance issues** → Language-specific specialist + `postgres-ecto-architect`
- **Complex architectures** → Multi-specialist routing

## 📊 Quality Gates

### Multi-Language Pre-Commit Hooks

**Elixir/Phoenix Projects:**
```bash
mix format --check-formatted && mix credo --strict && mix test
```

**Swift/iOS Projects:**
```bash
swift-format --lint --recursive . && swiftlint && swift test
```

**Ruby/Rails Projects:**
```bash
bundle exec rubocop && bundle exec rspec && bundle audit
```

**Infrastructure Projects:**
```bash
terraform fmt -check && checkov -d . && terraform plan
```

### Universal Commit Requirements
- ✅ **Format check passes** (language-specific formatter)
- ✅ **Static analysis passes** (Credo/SwiftLint/RuboCop)
- ✅ **All tests pass** (ExUnit/XCTest/RSpec)
- ✅ **Security audit clean** (deps.audit/bundle audit)
- ✅ **No compilation warnings**

### PR Requirements
- ✅ **80%+ test coverage** (language-appropriate tools)
- ✅ **Documentation updated** (ExDoc/Swift docs/YARD)
- ✅ **Patterns documented** for future reuse
- ✅ **Security review** for sensitive changes
- ✅ **Performance benchmarks** for critical paths

## 🔄 Example Workflows

### Complete Feature Implementation

**Elixir/Phoenix Example:**
```bash
# Start with issue planning
claude github-issue #127
# → "Add API rate limiting with Redis backend"
# → Asks: "What rate limits? Which endpoints? Redis cluster or single instance?"
# → You provide answers
# → Creates 6-step action plan with database, middleware, and UI changes
# → Type 'APPROVED'

# Implementation begins automatically
# → Step 1: Creates Redis configuration
# → Shows file changes, you type 'COMMIT'
# → Step 2: Implements rate limiting middleware  
# → Routes to elixir-phoenix-dev specialist
# → Shows implementation, you type 'COMMIT'
# → Step 3: Adds LiveView admin interface
# → Routes to liveview-frontend-expert
# → Shows UI components, you type 'COMMIT'

# Documentation phase
# → pattern-documenter captures rate limiting patterns
# → Updates related issues with implementation learnings
# → Creates reusable pattern documentation
```

**Swift/iOS Example:**
```bash
# iOS feature implementation
claude github-issue #89
# → "Add biometric authentication to iOS app"
# → Analyzes TouchID/FaceID requirements and iOS patterns
# → Creates plan with keychain integration and SwiftUI updates
# → Type 'APPROVED'

# Multi-specialist implementation
# → Step 1: Biometric authentication service
# → Routes to swift-swiftui-dev specialist
# → Step 2: Keychain security patterns
# → Routes to security-audit for review
# → Step 3: SwiftUI authentication views
# → Continues with swift-swiftui-dev
# → Documentation and pattern capture
```

**Ruby/Rails Example:**
```bash
# Rails API optimization
claude github-issue #156
# → "Optimize API performance - slow queries and N+1 problems"
# → Analyzes database queries and caching opportunities
# → Routes to postgres-ecto-architect for database analysis
# → Routes to ruby-rails-dev for Rails optimization
# → Creates comprehensive performance improvement plan
```

### Milestone Planning to Implementation

```bash
# Plan milestone breakdown
claude github-milestone "API v2 Migration"
# → Analyzes breaking changes, backwards compatibility needs
# → Type 'APPROVED' after scope confirmation
# → Creates 12 issues with dependency mapping
# → Issues created in GitHub with proper labels

# Implement first issue
claude github-issue #201  # First issue from milestone
# → Implementation proceeds with established patterns
# → Leverages learnings from previous similar issues
```

### Code Review and Improvement

```bash
# Comprehensive review
claude github-review PR#89
# → Multi-specialist analysis
# → Security review finds potential SQL injection
# → Performance review identifies N+1 query
# → UI review suggests accessibility improvements
# → Provides prioritized action checklist

# Implement improvements
claude continue  # On the PR branch
# → Resumes with security fixes first
# → Routes to postgres-ecto-architect for query optimization
# → Routes to liveview-frontend-expert for accessibility
```

## 🎓 Best Practices

### Planning Phase
- **Answer clarification questions thoroughly** - Better planning leads to smoother implementation
- **Review agent routing recommendations** - Specialists provide higher quality solutions
- **Modify plans when needed** - It's easier to adjust before implementation starts

### Implementation Phase
- **Review each change carefully** - Interactive checkpoints prevent mistakes
- **Let specialists handle complex work** - Trust the routing recommendations
- **Use 'REVIEW' option frequently** - Inspect progress at any point

### Documentation Phase
- **Capture learnings immediately** - Patterns are fresh in memory
- **Update related issues** - Share insights across similar work
- **Document decisions** - Future you will thank present you

## 🚨 Troubleshooting

### Command Not Working
```bash
# Check if Claude Code can find the configuration
ls ~/.claude/settings.json

# Verify command files exist
ls ~/.claude/commands/

# Test basic agent
claude -agent elixir-phoenix-dev "Hello"
```

### Interactive Mode Not Working
```bash
# Check interaction_mode settings in settings.json
cat ~/.claude/settings.json | grep -A 10 "interaction_mode"

# Verify approval keywords are recognized
# Use exact keywords: APPROVED, COMMIT, CONTINUE, MODIFY
```

### Agent Not Found
```bash
# Check agent definitions exist
ls ~/.claude/agents/

# Verify agent has proper yaml frontmatter with 'name' field
head -n 5 ~/.claude/agents/github-issue-planner.md
```

## 🤝 Contributing

This configuration is designed to be shared and improved. To customize:

1. **Modify agent definitions** in `agents/` for your tech stack
2. **Adjust orchestrators** in `commands/` for your workflow
3. **Update interaction settings** in `settings.json` for your preferences
4. **Extend CLAUDE.md** with your project patterns

## 📜 License

This Claude Code configuration is part of your dotfiles and inherits your repository's license.

---

*This README documents a sophisticated multi-agent Claude Code setup with interactive controls and specialist routing. The system provides enterprise-grade development workflow automation while maintaining human oversight at all critical decision points.*