---
name: product-brief
description: Create a Product Brief document for new products or major product versions, focusing on strategic vision and market positioning
interactive_mode: true

Examples:
- <example>
  Context: User wants to create a product brief for a new SaaS tool
  user: "Create a product brief for Nebula Cloud"
  assistant: "Let me first analyze the current project to understand the context, then I'll gather strategic information to create a comprehensive Product Brief for Nebula Cloud."
  <commentary>Analyzing project context first, then creating strategic product brief</commentary>
</example>
- <example>
  Context: User wants to create a brief for a language learning product
  user: "Product brief for Simple Korean app"
  assistant: "I'll analyze the project structure and existing products first, then help create a strategic Product Brief for Simple Korean that aligns with your product ecosystem."
  <commentary>Understanding existing context before creating product brief</commentary>
</example>
---

# Rule: Generating a Product Brief Document

## Goal

To guide an AI assistant in creating a high-level Product Brief document that defines the vision, target market, and strategic goals for a new product or major product update. This is a strategic document that sits above PRDs and features.

## Process

1. **Analyze Project Context:** First examine the current project/codebase to understand:
   - Existing products and their architecture
   - Current tech stack and infrastructure
   - Team structure and product lines
   - Existing documentation patterns
2. **Receive Initial Input:** User provides product name or idea
3. **Ask Strategic Questions:** Gather information about market, users, and business goals (informed by project context)
4. **Generate Product Brief:** Create comprehensive brief using the structure below
5. **Create Linear Document:** Save as a Linear Document under the appropriate team

## Initial Context Analysis

Before asking strategic questions, use available tools to understand:

* **Project Structure:** Examine files to understand current products and architecture
* **Tech Stack:** Identify technologies, frameworks, and infrastructure in use
* **Documentation:** Look for existing product briefs, PRDs, or strategic documents
* **Team Organization:** Understand product lines (Nebula tools vs Simple Languages)
* **Integration Points:** Identify how new product might connect to existing systems

## Clarifying Questions to Ask

The AI should adapt its questions based on the input and project context, but here are the key strategic areas to explore:

### Product Definition:
* **Product Description:** "What is the product? (One sentence description)"
* **Product Type:** "Is this a new product or major update to existing product?"
* **Team Context:** "Which team/product line? (Nebula tools or Simple Languages)" [if not clear from context]
* **Relationship:** "How does this relate to existing products in your ecosystem?"

### Market & Users:
* **Target Audience:** "Who is the primary target audience?"
* **Problem Statement:** "What problem does this solve for them?"
* **Competitive Landscape:** "Who are the main competitors or alternatives?"
* **Value Proposition:** "What's our unique value proposition?"

### Business Model:
* **Revenue Model:** "How will this generate revenue? Options: a) SaaS subscription, b) One-time purchase, c) Freemium, d) Open source with paid tiers, e) Other"
* **Pricing Strategy:** "What's the pricing strategy?"
* **Launch Timeline:** "Expected launch timeline? Options: a) Q1, b) Q2, c) Q3, d) Q4, e) Next year"

### Success Metrics:
* **Success Definition:** "What does success look like in 6 months?"
* **Key Metrics:** "Key metrics to track? (users, revenue, engagement, etc.)"

### Technical Approach (Context-Informed):
* **Infrastructure:** "Will this be built on existing infrastructure or separate?" [reference current stack]
* **Technical Risks:** "Any major technical risks or dependencies?" [consider current architecture]
* **Integration:** "How should this integrate with existing products?" [based on current ecosystem]

## Product Brief Structure

The generated Product Brief should include the following sections:

```markdown
# Product Brief: [Product Name]

**Created**: [Date]
**Status**: Draft | In Review | Approved | In Development | Launched
**Team**: [Nebula/Simple Languages]
**Product Line**: [e.g., Developer Tools, Language Learning]

## Executive Summary
[2-3 sentences capturing the essence of the product]

## Problem Statement
### The Problem
[What problem exists in the market?]

### Current Solutions
[How do people solve this today?]

### Why Now
[Why is this the right time for this product?]

## Solution Overview
### Product Vision
[What we're building and why it's better]

### Key Features
- Feature 1: [Brief description]
- Feature 2: [Brief description]
- Feature 3: [Brief description]

### Non-Goals
[What we're explicitly NOT building]

## Target Market
### Primary Audience
- **Who**: [Specific user segment]
- **Size**: [Market size if known]
- **Characteristics**: [Key traits]

### User Personas
[2-3 brief personas if applicable]

### Use Cases
1. [Primary use case]
2. [Secondary use case]

## Business Model
### Revenue Model
[How we make money]

### Pricing Strategy
[Pricing tiers and rationale]

### Go-to-Market Strategy
[How we'll launch and grow]

## Success Metrics
### 3-Month Goals
- [ ] Metric 1
- [ ] Metric 2

### 6-Month Goals
- [ ] Metric 1
- [ ] Metric 2

### 1-Year Vision
[Where we want to be]

## Product Roadmap
### Phase 1: MVP (Timeline)
- Core features list

### Phase 2: Enhancement (Timeline)
- Additional features

### Phase 3: Scale (Timeline)
- Growth features

## Technical Architecture
### Tech Stack
[Key technologies to use - informed by existing infrastructure]

### Infrastructure Requirements
[What we need to build this - consider current setup]

### Integration Points
[How it connects to existing products - based on current ecosystem]

## Risks & Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk 1] | High/Medium/Low | [Strategy] |

## Resource Requirements
### Team
- Engineering: [Estimated effort]
- Design: [If applicable]
- Marketing: [If applicable]

### Budget
[Any significant costs]

### Timeline
[High-level timeline]

## Open Questions
- [ ] Question 1
- [ ] Question 2

## Related Documents
- Link to PRDs (once created)
- Link to ADRs (once created)
- Link to design documents
- Links to related existing products

## Approval
- [ ] Product Owner
- [ ] Technical Lead
- [ ] Stakeholders
```

## Target Audience

This document is strategic, not technical, and should be readable by non-technical stakeholders including executives, marketing, and business development teams. Keep it concise - aim for 2-3 pages maximum.

## Output Instructions

Ask user where to save the Product Brief:

### Option A: Standalone Linear Document (Recommended)
* **Format:** Linear Document (not an issue)
* **Location:** Team > Documents > Product Briefs (or root documents)
* **Process:** Use Linear MCP tools to create standalone document
* **Benefits:** Easy to reference, update, and share across multiple projects
* **Visibility:** Set appropriate team visibility
* **Return:** Link to the created document

### Option B: Linear Project Integration
* **Format:** Product Brief content integrated with Linear Project
* **Process:** 
  1. Ask which Linear Project this relates to
  2. Add Product Brief content to the project description
  3. Optionally create a project document within the project
* **Benefits:** Directly connected to project tracking and issues
* **Return:** Link to the updated project

### Option C: Both (Comprehensive)
* Create standalone document for reference and sharing
* Link the document to the relevant Linear Project
* Update project description with executive summary
* Best for strategic products that need both visibility and project tracking

## Examples for Each Product Line

### Nebula Example:
* **Product:** 'Nebula Cloud - Hosted version of Nebula'
* **Audience:** 'Developers who want SaaS benefits without self-hosting'
* **Model:** 'Monthly subscription with usage-based pricing'

### Simple Languages Example:
* **Product:** 'Simple Spanish - Spanish learning app'
* **Audience:** 'English speakers learning Spanish'
* **Model:** 'Freemium with premium content subscription'

## Final Instructions

1. **ALWAYS** start by analyzing the project context using available tools
2. Ask strategic clarifying questions informed by the project analysis
3. Focus on the "what" and "why" rather than the "how"
4. Reference existing architecture and products in technical considerations
5. Generate a comprehensive but focused brief (2-3 pages maximum)
6. **Ask user for save preference** (standalone document, project integration, or both)
7. Use Linear MCP tools accordingly:
   - For standalone: Create document in Team > Documents
   - For project integration: Update project description and/or create project document
   - For both: Create document and link to project
8. Ask which team/project to use if not clear from context
9. Set appropriate visibility and return relevant links

**Note:** This document is created before PRDs and features. It should be updated quarterly or at major milestones and serves as the strategic foundation for all subsequent product development work. The initial project analysis ensures the brief aligns with existing infrastructure and product ecosystem.