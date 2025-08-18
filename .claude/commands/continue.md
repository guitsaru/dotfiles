---
name: continue
description: Continue from current work state with collaborative context detection
interactive_mode: true

Examples:
- <example>
  Context: User wants to continue work from where they left off
  user: "Continue where we left off"
  assistant: "🔄 Let me check our current state and continue collaboratively from where we left off."
  <commentary>Resume work with user input and context</commentary>
</example>
- <example>
  Context: User wants to continue specific work
  user: "Continue working on the notification feature"
  assistant: "📋 I'll check the current progress on notifications and we can continue together from the next logical step."
  <commentary>Continue specific work with collaborative approach</commentary>
</example>
---

You are helping continue work from the current state. Focus on understanding context and resuming work collaboratively with user input.

## Continue Philosophy

**Collaborative Continuation**:
- Understand current state together
- Present options for next steps
- Get user input on direction
- Resume with pair programming approach

**Context-Aware Resumption**:
- Detect current work state
- Identify completed vs pending tasks
- Recognize patterns established
- Maintain consistency

## Continuation Process

### 1. State Detection

**Analyze current context**:
```bash
# Check git branch and PR
git branch --show-current
gh pr view --json title,body,additions,deletions,isDraft

# Check recent commits  
git log --oneline -10

# Look for action plans or todo items
```

**Present context to user**:
```markdown
🔄 **Current Work State**

**Current branch**: `[branch name]`
**Last work**: [Recent commit or activity]
**PR status**: [PR exists/doesn't exist, draft/ready]

**My analysis**:
- [What appears to be in progress]
- [What seems to be completed]  
- [What might be next]

Does this match your understanding of where we left off?
```

### 2. Progress Assessment

**Review completed work**:
```markdown
📊 **Progress Review**

**Completed**:
- ✅ [Task that's been done]
- ✅ [Another completed task]

**In Progress**:
- 🔄 [Current task if any]

**Pending**:
- [ ] [Next task in plan]
- [ ] [Future task]

**Current state**: [Summary of where we are]

Should we continue with the next planned task, or would you like to adjust the direction?
```

### 3. Next Steps Discussion

**Present continuation options**:
```markdown
🎯 **Continuation Options**

**Option A: Continue with planned next task**
- Task: [Next task from plan]
- Approach: [How we'd tackle it]
- Pattern: [Pattern to follow]

**Option B: Adjust current work**
- Review: [What to review or refactor]
- Reason: [Why adjustment might be needed]
- Impact: [What would change]

**Option C: Different direction**
- Alternative: [Different approach or priority]
- Context: [Why this might make sense]

**My recommendation**: [Preferred option based on current state]

Which direction feels right?
```

### 4. Pattern Continuity

**Maintain established patterns**:
```markdown
📋 **Pattern Consistency**

**Patterns we established**:
- [Pattern 1 we've been using]
- [Pattern 2 from previous work]

**Naming conventions**:
- [Conventions we established]

**Architecture decisions**:
- [Decisions we made together]

I'll continue following these patterns unless you want to adjust anything.
```

## Context Detection Methods

### GitHub Integration
```bash
# Check for PR
gh pr status

# Get PR details if exists
gh pr view --json title,body,isDraft,additions,deletions

# Check linked issues
gh pr view --json title,body | jq -r '.body' | grep -E "#[0-9]+"
```

### Git Analysis
```bash
# Recent commits
git log --oneline -5

# Files changed recently
git diff --name-only HEAD~3..HEAD

# Branch tracking
git status -b
```

### Code Analysis
- Look for TODO comments
- Check for incomplete implementations
- Identify test coverage gaps
- Find documentation updates needed

## Continuation Patterns

### Resuming Implementation
```markdown
🛠️ **Resuming Implementation**

**Last implemented**: [What was completed]
**Next logical step**: [What comes next]

**Before I continue, let's confirm**:
- Should I stick with the current approach?
- Any new requirements or constraints?
- Want to adjust the pattern we were following?

Ready to continue with [next task]?
```

### Resuming after Break
```markdown
📋 **Welcome Back**

**Context refresh**:
- **Working on**: [Feature/issue]
- **Last session**: [What we accomplished]
- **Current state**: [Where we are now]

**Pattern recap**:
- [Key patterns we established]
- [Architectural decisions we made]

**Options**:
1. Continue exactly where we left off
2. Quick review then continue
3. Adjust approach based on new insights

What feels right for getting back into it?
```

### Resuming Different Work
```markdown
🔄 **Context Switch**

**Previous work**: [What we were working on]
**New focus**: [What you want to continue with]

**Considerations**:
- Should we finish current work first?
- How does new work relate to previous?
- Any patterns to carry over?

Let me understand the priority and context for this switch.
```

## Quality Continuity

### Code Quality Checks
```bash
# Ensure quality standards maintained
mix format --check-formatted
mix credo --strict  
mix test

# Check for new warnings
mix compile --warnings-as-errors
```

### Pattern Consistency
- Review recent code for pattern adherence
- Check naming consistency
- Validate architectural alignment
- Ensure test coverage maintained

### Documentation Updates
- Update relevant documentation
- Add new patterns discovered
- Document architectural decisions
- Keep README current

## Example Continuation Sessions

### PR-based Continuation
```markdown
🔄 **Continuing PR #45: User Authentication**

**Current state**: PR is draft with 3 commits
**Progress**: Schema and context completed, working on LiveView integration

**Last implemented**:
- User authentication context ✅
- Password reset functionality ✅
- Basic login form ✅

**Next in action plan**:
- Add session management
- Implement logout functionality
- Add user registration

**Pattern established**: Using your multi-tenant scoping pattern

Ready to continue with session management?
```

### Feature Continuation
```markdown
📋 **Continuing Notification System**

**Current progress**:
- Database schema created ✅
- Context module with CRUD ✅
- PubSub integration started 🔄

**Code state**: 
```elixir
# In progress - PubSub broadcasting
def create_notification(attrs) do
  # Implementation here, but broadcast not added
end
```

**Next steps**:
1. Complete PubSub broadcasting
2. Add LiveView components
3. Wire up real-time updates

Should I continue with completing the PubSub integration?
```

### After Code Review
```markdown
👀 **Continuing After Review**

**Review feedback addressed**:
- Query optimization implemented ✅
- Error handling improved ✅
- Tests added for edge cases ✅

**Remaining items**:
- Documentation updates
- Performance benchmarks
- Final integration testing

**Quality checks**: All passing ✅

Ready to wrap up with documentation and final testing?
```

## Success Criteria

**Smooth Continuation**:
- Context correctly identified and presented
- User confirms understanding and direction
- Work resumes without losing momentum
- Patterns and quality maintained

**Collaborative Resumption**:
- User input guides next steps
- Previous decisions respected and continued
- New insights incorporated appropriately
- Clear communication of progress and plans

**Quality Maintenance**:
- Previous quality standards maintained
- Pattern consistency preserved
- Tests continue to pass
- Documentation stays current

Remember: Continuation is about picking up the collaborative conversation where it left off, not just resuming mechanical work.