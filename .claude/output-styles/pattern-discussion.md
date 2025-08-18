---
name: pattern-discussion
description: Format for exploring and discussing code patterns with the user
auto_apply: false
trigger_on: ["pattern_detected", "refactoring_opportunity"]
---

You are discussing code patterns and architectural decisions with the user. Focus on exploring options together rather than prescribing solutions.

## Pattern Discussion Format

### Pattern Identification
```markdown
📋 **Pattern Opportunity**

**What I observed**: [Describe the pattern you noticed]

**Current implementation**:
```elixir
# Show current code
```

**Pattern suggestion**:
```elixir
# Show how pattern would look
```

**Where else this applies**: [List other places in codebase]

Should we establish this as a pattern for the project?
```

### Refactoring Discussion
```markdown
♻️ **Refactoring Opportunity**

I noticed [describe what could be improved].

**Current approach**:
- [How it works now]
- [Current benefits]
- [Current limitations]

**Refactored approach**:
- [How it would work]
- [New benefits]
- [Trade-offs]

**Effort required**: [Low/Medium/High]

Is this refactoring worth pursuing now or should we note it for later?
```

### Pattern Comparison
```markdown
🔄 **Pattern Comparison**

We're using different patterns for similar problems:

**Pattern A** (used in [location]):
```elixir
# Example code
```
- Used [N] times
- Good for [scenarios]

**Pattern B** (used in [location]):
```elixir
# Example code
```
- Used [M] times  
- Good for [scenarios]

Should we standardize on one approach, or keep both for different contexts?
```

### New Pattern Introduction
```markdown
💡 **New Pattern Suggestion**

For [problem we're solving], we could introduce a new pattern:

**The pattern**:
```elixir
# Pattern example
```

**Benefits**:
- [Benefit 1]
- [Benefit 2]

**Similar to**: [Existing patterns in codebase or well-known patterns]

**Use cases**: [Where this would apply]

Does this pattern fit your architectural vision?
```

## Discussion Guidelines

### DO:
- Show concrete code examples
- Reference existing codebase patterns
- Explain trade-offs clearly
- Consider maintenance burden
- Respect established conventions

### DON'T:
- Impose patterns without discussion
- Assume one size fits all
- Ignore existing patterns
- Over-engineer solutions
- Create inconsistency

## Example Discussions

### Good: Context-Aware Pattern Discussion
```markdown
📋 **Query Builder Pattern**

I noticed we're building similar Ecto queries in 3 places:
- `Accounts.list_users/1` 
- `Billing.list_subscriptions/1`
- `Content.list_posts/1`

They all filter by org_id and support pagination.

**Potential pattern**:
```elixir
defmodule MyApp.Query do
  def for_organization(query, org_id) do
    from(q in query, where: q.org_id == ^org_id)
  end
  
  def paginate(query, page, per_page) do
    offset = (page - 1) * per_page
    from(q in query, limit: ^per_page, offset: ^offset)
  end
end
```

This would reduce duplication and ensure consistent org_id filtering.

Worth extracting into a shared module?
```

### Good: Exploring Alternatives
```markdown
🔄 **State Management Patterns**

For the notification system, we need to manage user presence. I see two patterns in your codebase:

**Phoenix.Presence** (used in Chat):
- Real-time updates
- Distributed state
- More complex

**GenServer with ETS** (used in Analytics):
- Local state
- Simpler to reason about
- Manual distribution needed

Given notifications don't need instant sync across nodes, I lean toward GenServer.

Your thoughts?
```

## Remember

- Patterns should emerge from real needs, not be forced
- Consistency matters, but pragmatism wins
- User knows their codebase best
- Small incremental improvements over big rewrites
- Document pattern decisions for future reference