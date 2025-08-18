---
name: implementation-plan
description: Structured format for presenting implementation plans with user checkpoints
auto_apply: false
trigger_on: ["planning_phase", "action_plan_creation"]
---

You are creating an implementation plan with the user. Present clear, actionable steps with decision points for user input.

## Implementation Plan Format

### Plan Overview
```markdown
📋 **Implementation Plan**

**Goal**: [What we're building]
**Scope**: [What's included/excluded]
**Estimated Time**: [Rough estimate]

**High-Level Approach**:
1. [Major phase 1]
2. [Major phase 2]
3. [Major phase 3]

**Key Decisions Needed**:
- [ ] [Decision 1 - when it will come up]
- [ ] [Decision 2 - when it will come up]
- [ ] [Decision 3 - when it will come up]

Does this overall approach look good?
```

### Detailed Action Plan
```markdown
## Action Plan

### Phase 1: [Phase Name]
**Goal**: [What this phase accomplishes]

- [ ] **Task 1.1**: [Specific task]
  - Files: `[files to modify]`
  - Decision point: [Any decision needed]
  - Validation: [How we'll know it works]

- [ ] **Task 1.2**: [Specific task]
  - Files: `[files to modify]`
  - Decision point: [Any decision needed]
  - Validation: [How we'll know it works]

**Checkpoint**: After Phase 1, we'll have [what's complete]. Continue?

### Phase 2: [Phase Name]
**Goal**: [What this phase accomplishes]

- [ ] **Task 2.1**: [Specific task]
  - Files: `[files to modify]`
  - Decision point: [Any decision needed]
  - Validation: [How we'll know it works]

- [ ] **Task 2.2**: [Specific task]
  - Files: `[files to modify]`
  - Decision point: [Any decision needed]
  - Validation: [How we'll know it works]

**Checkpoint**: After Phase 2, we'll have [what's complete]. Continue?

### Phase 3: [Phase Name]
**Goal**: [What this phase accomplishes]

- [ ] **Task 3.1**: [Specific task]
  - Files: `[files to modify]`
  - Decision point: [Any decision needed]
  - Validation: [How we'll know it works]

**Final Checkpoint**: Implementation complete. Ready for review?
```

### Technical Approach
```markdown
## Technical Approach

### Architecture Pattern
[Describe the pattern we'll use]

**Why this pattern**:
- [Reason 1]
- [Reason 2]

**Alternatives considered**:
- [Alternative]: [Why not chosen]

Agree with this pattern?

### Key Components

**[Component 1]**
- Purpose: [What it does]
- Pattern: [Pattern used]
- Dependencies: [What it needs]

**[Component 2]**
- Purpose: [What it does]
- Pattern: [Pattern used]
- Dependencies: [What it needs]

### Data Flow
```
[Simple ASCII diagram or description]
```

Does this architecture make sense?
```

### Risk Mitigation
```markdown
## Risks & Mitigations

**Risk 1**: [Potential issue]
- **Likelihood**: Low/Medium/High
- **Impact**: Low/Medium/High
- **Mitigation**: [How we'll handle it]
- **Decision point**: [When we'll need your input]

**Risk 2**: [Potential issue]
- **Likelihood**: Low/Medium/High
- **Impact**: Low/Medium/High
- **Mitigation**: [How we'll handle it]
- **Decision point**: [When we'll need your input]

Any other risks I should consider?
```

## Planning Guidelines

### Good Plan Characteristics
1. **Incremental**: Each step builds on the previous
2. **Testable**: Can validate each step works
3. **Reversible**: Can back out if needed
4. **Clear**: Specific files and changes identified
5. **Flexible**: Room for adjustments as we learn

### Decision Points to Include
- Naming conventions
- Pattern choices
- Library selections
- Performance trade-offs
- Security considerations
- API design decisions

### Validation Checkpoints
- After each phase
- Before major refactoring
- Before external integrations
- Before data migrations
- Before performance optimizations

## Example Plans

### Good: Clear and Interactive
```markdown
📋 **Implementation Plan: User Notifications**

**Goal**: Add in-app notifications with real-time updates
**Scope**: Backend + LiveView UI (no email/SMS yet)
**Estimated Time**: 4-6 hours

**High-Level Approach**:
1. Database schema for notifications
2. Context module with business logic
3. LiveView components for display
4. Real-time updates via PubSub

**Key Decisions Needed**:
- [ ] Mark as read individually or bulk?
- [ ] Soft delete or permanent delete?
- [ ] How many notifications to display initially?

## Action Plan

### Phase 1: Data Layer
**Goal**: Set up database and basic CRUD

- [ ] **Task 1.1**: Create notification schema
  - Files: `lib/app/notifications/notification.ex`
  - Decision: Include `metadata` JSONB field for flexibility?
  - Validation: Schema compiles, migration runs

- [ ] **Task 1.2**: Create notifications context
  - Files: `lib/app/notifications.ex`
  - Decision: Naming: `create_notification` or `notify`?
  - Validation: Tests pass for CRUD operations

**Checkpoint**: Basic notification storage working. Ready for UI?

### Phase 2: LiveView UI
**Goal**: Display notifications with real-time updates

- [ ] **Task 2.1**: Create notification bell component
  - Files: `lib/app_web/live/components/notification_bell.ex`
  - Decision: Show count badge always or only when > 0?
  - Validation: Component renders, shows count

- [ ] **Task 2.2**: Create notification dropdown
  - Files: `lib/app_web/live/components/notification_list.ex`
  - Decision: Infinite scroll or pagination?
  - Validation: List displays, mark as read works

**Checkpoint**: UI complete. Add real-time updates?

Look good to start with Phase 1?
```

### Good: Technical Clarity
```markdown
## Technical Approach

### Pattern: Phoenix PubSub + LiveView

We'll use Phoenix.PubSub to broadcast notification events to LiveView processes.

**Flow**:
```
Create Notification → Broadcast to user's topic → LiveView receives → UI updates
```

**Why this pattern**:
- Leverages existing Phoenix infrastructure
- No additional dependencies
- Scales well with your current architecture

**Alternative considered**:
- Polling: Simpler but not real-time
- ActionCable: Overkill for this use case

This matches your existing real-time patterns. Shall we proceed?
```

## Remember

- Plans are collaborative documents
- Flexibility is key - plans will evolve
- User input shapes the implementation
- Small, validated steps over big leaps
- Document decisions for future reference