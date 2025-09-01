---
description: Break down GitHub milestones into actionable issues and sub-issues with dependency planning
---

# Epic Breakdown

Break down milestones/epics into GitHub issues and sub-issues, creating logical task hierarchies with dependency management and incremental value delivery.

## Process

1. **Understand the Epic**: Analyze the milestone/epic scope and requirements
2. **Create Logical Breakdown**: Organize work into coherent features and tasks
3. **Plan Dependencies**: Identify blocking relationships and sequencing
4. **Generate GitHub Issues**: Create issues with proper hierarchy and linking
5. **Sequence for Value**: Plan delivery to minimize blocking and maximize incremental value

## Input Sources

### GitHub Milestone
```bash
# Fetch milestone details
gh api repos/:owner/:repo/milestones/:milestone_number

# Get associated issues
gh issue list --milestone "milestone-name"
```

### Epic Description/Requirements
- Product requirements or feature specifications  
- User stories and acceptance criteria
- Technical constraints and dependencies

### Existing Codebase Context
- Review current architecture and patterns
- Identify affected systems and contexts
- Consider migration and compatibility needs

## Breakdown Strategy

### 1. Feature-Level Decomposition

**Identify Major Features**:
- Group related functionality into coherent features
- Each feature should deliver standalone value
- Features should align with user workflows

**Example Epic**: "User Management System"
- Feature 1: User Registration & Authentication
- Feature 2: Profile Management  
- Feature 3: Role-Based Permissions
- Feature 4: User Activity Tracking

### 2. Task-Level Breakdown

**For Each Feature, Create Tasks**:
- Database/Schema design
- Backend context implementation
- Frontend UI components
- API endpoints
- Testing (unit, integration, E2E)
- Documentation updates

**Example Feature**: "User Registration"
- Task 1: Design user schema and migrations
- Task 2: Create Accounts context with registration logic
- Task 3: Build registration LiveView form
- Task 4: Add email verification flow
- Task 5: Write comprehensive tests
- Task 6: Update API documentation

### 3. Dependency Analysis

**Identify Dependencies**:
- **Hard dependencies**: Task A must complete before Task B
- **Soft dependencies**: Task B is easier after Task A
- **Parallel work**: Tasks that can be done simultaneously
- **Integration points**: Where features connect

**Dependency Types**:
- Database schema dependencies
- API contract dependencies  
- UI component dependencies
- Infrastructure dependencies

## GitHub Issue Structure

### Milestone (Epic Level)
```markdown
# Epic: User Management System

## Overview
Complete user management system with registration, profiles, and permissions.

## Success Criteria
- [ ] Users can register and authenticate
- [ ] Profile management with customization
- [ ] Role-based access control implemented
- [ ] Activity tracking for audit compliance

## Features
- #123 User Registration & Authentication  
- #124 Profile Management
- #125 Role-Based Permissions
- #126 User Activity Tracking

## Timeline
Target: Q2 2024
Dependencies: Database migration (#120) must complete first
```

### Feature Issue
```markdown
# Feature: User Registration & Authentication

## User Stories
- As a new user, I want to register an account so I can access the platform
- As a user, I want to authenticate securely so my data is protected
- As an admin, I want email verification so we have valid contact info

## Acceptance Criteria
- [ ] Registration form with validation
- [ ] Email verification flow
- [ ] Secure password requirements  
- [ ] Login/logout functionality
- [ ] Password reset capability

## Implementation Tasks
- #127 Design user schema and migrations
- #128 Create Accounts context
- #129 Build registration LiveView
- #130 Add email verification
- #131 Implement authentication logic
- #132 Add comprehensive tests

## Dependencies
- Depends on: Database setup (#120)
- Blocks: Profile Management (#124)

## Definition of Done
- [ ] All tests passing
- [ ] Code review completed
- [ ] Documentation updated
- [ ] Deployed to staging
```

### Task Issue  
```markdown
# Task: Design user schema and migrations

## Description
Create Ecto schema for users and corresponding database migrations.

## Requirements
- User fields: email, password_hash, name, verified_at, inserted_at, updated_at
- Unique constraint on email
- Proper indexing for performance
- Migration follows Phoenix conventions

## Implementation Checklist
- [ ] Create User schema in `lib/app/accounts/user.ex`
- [ ] Add changeset with validations
- [ ] Create migration file  
- [ ] Add appropriate database indexes
- [ ] Test schema validations
- [ ] Update context for schema usage

## Acceptance Criteria
- [ ] Schema compiles without warnings
- [ ] All validations work correctly
- [ ] Migration runs successfully
- [ ] Rollback works properly

## Estimated Effort
2-3 hours

## Dependencies  
None - can start immediately
```

## Breakdown Templates

### Phoenix/Elixir Epic Template
```markdown
## Database Layer
- [ ] Schema design and migrations
- [ ] Ecto relationships and constraints
- [ ] Database indexes and performance

## Context Layer  
- [ ] Phoenix context modules
- [ ] Business logic functions
- [ ] Data validation and changesets

## Web Layer
- [ ] LiveView components
- [ ] Controllers and routes
- [ ] Templates and UI helpers

## Testing Layer
- [ ] Unit tests for contexts
- [ ] Integration tests for web layer
- [ ] End-to-end user flows

## Infrastructure
- [ ] Configuration updates
- [ ] Environment variables
- [ ] Deployment considerations
```

### Frontend Feature Template
```markdown
## Component Development
- [ ] Base component structure
- [ ] Props and state management
- [ ] Event handling logic
- [ ] Responsive design

## Integration
- [ ] API integration
- [ ] Error handling
- [ ] Loading states
- [ ] Data validation

## User Experience
- [ ] Accessibility compliance
- [ ] Performance optimization  
- [ ] Cross-browser testing
- [ ] Mobile responsiveness

## Testing
- [ ] Unit tests for components
- [ ] Integration tests
- [ ] E2E user flows
- [ ] Visual regression tests
```

## Dependency Management

### Dependency Mapping
```markdown
## Critical Path Analysis

**Phase 1 - Foundation** (Week 1-2)
- Database schema → Context creation → Basic CRUD

**Phase 2 - Core Features** (Week 3-4)  
- Authentication → Profile management → UI components

**Phase 3 - Advanced Features** (Week 5-6)
- Permissions → Activity tracking → Admin features

**Phase 4 - Polish** (Week 7-8)
- Testing → Documentation → Deployment
```

### Parallel Work Streams
```markdown
## Concurrent Development

**Backend Stream**:
- Database design
- Context implementation  
- API endpoints

**Frontend Stream**:
- Component library
- UI layouts
- Styling system

**DevOps Stream**:
- Environment setup
- CI/CD pipeline
- Monitoring setup
```

## Value Delivery Planning

### Incremental Milestones
```markdown
## Release Planning

**MVP (Minimum Viable Product)**:
- Basic user registration
- Simple authentication
- Core profile fields
- **Value**: Users can create accounts and log in

**Version 1.1**:
- Email verification
- Password reset
- Profile customization
- **Value**: Complete registration experience

**Version 1.2**:
- Role-based permissions
- Admin management
- Activity logging
- **Value**: Enterprise-ready user management
```

### Risk Mitigation
```markdown
## Risk Management

**Technical Risks**:
- Database performance with user growth
- Authentication security requirements
- Third-party integration dependencies

**Delivery Risks**:
- Complex features blocking simple ones
- Integration testing bottlenecks
- Deployment complexity

**Mitigation Strategies**:
- Prototype high-risk components early
- Create integration test environments
- Plan rollback procedures
```

## GitHub API Integration

### Create Issues with Dependencies
```bash
# Create epic milestone
gh api repos/:owner/:repo/milestones -f title="User Management System" -f description="Complete user management with auth and profiles"

# Create feature issue
gh issue create --title "User Registration & Authentication" --body-file feature-template.md --milestone "User Management System" --label "feature,backend"

# Create sub-issues
gh issue create --title "Design user schema" --body-file task-template.md --label "database,backend" 

# Link dependencies (if supported)
gh issue edit 127 --add-label "depends-on-120"
```

### Issue Hierarchy Management
```bash
# List milestone issues
gh issue list --milestone "User Management System" --state all

# Track completion
gh issue list --milestone "User Management System" --state closed

# Update milestone progress  
gh api repos/:owner/:repo/milestones/:id -f state="open" -f description="Updated progress: 3/8 issues complete"
```

## Final Instructions

1. **Start with user value**: Break down by user-facing value, not technical layers
2. **Minimize dependencies**: Reduce blocking relationships where possible  
3. **Plan for parallel work**: Enable multiple developers to work simultaneously
4. **Consider testing strategy**: Plan testing at each level (unit, integration, E2E)
5. **Document decisions**: Capture architectural choices that need ADRs
6. **Sequence thoughtfully**: Front-load risky or blocking work
7. **Plan incremental delivery**: Each phase should provide usable value
8. **Create proper hierarchy**: Use GitHub milestones, issues, and sub-issues appropriately
9. **Estimate realistically**: Include time for testing, review, and deployment
10. **Plan for maintenance**: Consider ongoing support and iteration needs

**Epic breakdown should enable teams to:**
- Start work immediately with clear, actionable tasks
- Work in parallel without blocking each other
- Deliver incremental value throughout development  
- Track progress and adjust scope as needed
- Maintain high code quality with proper testing

$ARGUMENTS