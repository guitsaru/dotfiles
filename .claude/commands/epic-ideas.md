---
name: epic-ideas
description: Brainstorm and develop strategic epic/feature ideas based on product context, user needs, and business goals
interactive_mode: true

Examples:
- <example>
  Context: User wants strategic epics for their SaaS product
  user: "Brainstorm epic ideas for Nebula"
  assistant: "I'll help brainstorm strategic epics for Nebula. First, let me understand your current context and challenges, then we'll use multiple frameworks to generate ideas..."
  <commentary>Strategic brainstorming for SaaS product using multiple frameworks</commentary>
</example>
- <example>
  Context: User has specific retention challenge
  user: "I need ideas to improve user retention in Simple Thai"
  assistant: "Let's brainstorm retention-focused epics for Simple Thai. What's your current retention rate and where do users typically drop off? I'll analyze the user journey..."
  <commentary>Targeted brainstorming for specific business challenge</commentary>
</example>
- <example>
  Context: User wants to explore new product possibilities
  user: "Blue sky ideas for expanding our component library"
  assistant: "I'll help explore visionary expansion ideas for your component library. Let's think about adjacent markets and transformative possibilities..."
  <commentary>Visionary brainstorming for product expansion</commentary>
</example>
---

# Rule: Brainstorming Strategic Epic Ideas

## Goal

Generate strategic epic ideas that align with product vision, solve real user problems, and advance the product roadmap. Help solo founders think beyond immediate features to strategic initiatives.

## Process

1. **Context Gathering**: Understand product, stage, audience, and challenges
2. **Brainstorming Frameworks**: Use multiple approaches to generate diverse ideas
3. **Epic Development**: Structure ideas with business value and technical considerations
4. **Prioritization**: Score and rank ideas strategically
5. **Integration Options**: Create Linear epics, PRDs, or research spikes

## Context Gathering

First, understand the product context through targeted questions:

### Product Questions:
* **Product Focus**: "Which product? a) Nebula, b) Stellar, c) Pulsar, d) Simple Thai, e) Wug, f) New product"
* **Stage**: "Current stage? a) Pre-launch, b) MVP, c) Growth, d) Mature"
* **Target Audience**: "Target audience? (developers, language learners, etc.)"
* **User Base**: "Current user count? (if applicable)"

### Strategic Context:
* **Main Challenge**: "What's your current main challenge? a) User acquisition b) User retention c) Revenue generation d) Technical debt e) Feature parity with competitors f) Performance/scale g) User experience"
* **Time Horizon**: "Time horizon for new epics? a) Next month (urgent) b) This quarter (soon) c) Next quarter (planned) d) This year (strategic) e) Blue sky (vision)"

### Analysis Request:
* **Existing Data**: "Should I analyze existing Linear issues to identify patterns?"
* **Competitive Research**: "Any competitor features to consider?"
* **User Feedback**: "Recent user feedback to incorporate?"
* **Technical Constraints**: "Technical constraints to consider?"

## Brainstorming Frameworks

Use multiple frameworks to generate diverse, strategic ideas:

### A. Jobs-to-be-Done Analysis
```
What job are users hiring your product to do?
- Primary job: [Main purpose users have]
- Related jobs: [Adjacent needs they have]
- Emotional jobs: [How they want to feel]

Epic ideas that better accomplish these jobs:
1. [Epic that makes primary job easier]
2. [Epic that handles related job]
3. [Epic that addresses emotional need]
```

### B. Problem-Solution Matrix
| User Problem | Current Solution | Proposed Epic |
|--------------|-----------------|---------------|
| [Pain point] | [How they cope] | [Epic idea]   |

### C. Value Chain Analysis
```
User Journey: Discover → Try → Learn → Use → Succeed → Share
Where are the gaps? What epics would fill them?
```

### D. Platform Expansion
```
Current: [What you have]
Adjacent: [Natural extensions]
Transform: [New possibilities]
```

### E. Competitive Gap Analysis
```
What do competitors do that you don't?
What do you do that competitors don't?
What does nobody do well?
```

## Epic Generation Template

For each brainstormed idea, generate:

```markdown
## Epic Idea: [Name]

### Elevator Pitch
[1-2 sentences that would excite users]

### Problem Statement
**User Problem**: [What frustration/need does this address?]
**Current Alternative**: [How do users handle this today?]
**Why Now**: [What makes this timely?]

### Solution Overview
[High-level description of the epic]

### Key Features
1. [Core feature 1]
2. [Core feature 2]  
3. [Core feature 3]

### User Value
- **Immediate value**: [What users get right away]
- **Long-term value**: [What this enables over time]
- **Differentiator**: [Why this is unique]

### Business Value
- **Revenue impact**: [Direct, indirect, or retention]
- **Strategic value**: [Market position, moat, etc.]
- **Effort estimate**: [S/M/L/XL]
- **Risk level**: [Low/Medium/High]

### Success Metrics
- [Metric 1]: Target value
- [Metric 2]: Target value
- [Metric 3]: Target value

### Technical Considerations
- **Architecture impact**: [Major/Minor/None]
- **New dependencies**: [What's needed]
- **Performance impact**: [Positive/Neutral/Negative]
- **Technical debt addressed**: [If any]

### Implementation Phases
1. **Phase 1 (MVP)**: [Minimal valuable version]
2. **Phase 2 (Enhanced)**: [Added value]
3. **Phase 3 (Complete)**: [Full vision]

### Open Questions
- [Question 1]
- [Question 2]

### Similar/Competing Features
- [Competitor X does Y]
- [Alternative approach Z]

### Priority Score
- **User Impact**: [1-5]
- **Business Value**: [1-5]
- **Technical Fit**: [1-5]
- **Effort Required**: [1-5, lower is better]
- **Total**: [Sum or weighted score]
```

## Output: Epic Ideas Report

```markdown
# Epic Ideas Brainstorm: [Product Name]

**Date**: [Date]
**Context**: [Current challenge/goal]
**Time Horizon**: [When these could be built]

## Executive Summary
[2-3 sentences on the strategic themes identified]

## Top 5 Epic Ideas (Prioritized)

### 1. 🏆 [Highest Priority Epic]
[Idea details from template above]

### 2. 🥈 [Second Priority Epic]
[Idea details]

### 3. 🥉 [Third Priority Epic]
[Idea details]

### Additional Ideas (Not Detailed)
4. [Epic name] - [One line description]
5. [Epic name] - [One line description]
6. [Epic name] - [One line description]

## Strategic Themes Identified

### Theme 1: [e.g., User Activation]
Epics 1, 3, and 5 all address getting users to value faster

### Theme 2: [e.g., Platform Maturity]
Epics 2 and 4 add enterprise-ready features

## Quick Wins vs Strategic Investments

### Quick Wins (< 1 month)
- [Small epic that delivers value fast]

### Strategic Investments (> 3 months)
- [Large epic with long-term value]

## Recommendation

**Start with**: [Epic name] because [reasoning]

This addresses [main challenge] while setting up for [future opportunity].

## Next Steps
1. [ ] Create PRD for top priority epic
2. [ ] Validate assumptions with users
3. [ ] Technical spike on unknowns
4. [ ] Create Linear epic issue
```

## Product-Specific Brainstorming

### For Nebula (SaaS Starter Kit)
Focus on:
- What every SaaS needs but is painful to build
- Common patterns worth abstracting
- Developer experience improvements
- Production-ready features

**Example epic themes**:
- Multi-tenant architecture system
- Subscription billing & invoicing
- Admin dashboard framework
- API rate limiting & analytics
- Audit logging & compliance
- User onboarding automation
- Feature flag management
- Background job monitoring

### For Stellar/Pulsar (Component Libraries)
Focus on:
- Missing components developers need
- Accessibility improvements  
- Performance optimizations
- Developer experience enhancements

**Example epic themes**:
- Data table ecosystem (filtering, sorting, export)
- Form builder system with validation
- Accessibility audit & testing tools
- Theme customization system
- Animation & transition library
- Mobile-first responsive components
- Developer tooling & documentation

### For Simple Thai (Language Learning)
Focus on:
- Learning outcomes & effectiveness
- Engagement & motivation features
- Content expansion & variety
- Social & community features

**Example epic themes**:
- Comprehensible input reader
- Speech recognition & pronunciation
- Progress analytics & insights
- Community features & social learning
- Spaced repetition system
- Content personalization
- Gamification & achievements

### For Wug (NLP Library)
Focus on:
- Language processing capabilities
- Performance improvements
- Developer tools & documentation
- Language expansion

**Example epic themes**:
- Sentiment analysis toolkit
- Text difficulty scoring
- Language detection & classification
- Advanced tokenization
- Named entity recognition
- Performance benchmarking tools
- Multi-language support expansion

## Strategic Thinking Prompts

### Solo Founder Considerations:
- **Moat Building**: What creates sustainable competitive advantage?
- **Platform Effects**: What creates network effects or ecosystem value?
- **Adjacent Opportunities**: What related markets could you enter?
- **Workflow Integration**: How does this fit users' broader workflow?
- **Scaling Challenges**: What will break at 10x users?

### Business Model Alignment:
- **Revenue Generation**: How does this create or protect revenue?
- **Market Expansion**: Does this open new customer segments?
- **Customer Lifecycle**: Where does this improve acquisition/retention/expansion?
- **Operational Efficiency**: How does this reduce your operational burden?

## Output Options

Ask user where to save the Epic Ideas report:

### Option A: Project Document (Recommended for strategic planning)
- Save within relevant project as planning document
- Title: 'Epic Ideas: [Product/Initiative] - [Date]'
- Benefits: Strategic reference, not tied to specific trackable work
- Use Linear MCP to create within project

### Option B: Linear Issue (For immediate epic selection)
- Create issue to track epic selection and planning process
- Include brainstorm results in description
- Benefits: Trackable process, can have sub-issues for research/validation

## Integration Options

After brainstorming, offer to:

### 1. Create Linear Epic
- Convert top idea to epic issue
- Add to product backlog with priority
- Link to strategic goals

### 2. Generate PRD
- Create detailed Product Requirements Document
- Use the PRD command for selected epic
- Can be child of the created epic

### 3. Research Spike
- Create research issues for validation
- User interview questions
- Technical feasibility exploration

## Final Instructions

1. **Start with deep context gathering** - understand the strategic situation
2. **Use multiple brainstorming frameworks** - don't rely on just one approach  
3. **Think strategically, not tactically** - focus on epics that advance the business
4. **Consider the full user journey** - from discovery to advocacy
5. **Balance quick wins and strategic investments**
6. **Score ideas objectively** using the priority matrix
7. **Provide actionable next steps** for the top ideas
8. **Offer integration options** to move from ideas to execution
9. **Think like a product strategist** - consider market position, competition, moats
10. **Help founders see beyond immediate needs** to future possibilities

**Key Principles**:
- Strategic thinking over tactical features
- User value aligned with business value
- Consider technical feasibility early
- Build on existing strengths
- Create sustainable competitive advantages
- Focus on measurable outcomes
- Balance innovation with execution capability