---
name: epic-breakdown
description: Break down a Feature/Epic PRD into GitHub issues and sub-issues with implementation tasks
interactive_mode: true

Examples:
- <example>
  Context: User wants to break down an epic
  user: "Break down the Audit Logs epic into sub-issues"
  assistant: "I'll analyze the Audit Logs PRD and create GitHub issues with task checklists. First, let me review the requirements and codebase..."
  <commentary>Breaking down epic into implementable GitHub issues and sub-issues with task checklists</commentary>
</example>
- <example>
  Context: User provides a Linear epic issue
  user: "Epic breakdown for GitHub milestone 'User Authentication'"
  assistant: "I'll analyze the User Authentication milestone and break it down into GitHub issues and sub-issues with detailed task checklists for implementation."
  <commentary>Creating epic breakdown from Linear issue reference</commentary>
</example>
---

# Rule: Breaking Down Feature/Epic into GitHub Issues and Sub-Issues

## Goal

Create a structured breakdown of a Feature/Epic into GitHub issues and sub-issues, with each issue containing its own task checklist. This creates the implementation plan for a feature defined in a PRD.

## Process

1. **Input Analysis:** Accept either:
   - A GitHub milestone name or link
   - A GitHub issue number/link
   - A PRD document reference
   - A feature description

2. **Analysis Phase:** 
   - Read and analyze the PRD or Epic requirements
   - Assess current codebase to understand existing infrastructure and patterns
   - Identify if this is for Nebula, Stellar, Pulsar, Simple Thai, or Wug
   - Check which Phoenix contexts are involved
   - Identify any ADRs that need to be written

3. **Phase 1: Generate Sub-Issues:** Create 3-8 sub-issues that represent major implementation chunks
   - Each should be 0.5 to 2 days of work
   - Examples: 'Implement database schema and migrations', 'Build Phoenix context and business logic', 'Create LiveView UI components', 'Add API endpoints', 'Write tests and documentation'

4. **Phase 2: Generate Task Checklists:** For each sub-issue, create a checklist of specific tasks
   - Each checklist item should be 1-4 hours of work
   - Include testing and documentation in checklists

5. **GitHub Creation:** Ask user: 'Should I create these as GitHub issues and sub-issues? (y/n)'
   - If yes, use GitHub CLI to create each issue and link sub-issues using GraphQL API
   - Add appropriate labels (backend/frontend/fullstack)
   - Set estimates based on S/M/L
   - Add the task checklist to each issue description
   - Create milestone if this is a top-level epic

## Output Format

The generated breakdown should follow this structure:

```markdown
# Epic Breakdown: [Feature Name]

**Epic**: [Feature Name]
**Product**: [Nebula/Stellar/Pulsar/Simple Thai/Wug]
**Estimated Duration**: [X days/weeks]
**Phoenix Context(s)**: [e.g., Accounts, AuditLogs]

## Sub-Issues

### 1. [Sub-Issue Title]
**Type**: Backend | Frontend | Full-stack
**Estimated**: S (2-4h) | M (4-8h) | L (1-2d)
**Dependencies**: None | Issue #X

#### Tasks
- [ ] Task description
- [ ] Another task
- [ ] Write tests for X
- [ ] Update documentation

#### Files to Modify/Create
- `lib/app/context_name/` - Phoenix context
- `lib/app_web/live/feature_live.ex` - LiveView module
- `test/app/context_name_test.exs` - Tests

---

### 2. [Next Sub-Issue Title]
**Type**: Backend
**Estimated**: M
**Dependencies**: Issue #1

#### Tasks
- [ ] Task description
- [ ] etc.

#### Files to Modify/Create
- `lib/app/.../`

---

## Implementation Order
1. Issue #1 - Database/Backend (start first)
2. Issue #2 - Core business logic (after #1)
3. Issue #3 - Frontend UI (can start with #2)
4. Issue #4 - Integration (after #2 and #3)

## ADRs Needed
- [ ] Decision: [What needs to be decided]
- [ ] Decision: [Another architecture decision]

## Notes
- [Any special considerations]
- [Dependencies on other features]
- [Performance considerations]
```

## Phoenix/Elixir Stack Awareness

When creating sub-issues, consider the typical Elixir/Phoenix/LiveView patterns:

### Common Sub-Issue Types:
- **Database Schema**: Ecto schemas, migrations, database setup
- **Phoenix Context**: Business logic, core functionality
- **LiveView UI**: Real-time UI components and interactions
- **API Layer**: REST endpoints or GraphQL resolvers
- **Background Jobs**: GenServers, Oban workers
- **Testing**: ExUnit tests, integration tests
- **Documentation**: Module docs, API documentation

### Phoenix Context Identification:
- Analyze existing contexts: Accounts, Blog, AuditLogs, etc.
- Determine if new context needed or extending existing
- Consider multi-tenant patterns if applicable

### File Structure Patterns:
```
lib/app/
├── context_name/
│   ├── schema.ex
│   └── context.ex
lib/app_web/
├── live/
│   └── feature_live.ex
└── controllers/
    └── api/
test/
└── app/
    └── context_name_test.exs
```

## Target Audience

Assume the primary reader is a **Phoenix/Elixir developer** familiar with the stack but who needs clear task breakdowns for implementation.

## Output Options

### Primary: GitHub Issues (Default)
* **Format:** Create issues and sub-issues as GitHub issues under milestone
* **Process:** Use GitHub CLI and GraphQL API to create each issue with task checklists
* **Benefits:** Trackable progress, proper workflow integration, native sub-issue support
* **Hierarchy:** Main issues linked to milestone, sub-issues linked to parent issues
* **Labels:** Apply appropriate backend/frontend/fullstack labels
* **Estimates:** Use GitHub issue size labels (S/M/L)

### Optional: Documentation
* **Format:** Show breakdown in chat first
* **File:** Optionally save to `/docs/epics/EPIC-{###}-{feature-name}-breakdown.md` if requested
* **Focus:** GitHub issue creation is primary, file is supplementary

## Final Instructions

1. **Analyze** the Epic/PRD and current codebase context
2. **Identify** product line and Phoenix contexts involved
3. **Generate** 3-8 sub-issues with realistic time estimates
4. **Create** detailed task checklists for each sub-issue
5. **Specify** file paths and dependencies
6. **Offer** to create GitHub issues and sub-issues with proper linking and labels
7. **Include** ADR identification for architectural decisions

**Note:** This command is specifically designed for the Elixir/Phoenix/LiveView stack and GitHub structure (Milestone → Issues → Sub-issues with task checklists).