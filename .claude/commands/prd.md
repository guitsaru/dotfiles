---
name: prd
description: Create a Prododuct Requirements Document (PRD) collaboratively with the user, focusing on requirements and architecture
interactive_mode: true

Examples:
- <example>
  Context: User wants to create a PRD for a GitHub issue
  user: "Create a PRD for issue #127"
  assistant: "Let's draft a PRD for issue #127. I'll outline the requirements and get your input on architecture and design."
  <commentary>collaboratively creating a PRD with the User</commentary>
</example>
- <example>
  Context: User wants to create a PRD for a feature without a GitHub issue
  user: "Create a PRD for adding real-time notifications to the app"
  assistant: "Let's draft a PRD for the real-time notifications feature. I'll outline the requirements and get your input on architecture and design."
  <commentary>collaboratively creating a PRD with the User</commentary>
</example>
---

# Rule: Generating a Product Requirements Document (PRD)

## Goal

To guide an AI assistant in creating a detailed Product Requirements Document (PRD) in Markdown format, based on an initial user prompt. The PRD should be clear, actionable, and suitable for a junior developer to understand and implement the feature.

## Process

1. **Receive Initial Prompt:** The user provides a brief description or request for a new feature or functionality.
2. **Ask Clarifying Questions:** Before writing the PRD, the AI *must* ask clarifying questions to gather sufficient detail. The goal is to understand the "what" and "why" of the feature, not necessarily the "how" (which the developer will figure out). Make sure to provide options in letter/number lists so I can respond easily with my selections.
3. **Generate PRD:** Based on the initial prompt and the user's answers to the clarifying questions, generate a PRD using the structure outlined below.
4. **Create GitHub Issue and Document:** Create a PRD markdown file in `/docs/prd/PRD-{###}-{feature-title}.md` on a new branch, then create a GitHub issue linking to the PRD document.

## Clarifying Questions (Examples)

The AI should adapt its questions based on the prompt, but here are some common areas to explore:

* **GitHub Hierarchy:** "Is this a new milestone/epic or part of an existing milestone?" and "If part of existing milestone, what's the parent milestone or issue number?"
* **Product Context:** For Nebula team: "Which product (Nebula/Stellar/Pulsar)?" For Simple Languages: "Which product (Simple Thai Web/Mobile/Wug)?"
* **Problem/Goal:** "What problem does this feature solve for the user?" or "What is the main goal we want to achieve with this feature?"
* **Target User:** "Who is the primary user of this feature?"
* **Core Functionality:** "Can you describe the key actions a user should be able to perform with this feature?"
* **User Stories:** "Could you provide a few user stories? (e.g., As a [type of user], I want to [perform an action] so that [benefit].)"
* **Acceptance Criteria:** "How will we know when this feature is successfully implemented? What are the key success criteria?"
* **Scope/Boundaries:** "Are there any specific things this feature *should not* do (non-goals)?"
* **Data Requirements:** "What kind of data does this feature need to display or manipulate?"
* **Design/UI:** "Are there any existing design mockups or UI guidelines to follow?" or "Can you describe the desired look and feel?"
* **Edge Cases:** "Are there any potential edge cases or error conditions we should consider?"
* **Technical Decisions:** "Are there any technical decisions that need research? (These would become ADRs)"

## PRD Structure

The generated PRD should include the following sections:

1. **Introduction/Overview:** Briefly describe the feature and the problem it solves. State the goal.
2. **GitHub Hierarchy Context:** Ask the user to specify whether this is:
   - A Milestone/Epic level PRD (GitHub milestone with related issues)
   - A Feature level PRD (main issue that may have sub-issues)
   - A Task level PRD (standalone or sub-issue of existing feature)
   - Note: Milestones/Epics will have GitHub issues created for implementation
3. **Goals:** List the specific, measurable objectives for this feature.
4. **User Stories:** Detail the user narratives describing feature usage and benefits.
5. **Functional Requirements:** List the specific functionalities the feature must have. Use clear, concise language (e.g., "The system must allow users to upload a profile picture."). Number these requirements.
6. **Non-Goals (Out of Scope):** Clearly state what this feature will *not* include to manage scope.
7. **Design Considerations (Optional):** Link to mockups, describe UI/UX requirements, or mention relevant components/styles if applicable.
8. **Technical Considerations:** Stack-specific considerations:
   - Which Phoenix context will this belong to?
   - LiveView vs regular controller approach?
   - Database considerations (Ecto schemas needed)?
   - Any architectural decisions needed? (These will become ADR documents in `/docs/adr/`)
9. **Success Metrics:** How will the success of this feature be measured? (e.g., "Increase user engagement by 10%", "Reduce support tickets related to X").
10. **Implementation Breakdown:** 
    - For Milestone/Epic PRDs: List of features that will become GitHub issues
    - For Feature PRDs: List of sub-tasks that will become GitHub sub-issues
    - For Task PRDs: Checklist of implementation steps
    - Example format:
    ```
    ## Implementation Breakdown
    - [ ] Design database schema (GitHub issue #X)
    - [ ] Create Phoenix context (GitHub sub-issue)
    - [ ] Build LiveView UI (GitHub sub-issue)
    - [ ] Add tests (GitHub sub-issue)
    - [ ] Update documentation
    ```
11. **Related Documents:** 
    - Note: ADRs will be created as markdown files in `/docs/adr/` with PR workflow
    - Related ADR documents needed (will be created separately)
    - Links to existing design documents
    - Links to related PRDs
    - Example:
    ```
    ## Related Documents
    - ADR needed: Audit log storage strategy → `/docs/adr/ADR-{###}-audit-log-storage.md`
    - ADR needed: Retention policy approach → `/docs/adr/ADR-{###}-retention-policy.md`
    - Related PRD: [Authentication System](/docs/prd/PRD-001-authentication-system.md)
    ```
12. **Open Questions:** List any remaining questions or areas needing further clarification.

## Target Audience

Assume the primary reader of the PRD is a **junior developer**. Therefore, requirements should be explicit, unambiguous, and avoid jargon where possible. Provide enough detail for them to understand the feature's purpose and core logic.

## Output

### GitHub Issue + Markdown Document (Default for PRDs)
* **Format:** Markdown file in `/docs/prd/PRD-{###}-{feature-title}.md` + GitHub issue
* **Process:** 
  1. Create feature branch: `docs/prd-{feature-title}`
  2. Create PRD markdown file with full content
  3. Create GitHub issue with summary and link to PRD document
  4. Create PR with just the PRD document for review
* **Benefits:** Version controlled, reviewable, searchable, links to GitHub workflow
* **Hierarchy:**
  - **Milestone PRDs:** Create GitHub milestone + issue linking to PRD
  - **Feature PRDs:** Create GitHub issue that can have sub-issues
  - **Task PRDs:** Can be GitHub sub-issues of parent features
* **Parent Linking:** For task PRDs, ask if this should be a sub-issue of an existing parent

## Final instructions

1. Do NOT start implementing the PRD
2. Make sure to ask the user clarifying questions
3. Take the user's answers to the clarifying questions and improve the PRD
4. After generating the PRD content:
   - Create feature branch: `docs/prd-{feature-title}`
   - Check existing PRDs to get next number (PRD-001, PRD-002, etc.)
   - Save PRD to `/docs/prd/PRD-{###}-{feature-title}.md`
   - Create GitHub issue with summary and link to PRD
   - Create PR for document review
5. GitHub Issue creation logic:
   - Set issue type (Milestone/Feature/Task) based on user's answers
   - If it's a sub-task, create as sub-issue using GitHub's sub-issue API
   - Add appropriate labels (e.g., 'documentation', 'prd', 'epic', 'feature')
   - Link to the PRD document in `/docs/prd/`
   - If milestone-level, create GitHub milestone

**Note:** Any architectural decisions identified should be documented as ADRs in `/docs/adr/ADR-{###}-{title}.md` with PR workflow
