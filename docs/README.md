# Documentation

This directory contains project documentation organized by type and date.

## Structure

- **`prd/`** - Product Requirements Documents
  - Format: `prd/PRD-{###}-{feature-title}.md`
  - Sequential numbering: PRD-001, PRD-002, etc.
  - Each PRD is created on a feature branch with a PR for review
  
- **`adr/`** - Architecture Decision Records
  - Format: `adr/ADR-{###}-{title}.md`
  - Sequential numbering: ADR-001, ADR-002, etc.
  - Each ADR is created on a feature branch with a PR for review
  
- **`epics/`** - Epic/Milestone Breakdowns
  - Format: `epics/EPIC-{###}-{feature-name}-breakdown.md`
  - Sequential numbering: EPIC-001, EPIC-002, etc.
  - Implementation plans and task breakdowns

## Workflow

1. Create documentation on a feature branch
2. Submit PR with just the documentation changes
3. Review and merge documentation before implementation
4. Reference docs in GitHub issues and milestones