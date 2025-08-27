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
4. **Create Linear Issue:** Create a Linear issue with the PRD content, asking the user which team and project to use if not specified.

## Clarifying Questions (Examples)

The AI should adapt its questions based on the prompt, but here are some common areas to explore:

* **Linear Hierarchy:** "Is this a new feature/epic or part of an existing feature?" and "If part of existing feature, what's the parent issue number?"
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
2. **Linear Hierarchy Context:** Ask the user to specify whether this is:
   - A Feature/Epic level PRD (parent issue with sub-tasks)
   - A Task level PRD (standalone or sub-issue of existing epic)
   - Note: Features/Epics will have sub-issues created for implementation
3. **Goals:** List the specific, measurable objectives for this feature.
4. **User Stories:** Detail the user narratives describing feature usage and benefits.
5. **Functional Requirements:** List the specific functionalities the feature must have. Use clear, concise language (e.g., "The system must allow users to upload a profile picture."). Number these requirements.
6. **Non-Goals (Out of Scope):** Clearly state what this feature will *not* include to manage scope.
7. **Design Considerations (Optional):** Link to mockups, describe UI/UX requirements, or mention relevant components/styles if applicable.
8. **Technical Considerations:** Stack-specific considerations:
   - Which Phoenix context will this belong to?
   - LiveView vs regular controller approach?
   - Database considerations (Ecto schemas needed)?
   - Any Stellar/Pulsar components to use (if Nebula project)?
   - Are there any architectural decisions needed? (These will become ADR documents)
9. **Success Metrics:** How will the success of this feature be measured? (e.g., "Increase user engagement by 10%", "Reduce support tickets related to X").
10. **Implementation Breakdown:** 
    - For Feature/Epic PRDs: List of sub-tasks that will become sub-issues
    - For Task PRDs: Checklist of implementation steps
    - Example format:
    ```
    ## Implementation Breakdown
    - [ ] Design database schema
    - [ ] Create Phoenix context
    - [ ] Build LiveView UI
    - [ ] Add tests
    - [ ] Update documentation
    ```
11. **Related Documents:** 
    - Note: ADRs will be created as Linear Documents, not issues
    - Related ADR documents needed (will be created separately)
    - Links to existing design documents
    - Links to related PRDs
    - Example:
    ```
    ## Related Documents
    - ADR needed: Audit log storage strategy
    - ADR needed: Retention policy approach
    - Related PRD: [Link to Authentication PRD]
    ```
12. **Open Questions:** List any remaining questions or areas needing further clarification.

## Target Audience

Assume the primary reader of the PRD is a **junior developer**. Therefore, requirements should be explicit, unambiguous, and avoid jargon where possible. Provide enough detail for them to understand the feature's purpose and core logic.

## Output

### Linear Issue (Default for PRDs)
* **Format:** Linear Issue with PRD content in the description
* **Process:** Use Linear MCP tools to create the issue
* **Benefits:** Trackable, can have sub-issues, integrates with workflow
* **Hierarchy:**
  - **Epic PRDs:** Parent issues that can have sub-issues
  - **Task PRDs:** Can optionally be children of epic PRDs (use parentId)
* **Team/Project:** Ask user for team and project if not specified
* **Parent Linking:** For task PRDs, ask if this should be linked to an existing epic PRD

## Final instructions

1. Do NOT start implementing the PRD
2. Make sure to ask the user clarifying questions
3. Take the user's answers to the clarifying questions and improve the PRD
4. After generating the PRD content, ask which Linear team and project to create the issue in
5. Use the Linear MCP tools to create the issue with the PRD as the description
6. Linear Issue creation logic:
   - Set issue type (Epic vs Task) based on user's answers
   - If it's a sub-task, link it to the parent epic using parentId
   - Add appropriate labels based on product (e.g., 'product:nebula', 'feature:audit-logs', 'PRD')
   - Include a note that sub-issues can be created after the PRD is approved

**Note:** Any architectural decisions identified should be documented as ADRs in Linear Documents under Team > Documents > Architecture Decisions/
