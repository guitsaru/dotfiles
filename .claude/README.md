# Claude Code Configuration

A sophisticated multi-agent orchestration system for Claude Code, optimized for Elixir/Phoenix development with interactive workflow controls and quality gates.

## 🚀 Quick Start

```bash
# Full issue implementation with planning → execution → documentation
claude github-issue #127

# Break down milestone into actionable issues
claude github-milestone "User Authentication System"

# Comprehensive PR review with specialist coordination
claude github-review PR#89

# Resume work from current state
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

## 🤖 Specialized Agents

### Planning & Orchestration

**`github-issue-planner`**
- Converts GitHub issues into detailed implementation plans
- **Interactive**: Asks clarification questions and waits for approval
- **Intelligent routing**: Recommends specialist agents for each task
- **Quality focus**: Creates acceptance criteria and testing strategies

**`milestone-breakdown-planner`**
- Breaks large milestones into small, deliverable issues
- **Dependency aware**: Maps critical path and parallel work opportunities
- **Risk focused**: Identifies and mitigates potential blockers
- **Value oriented**: Designs thin-slice delivery for early feedback

**`implementation-executor`**
- Executes action plans with focused, atomic commits
- **Quality gates**: Runs tests and linting before every commit
- **User controlled**: Asks for approval before each file change
- **Specialist aware**: Routes complex work to appropriate experts

### Elixir/Phoenix Specialists

**`elixir-phoenix-dev`**
- General Elixir/Phoenix development with OTP patterns
- **Idiomatic code**: Leverages pattern matching, pipe operators, functional design
- **Multi-tenant aware**: Ensures proper org_id scoping
- **Performance focused**: Optimizes for scalability and maintainability

**`liveview-frontend-expert`**
- LiveView UI, Tailwind CSS, and DaisyUI integration specialist
- **Real-time patterns**: Efficient state management and DOM updates
- **Accessibility first**: WCAG compliance and responsive design
- **Component architecture**: Reusable, well-documented UI patterns

**`postgres-ecto-architect`**
- Database design, multi-tenancy, and performance optimization expert
- **Schema design**: Normalized structures with proper constraints
- **Multi-tenant patterns**: Row-level security and org_id isolation
- **Performance tuning**: Query optimization, indexing strategies

### Quality & Documentation

**`elixir-code-reviewer`**
- Comprehensive code review across architecture, security, performance
- **Multi-dimensional**: Analyzes OTP patterns, security vulnerabilities, performance
- **Best practices**: Enforces Elixir idioms and Phoenix conventions
- **Actionable feedback**: Specific improvements with code examples

**`elixir-docs-architect`**
- Technical documentation and knowledge management specialist
- **ExDoc expert**: Proper @moduledoc, @doc, @spec annotations
- **Architecture docs**: System overviews, decision records, integration guides
- **User focused**: Clear, maintainable documentation for team collaboration

**`pattern-documenter`**
- Implementation learning capture and cross-referencing specialist
- **Pattern extraction**: Identifies reusable architectural decisions
- **Knowledge sharing**: Updates PRs and issues with learnings
- **Team memory**: Preserves implementation context for future reference

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

### Agent Auto-Selection

Agents are automatically selected based on file patterns:

- `*.ex, *.exs, *.heex` → `elixir-phoenix-dev`
- `*_live.ex, *.heex` → `liveview-frontend-expert`
- `migrations/, *_schema.ex` → `postgres-ecto-architect`
- `*.md, docs/, guides/` → `elixir-docs-architect`

## 📊 Quality Gates

### Pre-Commit Hooks
```bash
mix format --check-formatted && mix credo --strict && mix test
```

### Commit Requirements
- ✅ Format check passes
- ✅ Static analysis (Credo) passes
- ✅ All tests pass
- ✅ No compilation warnings

### PR Requirements
- ✅ 80%+ test coverage
- ✅ Documentation updated
- ✅ Patterns documented for reuse

## 🔄 Example Workflows

### Complete Feature Implementation

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