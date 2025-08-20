# Branch Command

This command prepares a feature branch and draft PR for implementation work.

## Workflow

1. **Branch Preparation**: Update main branch and create a new feature branch
2. **Draft PR Creation**: Create a draft pull request for the implementation work

## Usage

Use this command when:
- You're ready to start implementation after planning
- The automatic hooks didn't trigger properly
- You want to manually set up the branch and PR workflow

## Implementation

When this command is invoked, Claude will:

1. Use the `branch-prep` agent to:
   - Fetch latest changes from origin
   - Switch to main branch
   - Pull latest main
   - Create a new feature branch based on the current work context
   - Push the new branch to origin

2. Use the `pr-draft` agent to:
   - Create a draft pull request
   - Set appropriate title and description based on the work context
   - Link to any relevant issues
   - Add work-in-progress labels

## Agent Settings

The command uses the configured agent settings from `settings.json`:

- `branch_prep`: Creates feature branches with automatic prefixes and pushes
- `pr_draft`: Creates draft PRs with checklists and appropriate labels

## Fallback

If the agents are not available or fail, Claude will fall back to manual Git commands to achieve the same workflow.