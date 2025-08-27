---
name: context-dump
description: Capture work session context for easy resumption, including git state, Linear issues, and next steps
interactive_mode: true

Examples:
- <example>
  Context: User ending work day and wants to save context
  user: "Create a context dump, I need to stop for the day"
  assistant: "I'll capture your current work context. I can see you've been working on audit logs with 3 commits today and have uncommitted LiveView changes. Let me gather the details..."
  <commentary>Gathering comprehensive work context for easy next-day resumption</commentary>
</example>
- <example>
  Context: User pausing work to switch tasks
  user: "Save my current context for the payment system work"
  assistant: "I'll create a context dump for your payment system work. Gathering git status, Linear issues, and current progress..."
  <commentary>Creating focused context dump for task switching</commentary>
</example>
- <example>
  Context: User needs to handoff work to another developer
  user: "End of day summary for handoff to the team"
  assistant: "I'll create a comprehensive handoff context with detailed setup instructions and current progress..."
  <commentary>Creating detailed handoff context with setup information</commentary>
</example>
---

# Rule: Creating Work Session Context Dumps

## Goal

Create a context dump that captures the current state of work, decisions made, and next steps, making it easy to resume work after a break or hand off to another developer (or Claude).

## Trigger Recognition

Command can be invoked by:
- 'Create a context dump'
- 'Save my current context'
- 'End of day summary'
- 'Pause work on [feature]'
- 'Context dump for handoff'

## Process

1. **Automatic Context Gathering**: Collect git, Linear, and file system data
2. **Interactive Questions**: Ask user for decisions, blockers, and next steps
3. **Generate Context Dump**: Create comprehensive summary using template
4. **Save Options**: Offer Linear issue, comment, local file, or multiple formats

## Automatic Context Gathering

### From Git:
```bash
# Check current branch
git branch --show-current

# Get uncommitted changes
git status --short

# Get today's commits
git log --oneline --since='6am' --author='$(git config user.name)'

# Check for stashed changes
git stash list

# Check commits ahead/behind main
git rev-list --count main..HEAD
```

### From Linear (via MCP):
- Current 'In Progress' issues
- Issues updated today
- Comments added today
- Recently modified issues

### From Recent Work:
- Files modified in last 4 hours (using filesystem timestamps)
- Recently run test files
- Any error messages or blockers encountered
- Current directory and active files

## Interactive Questions

Ask the user:
- **Primary Work**: "What were you primarily working on?"
- **Decisions Made**: "Any decisions made that aren't committed yet?"
- **Blockers**: "Any blockers or issues encountered?"
- **Next Task**: "What's the next immediate task when resuming?"
- **Research Links**: "Any research or links to save?"
- **Session Mode**: "Is this: a) End of day, b) Task switch, c) Handoff to team, d) Blocker pause?"

## Context Dump Template

```markdown
# Context Dump: [Date + Time]

**Feature/Epic**: [Current feature from Linear]
**Linear Issue**: [LIN-XXX if applicable]
**Duration**: [How long this session]
**Status**: ✅ Good Progress | ⚠️ Blocked | 🔄 In Progress

## Current State

### Branch
`[branch-name]` - [X commits ahead of main]

### Uncommitted Changes
```
M  lib/app/audit_logs/audit_log.ex
A  lib/app_web/live/audit_log_live/index.ex
?? test/new_test_file.exs
```

### Today's Commits
- `abc123` feat: Add audit log schema
- `def456` test: Add audit log context tests

### Stashed Changes
- `stash@{0}` WIP: experimental pagination approach

## What I Worked On

### Completed ✅
- [x] Implemented audit log schema
- [x] Added Ecto migration for audit_logs table
- [x] Created basic context functions

### In Progress 🚧
- [ ] Building LiveView interface (50% done)
  - Created basic template
  - Need to add pagination

### Blocked/Issues ⚠️
- Performance issue with large datasets
- Need decision on retention policy

## Key Decisions Made

1. **Decision**: Using JSONB for metadata field
   **Reason**: Flexible schema for different event types
   **Alternative considered**: Separate tables per event type

2. **Decision**: Implementing soft deletes
   **Reason**: Compliance requirements
   **Implementation**: Using `deleted_at` timestamp

## Code Context

### Current Focus File
`lib/app_web/live/audit_log_live/index.ex`

```elixir
# Working on pagination - current attempt:
defmodule MyAppWeb.AuditLogLive.Index do
  use MyAppWeb, :live_view
  
  @impl true
  def mount(_params, _session, socket) do
    # TODO: Add pagination params here
    {:ok, assign(socket, logs: list_logs())}
  end
end
```

### Key Functions Modified
- `AuditLogs.list_logs/1` - Added filtering
- `AuditLog.changeset/2` - Added validation

## Test Status
```bash
# Last test run
mix test test/app/audit_logs_test.exs
# 8 tests, 0 failures

# Need to run
mix test test/app_web/live/audit_log_live_test.exs
# Not yet written
```

## Next Steps

### Immediate (Resume Here) 👈
```bash
# Resume command for Claude/tomorrow:
cd ~/projects/myapp && \
git checkout feature/audit-logs && \
code lib/app_web/live/audit_log_live/index.ex

# Then: Implement pagination using Flop library
```

### Next Tasks
1. Complete LiveView pagination
2. Add filtering by date range
3. Implement export functionality
4. Write LiveView tests

## Questions to Resolve
- [ ] What's the retention policy? (30/60/90 days?)
- [ ] Should we add real-time updates via PubSub?
- [ ] Need UI/UX review of the table design

## Resources & Links

### Documentation
- [Flop pagination docs](https://hex.pm/packages/flop)
- [Our ADR on audit logs](Linear document link)
- Original PRD: LIN-XXX

### Research/Examples
- [Similar implementation in Phoenix app](link)
- [Performance article about JSONB](link)

## Environment Notes
- Postgres running locally
- Seeds need updating for test data
- Remember to run `mix ecto.migrate` after pulling

## Handoff Notes
[Any specific notes for another developer or future self]
- The tricky part is handling the metadata field validation
- Consider using Ecto.Multi for batch operations
- Check with Sarah about the UI requirements

---
**Linear Issue**: LIN-XXX
**Created**: [Timestamp]
**Next Session**: [Planned time if known]
```

## Special Modes

### End of Day Mode
Include additional sections:
- **Daily Summary**: Overview of all today's work across issues
- **Tomorrow's Priorities**: Ordered list of next day tasks
- **Overnight Thoughts**: Space for any ideas that might come up

### Handoff Mode
Include additional sections:
- **Setup Instructions**: Detailed environment setup steps
- **Access Requirements**: List of credentials/permissions needed
- **Contact Information**: Who to reach for questions
- **Code Review Notes**: Any pending reviews or feedback

### Blocker Mode
Focus on:
- **Detailed Blocker Description**: What exactly is blocked and why
- **Attempted Solutions**: What was tried and results
- **Potential Solutions**: Ideas to explore when resuming
- **Help Needed**: Who might be able to assist

## Auto-detection Features

Before creating the dump, check and warn about:
- **Failing tests**: Suggest fixing before context dump
- **Large uncommitted changes**: Warn if many files modified
- **Linear status mismatch**: Check if Linear issue status matches actual progress
- **Missing commits**: If substantial work isn't committed

## Smart Resumption Features

### Generate Resume Script
Create a bash script for easy resumption:
```bash
#!/bin/bash
# resume-work-[date].sh
echo '🚀 Resuming work on: [Feature Name]'
echo '📂 Project: [Project Path]'
git checkout [branch-name]
git status
echo '📋 Last context: [context-file-path]'
echo '🔗 Linear issue: [Linear URL]'
echo '✅ Run: mix test to verify tests still pass'
echo '📝 Focus file: [current-focus-file]'
```

### Smart Suggestions
Based on current state, suggest:
- Whether to commit current changes before stopping
- If any quick wins can be completed now
- Optimal resume time based on complexity

## Output Options

Ask user preference for saving:

### Option A: Linear Issue (Recommended for feature work)
- Create issue with label `docs:context`
- Link to current epic/feature (can be child of epic)
- Title: 'Context: [Feature] - [Date]'
- Benefits: Trackable, searchable, part of workflow
- Use Linear MCP to create

### Option B: Linear Comment (Quick pauses)
- Add as comment on current issue
- Good for quick pauses and updates
- Preserves context within feature discussion

### Option C: Project Document (Strategic context)
- Save as document within project
- Good for broader initiative context not tied to specific issues
- Title: 'Context: [Initiative] - [Date]'

### Option D: Local File + Linear
- Save to `.context/[date]-[feature].md` and create Linear issue/comment
- Best for important checkpoints with redundancy

## Integration Features

### Phoenix/Elixir Specific Context
- **Active Phoenix Context**: Which context module is being worked on
- **Migration Status**: Any pending migrations
- **Dependency Changes**: New packages added to mix.exs
- **LiveView State**: Any complex state management being implemented

### Linear Integration
- **Issue Relationships**: Parent epics, dependent issues
- **Label Context**: Current labels and their significance
- **Team Context**: Who else is involved in this feature
- **Milestone Progress**: How this fits into current milestone

## Target Audience

Designed for:
- **Future self** resuming work after break
- **Team members** taking over work
- **Claude** continuing implementation
- **Code review** providing context

## Final Instructions

1. **Gather context automatically** from git, Linear, and filesystem
2. **Ask targeted questions** based on detected work state
3. **Create comprehensive dump** using appropriate template
4. **Offer multiple save options** with user preference
5. **Generate resume helpers** (scripts, commands)
6. **Smart suggestions** for immediate actions
7. **Link related resources** (ADRs, PRDs, Linear issues)
8. **Focus on resumption ease** - what would make restart seamless?

**Key Principles**:
- Comprehensive but quick to create
- Focus on resumption seamlessness
- Capture decisions and reasoning, not just facts
- Include both technical and human context
- Make it valuable for any developer picking up the work