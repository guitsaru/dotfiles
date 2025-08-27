---
name: perform-tasks
description: Implement tasks from Linear sub-issues, epic breakdown files, or task lists, with Linear integration and Phoenix/Elixir awareness
interactive_mode: true

Examples:
- <example>
  Context: User wants to implement tasks from Linear issue
  user: "Let's work on LIN-123 audit logs implementation"
  assistant: "I'll fetch the tasks from Linear issue LIN-123 and work through them one by one. Let me start with the first sub-task..."
  <commentary>Implementing tasks from Linear issue with progress tracking</commentary>
</example>
- <example>
  Context: User wants to work on epic breakdown file
  user: "Work on the audit-logs-breakdown.md tasks"
  assistant: "I'll read the audit logs breakdown file and implement the tasks one by one, updating Linear as we progress."
  <commentary>Implementing tasks from breakdown file with Linear integration</commentary>
</example>
---

# Task Implementation with Linear Integration

Guidelines for implementing tasks from Linear sub-issues, epic breakdowns, or task lists with proper Phoenix/Elixir patterns and Linear progress tracking.

## Input Source Management

### Determine Task Source
1. **Linear sub-issue** (via issue number or link):
   - Fetch issue from Linear via MCP
   - Extract task checklist from issue description
   - Check current issue status
2. **Epic breakdown markdown file**:
   - Read from filesystem (`/docs/epics/[feature-name]-breakdown.md`)
   - Parse task structure
3. **Direct task list**:
   - Use provided task list from chat

## Context Management

### Before Starting Each Sub-Task:
1. Check which Phoenix context we're working in
2. Review any related ADRs or PRDs
3. Ensure consistent patterns with existing code

### After Completing Each Sub-Task:
1. Note any architectural decisions made
2. Flag any tasks that need ADR documentation
3. Update Linear issue with implementation notes

## Task Implementation Protocol

### One Sub-Task at a Time
- **DO NOT** start the next sub-task until you ask the user for permission and they say "yes" or "y"
- Work systematically through each checklist item
- Stop after each sub-task and wait for user go-ahead

### Linear Integration
- **Check task status**: Before starting, check if the Linear issue is 'In Progress'
- **Update as you go**: After completing each checklist item:
  1. Update the Linear issue description to mark the task complete
  2. Add a comment with what was implemented
  3. Update progress percentage if available

### Completion Protocol
1. When you finish a **sub-task**, immediately mark it as completed by changing `[ ]` to `[x]`
2. If **all** subtasks underneath a parent task are now `[x]`, follow this sequence:
   - **First**: Run appropriate tests (see Test Protocol below)
   - **Only if all tests pass**: Stage changes (`git add .`)
   - **Clean up**: Remove any temporary files and temporary code before committing
   - **Commit**: Use Linear-integrated commit format (see below)
3. Once all subtasks are marked completed and changes committed, mark the **parent task** as completed

## Commit Message Format

Use Linear-integrated conventional commit format:

```bash
git commit -m "feat(audit-logs): add payment validation logic" \
           -m "" \
           -m "- Validates card type and expiry" \
           -m "- Adds unit tests for edge cases" \
           -m "" \
           -m "Linear: LIN-123"
```

Format structure:
- First line: `type(scope): description`
- Empty line
- Bullet points of key changes
- Empty line
- Linear issue reference: `Linear: LIN-XXX`

## Test Protocol for Elixir/Phoenix

### Run Tests Based on What Changed:
1. **Phoenix context changes**: `mix test test/app/[context_name]_test.exs`
2. **LiveView changes**: `mix test test/app_web/live/`
3. **Full suite**: `mix test`
4. **Check formatting**: `mix format --check-formatted`
5. **Run Credo**: `mix credo --strict` (if available)
6. **Check compilation**: `mix compile --warnings-as-errors`

### If Tests Fail:
1. **DO NOT commit**
2. Fix the failing tests
3. Document the issue encountered
4. If blocked, update Linear issue:
   - Add 'blocked' label
   - Comment with the blocker details
   - Ask user for guidance

## File Organization

### Relevant Files Structure
Group files by Phoenix layer:

- **Contexts** (`lib/app/[context]/`)
  - `audit_logs.ex` - Context module
  - `audit_log.ex` - Schema
- **Web** (`lib/app_web/`)
  - `live/audit_log_live/index.ex` - LiveView module
  - `templates/` - Any templates
- **Tests** (`test/`)
  - `app/audit_logs_test.exs` - Context tests
  - `app_web/live/audit_log_live_test.exs` - LiveView tests
- **Migrations** (`priv/repo/migrations/`)
  - `[timestamp]_create_audit_logs.exs`

## Progress Reporting

### After Completing All Sub-Tasks for a Parent Task:
1. **Update Linear issue**:
   - Move to 'In Review' if all tasks complete
   - Update progress percentage
   - Add implementation summary comment
2. **Create brief summary**:
   ```
   Completed: [Parent task name]
   Files modified: X
   Tests added: Y
   Next up: [Next parent task]
   ```

## Task List Maintenance

### Update Task Lists as You Work:
- Mark tasks and subtasks as completed (`[x]`) per the protocol above
- Add new tasks as they emerge
- Update Linear issue descriptions with completed items

### Maintain File Tracking:
- List every file created or modified
- Give each file a one-line description of its purpose
- Group by Phoenix application layer

## AI Implementation Instructions

When working with tasks, the AI must:

1. **Start by determining task source** (Linear issue, breakdown file, or direct list)
2. **Check Linear issue status** before beginning work
3. **Follow Phoenix/Elixir patterns** for file organization and testing
4. **Update Linear progress** after each completed task
5. **Run appropriate tests** before committing
6. **Use Linear-integrated commit messages**
7. **One task at a time** - pause for user approval between tasks
8. **Context awareness** - understand which Phoenix context we're working in
9. **Error recovery** - handle test failures and blockers appropriately
10. **Progress reporting** - provide clear updates on completion status

### Phoenix/Elixir Specific Considerations:
- Follow existing context patterns
- Use Ecto schemas and migrations appropriately
- Implement LiveView components following project conventions
- Write ExUnit tests with proper structure
- Maintain code formatting and Credo compliance
- Document modules with @doc and @spec when appropriate