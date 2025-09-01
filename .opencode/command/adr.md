---
description: Generate Architecture Decision Records (ADRs) to document technical decisions and save them as GitHub documents
---

# Architecture Decision Record (ADR) Creation

## Goal

Create Architecture Decision Records (ADRs) to document important technical decisions, trade-offs, and architectural choices. ADRs provide historical context for why decisions were made and help maintain institutional knowledge.

## Process

1. **Initial Input**: Accept one of:
   - A technical decision that needs documenting
   - A question about architectural choices
   - Reference to a GitHub issue that needs an ADR

2. **Clarifying Questions**: Gather context, decision, and impact information

3. **Research Phase** (if needed): Search for best practices and alternatives

4. **Generate ADR**: Create comprehensive documentation using template

5. **Create GitHub Document**: Save as markdown file in `/docs/adr/ADR-{###}-{title}.md` with PR workflow

6. **Follow-up Actions**: Suggest implementation steps if decision is accepted

## Clarifying Questions

Ask the user (provide lettered options where appropriate):

### Context Questions:
* **Problem Statement**: "What problem are we trying to solve?"
* **Product Context**: "Is this for: a) Nebula, b) Stellar, c) Pulsar, d) Simple Thai, e) Wug?"
* **Feature Relation**: "Related to which feature/epic? (GitHub issue number if applicable)"
* **Decision Trigger**: "What triggered this decision? (new feature, performance issue, technical debt, etc.)"

### Decision Questions:
* **Current Thinking**: "What solution have you chosen or are leaning toward?"
* **Alternatives**: "What alternatives are you considering? (list 2-3 options)"
* **Research Status**: "Have you done any research, benchmarks, or proofs of concept?"

### Impact Questions:
* **Affected Areas**: "Who/what will be affected by this decision?"
* **Reversibility**: "Is this reversible or a one-way door?"
* **Timeline**: "Timeline: a) Immediate, b) This quarter, c) Future"

## Research Phase (if needed)

If the user hasn't fully decided or needs more information:
- Search for best practices (use web search if needed)
- Check for similar decisions in existing ADRs
- Research alternatives and trade-offs
- Look for benchmarks or case studies
- Consider stack-specific implications

## ADR Template

```markdown
# ADR-[NUMBER]: [Title]

**Date**: [YYYY-MM-DD]
**Status**: Proposed | Accepted | Superseded | Deprecated
**Deciders**: [Names/Roles]
**Technical Story**: [GitHub issue link if applicable]

## Context and Problem Statement

[Describe the context and problem in 2-3 sentences. Why does this decision need to be made?]

### Background
[Additional context, current state, constraints]

### Requirements
- [Requirement 1]
- [Requirement 2]

## Decision Drivers

- [Driver 1, e.g., Performance requirements]
- [Driver 2, e.g., Developer experience]
- [Driver 3, e.g., Cost considerations]
- [Driver 4, e.g., Time constraints]

## Considered Options

### Option 1: [Name]
**Description**: [Brief description]
**Pros**:
- [Pro 1]
- [Pro 2]
**Cons**:
- [Con 1]
- [Con 2]
**Estimated effort**: [S/M/L/XL]

### Option 2: [Name]
**Description**: [Brief description]
**Pros**:
- [Pro 1]
- [Pro 2]
**Cons**:
- [Con 1]
- [Con 2]
**Estimated effort**: [S/M/L/XL]

### Option 3: [Name]
**Description**: [Brief description]
**Pros**:
- [Pro 1]
**Cons**:
- [Con 1]
**Estimated effort**: [S/M/L/XL]

## Decision Outcome

**Chosen option**: "[Option name]"

### Rationale
[Why this option was chosen - 2-3 sentences]

### Implementation Example
```elixir
# Code example if relevant
defmodule MyApp.Implementation do
  # Show the pattern or approach
end
```

## Consequences

### Positive
- [What becomes easier/better]
- [Performance improvements]
- [Developer experience gains]

### Negative
- [What becomes harder]
- [Technical debt incurred]
- [Complexity added]

### Neutral
- [Changes required]
- [New patterns to learn]
- [Dependencies added]

## Implementation Plan

1. [Step 1 with GitHub issue reference if applicable]
2. [Step 2]
3. [Step 3]

## Migration Strategy
[If replacing existing solution, how do we migrate?]

## Validation
How will we know this decision was correct?
- [ ] [Success metric 1]
- [ ] [Success metric 2]
- [ ] [Performance benchmark]

## Notes

### Research Links
- [Link to article/documentation]
- [Link to benchmark]
- [Link to similar implementation]

### Related ADRs
- [ADR-XXX] - [Related decision]
- Supersedes: [ADR-YYY] if applicable
- Superseded by: [ADR-ZZZ] if applicable

## Status Tracking
- [ ] Proposed (date)
- [ ] Reviewed (date)
- [ ] Accepted (date)
- [ ] Implemented (GitHub issue #)
```

## Stack-Specific Templates

### For Elixir/Phoenix Decisions:
Include additional sections on:
- **Phoenix Context Impact**: How this affects existing contexts
- **Ecto/Database Considerations**: Schema changes, migrations, performance
- **LiveView Implications**: Real-time updates, state management
- **OTP/Supervision Tree Changes**: Process architecture modifications

### For Nebula/Stellar/Pulsar:
Include additional sections on:
- **Component API Design**: Public interface changes
- **Backwards Compatibility**: Breaking changes and migration
- **Theme/Styling Impact**: Visual consistency considerations
- **Bundle Size Considerations**: Performance impact on package size

### For Simple Thai/Wug:
Include additional sections on:
- **NLP Processing Impact**: Language processing implications
- **Language/Locale Considerations**: Internationalization effects
- **Mobile vs Web Differences**: Platform-specific considerations

## GitHub Integration

### Document Creation:
1. Check existing ADRs in `/docs/adr/` to get next number
2. Create feature branch: `docs/adr-{###}-{title}`
3. Save as markdown file: `/docs/adr/ADR-{###}-{title}.md`
4. Use naming convention: 'ADR-{###}: [Title]' in the file header
5. Create GitHub issue linking to the ADR document
6. Create PR with just the ADR document for review
7. Link to related GitHub issues/milestones if provided

### ADR Numbering:
- Check existing ADRs in `/docs/adr/` to get next number
- Use format: ADR-001, ADR-002, etc. in filename and document header
- Maintain sequential numbering across all ADRs

## Follow-up Actions

### If Decision is Accepted:
- Suggest creating implementation issues in GitHub
- Offer to update related PRDs with the architectural decision
- Flag any documentation that needs updating
- Create follow-up tasks for validation metrics

### If Decision Needs Review:
- Set up review process with stakeholders
- Schedule decision deadline
- Identify who needs to approve

## Target Audience

Assume the primary readers are:
- **Current team members** who need to understand the decision
- **Future developers** who will inherit the codebase
- **Technical leads** reviewing architectural consistency

Keep technical but accessible - junior developers should understand the reasoning and implications.

## Final Instructions

1. **Always start** by understanding the problem context and decision drivers
2. **Research thoroughly** if alternatives aren't well-defined
3. **Focus on the 'why'** not just the 'what'
4. **Include specific examples** relevant to our Elixir/Phoenix stack
5. **Reference GitHub issues** when applicable
6. **Consider long-term implications** and maintenance burden
7. **Make decisions traceable** with clear rationale
8. **Create as GitHub document** with proper team organization
9. **Suggest follow-up actions** for implementation and validation

**Important Notes:**
- ADRs are immutable once accepted - create new ones to supersede
- Focus on architectural significance - not every technical choice needs an ADR
- Include code examples for Elixir/Phoenix patterns where relevant
- Consider the decision's impact on team velocity and technical debt
- Link related GitHub issues and suggest creating implementation tasks

$ARGUMENTS