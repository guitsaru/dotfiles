---
name: decision-point
description: Format for presenting architectural and implementation decisions
auto_apply: false
trigger_on: ["architecture_decision", "implementation_choice", "trade_off_analysis"]
---

You are presenting a decision point to the user. Clearly explain options, trade-offs, and implications to help them make an informed choice.

## Decision Point Format

### Architecture Decisions
```markdown
🏗️ **Architecture Decision Required**

**Context**: [What we're building and why this decision matters]

**Decision**: [Specific choice that needs to be made]

**Option 1: [Name]**
```
[Brief description]
```
✅ Pros:
- [Advantage 1]
- [Advantage 2]

❌ Cons:
- [Disadvantage 1]
- [Disadvantage 2]

💰 Cost: [Development time, complexity, maintenance]

**Option 2: [Name]**
```
[Brief description]
```
✅ Pros:
- [Advantage 1]
- [Advantage 2]

❌ Cons:
- [Disadvantage 1]
- [Disadvantage 2]

💰 Cost: [Development time, complexity, maintenance]

**My recommendation**: [Your suggestion based on context]

**Impact on**:
- Future development: [How this affects future work]
- Testing: [Testing implications]
- Performance: [Performance considerations]
- Maintenance: [Long-term maintenance]

Which direction should we take?
```

### Implementation Choices
```markdown
⚡ **Implementation Choice**

**Task**: [What we're implementing]

**Approach A: [Name]**
```elixir
# Code example
```
- Complexity: [Low/Medium/High]
- Performance: [Impact]
- Maintainability: [Assessment]

**Approach B: [Name]**
```elixir
# Code example
```
- Complexity: [Low/Medium/High]
- Performance: [Impact]
- Maintainability: [Assessment]

**Factors to consider**:
- [Consideration 1]
- [Consideration 2]

Which approach fits better with your codebase?
```

### Technology/Library Decisions
```markdown
📦 **Technology Choice**

**Need**: [What problem we're solving]

**Option 1: [Technology/Library]**
- **What it is**: [Brief description]
- **Integration effort**: [Low/Medium/High]
- **Learning curve**: [Low/Medium/High]
- **Community**: [Active/Moderate/Low]
- **Maintenance**: [Who maintains, update frequency]
- **Your codebase fit**: [How well it fits]

**Option 2: [Technology/Library]**
- **What it is**: [Brief description]
- **Integration effort**: [Low/Medium/High]
- **Learning curve**: [Low/Medium/High]
- **Community**: [Active/Moderate/Low]
- **Maintenance**: [Who maintains, update frequency]
- **Your codebase fit**: [How well it fits]

**Option 3: Build in-house**
- **Effort**: [Low/Medium/High]
- **Control**: Full control over implementation
- **Maintenance**: You own it forever
- **Fit**: Perfect fit for your needs

Which aligns with your project's direction?
```

### Data Model Decisions
```markdown
🗄️ **Data Model Decision**

**Entity**: [What we're modeling]
**Requirements**: [Key requirements]

**Option A: [Model approach]**
```sql
-- Schema example
```
- Query complexity: [Simple/Moderate/Complex]
- Flexibility: [Low/Medium/High]
- Performance: [Assessment]
- Migration path: [If changing later]

**Option B: [Model approach]**
```sql
-- Schema example
```
- Query complexity: [Simple/Moderate/Complex]
- Flexibility: [Low/Medium/High]
- Performance: [Assessment]
- Migration path: [If changing later]

**Considerations**:
- Current query patterns: [How you query now]
- Future requirements: [Anticipated needs]
- Consistency with existing models: [How it fits]

What matches your data access patterns best?
```

## Decision Criteria Framework

When presenting decisions, always consider:

1. **Immediate Impact**
   - Development time
   - Complexity to implement
   - Risk level

2. **Long-term Impact**
   - Maintenance burden
   - Technical debt
   - Scaling implications

3. **Team Impact**
   - Learning curve
   - Documentation needs
   - Onboarding complexity

4. **Business Impact**
   - Time to market
   - Feature flexibility
   - Performance requirements

## Good Examples

### Clear Trade-off Presentation
```markdown
🏗️ **Caching Strategy Decision**

**Context**: Dashboard queries are slow (3+ seconds)

**Option 1: Redis Cache**
- ✅ Proven, fast, distributed
- ✅ Good library support (Redix)
- ❌ Another service to manage
- ❌ Cache invalidation complexity
- 💰 2 days to implement, moderate maintenance

**Option 2: ETS with GenServer**
- ✅ No external dependencies
- ✅ Simpler invalidation
- ❌ Not distributed (each node has own cache)
- ❌ Memory usage on each node
- 💰 1 day to implement, low maintenance

**Option 3: Materialized Views**
- ✅ Pushed to database layer
- ✅ Consistent across all nodes
- ❌ Refresh strategy needed
- ❌ Database migration required
- 💰 1.5 days to implement, low maintenance

Given you're already using PostgreSQL heavily and not Redis elsewhere, I'd lean toward materialized views.

Your preference?
```

### Implementation with Context
```markdown
⚡ **API Response Format**

**Task**: Standardize API error responses

**Approach A: Phoenix Default**
```json
{"errors": {"field": ["error message"]}}
```
- Already used in 3 controllers
- Phoenix standard
- Simple to implement

**Approach B: JSON:API Format**
```json
{"errors": [{"source": {"pointer": "/data/attributes/field"}, "detail": "error message"}]}
```
- More structured
- Better for complex errors
- Industry standard

Given you're building a public API, the structured approach might serve you better long-term.

Which direction?
```

## Remember

- Present genuine alternatives, not strawmen
- Be honest about trade-offs
- Consider the user's context and constraints
- Make recommendations but respect choices
- Document decisions for future reference