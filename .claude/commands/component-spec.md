---
name: component-spec
description: Generate detailed specifications for Stellar (headless) or Pulsar (styled) LiveView components with API, behavior, and accessibility documentation
interactive_mode: true

Examples:
- <example>
  Context: User wants to spec a headless component
  user: "Create a spec for a command palette component for Stellar"
  assistant: "I'll help create a specification for a headless command palette component. Let me ask about the requirements and interactions needed..."
  <commentary>Creating headless component spec with focus on behavior and accessibility</commentary>
</example>
- <example>
  Context: User needs styled component with animations
  user: "We need a modal component for Pulsar with animations"
  assistant: "I'll design a styled modal component built on Stellar's headless modal. First, let's clarify the animation requirements and design system needs..."
  <commentary>Creating styled component spec with theme and animation considerations</commentary>
</example>
- <example>
  Context: User wants to enhance existing component
  user: "Improve the data table component in Stellar - add filtering"
  assistant: "I'll analyze the existing data table and create a spec for adding filtering capabilities. Let me review the current implementation first..."
  <commentary>Enhancing existing component with new features</commentary>
</example>
---

# Rule: Generating Component Specifications

## Goal

Create comprehensive component specifications for the Stellar/Pulsar component libraries, documenting API, behavior, accessibility, and implementation details for Phoenix LiveView components.

## Process

1. **Initial Input**: Accept component name, target library, or reference to existing component
2. **Clarifying Questions**: Gather requirements about functionality, interactions, and styling
3. **Research Phase**: Look for similar components and best practices if needed
4. **Generate Specification**: Create detailed documentation using template
5. **Save Options**: Offer Linear document, implementation issues, or project repository

## Initial Input

Accept:
- Component name (e.g., 'data table', 'modal', 'dropdown')
- Target library: Stellar (headless) or Pulsar (styled)
- Reference to existing component to enhance/fix
- Context about where it will be used

## Clarifying Questions

Ask the user (provide lettered options where appropriate):

### Component Type:
* **Library Target**: "Is this for: a) Stellar (headless), b) Pulsar (styled), c) Both?"
* **Category**: "Component category: a) Form input, b) Navigation, c) Data display, d) Overlay, e) Layout, f) Other?"
* **Relationship**: "Will this replace an existing component or is it new?"

### Functionality:
* **Primary Use Case**: "What's the primary use case?"
* **Interactions**: "Any specific interactions needed? (keyboard, mouse, touch)"
* **State Management**: "Does it need to manage state?"
* **LiveView Integration**: "Any real-time updates via LiveView?"

### Requirements Gathering:
* **Accessibility**: "Accessibility requirements? (ARIA, keyboard nav, screen reader)"
* **Responsive**: "Responsive behavior needed?"
* **Animations**: "Any animations or transitions?"
* **Form Integration**: "Integration with Phoenix forms?"

### For Pulsar (if styled):
* **Design System**: "Design system compliance needed?"
* **Theming**: "Theming support required?"
* **Dark Mode**: "Dark mode support?"
* **Tailwind Usage**: "Which Tailwind classes/components should it use?"

## Research Phase (if needed)

If user needs guidance or hasn't fully defined requirements:
- Look for similar components in Phoenix ecosystem
- Check HeadlessUI, Radix UI for patterns
- Review ARIA authoring practices
- Search for LiveView component examples
- Research performance considerations

## Component Specification Template

```markdown
# Component Specification: [ComponentName]

**Library**: Stellar | Pulsar
**Category**: [Form/Navigation/Data/Overlay/Layout]
**Status**: Draft | In Review | Approved | Implemented
**Linear Issue**: [LIN-XXX if applicable]
**Version**: 1.0.0

## Overview

### Purpose
[1-2 sentences describing what this component does]

### Use Cases
- [Primary use case]
- [Secondary use case]
- [Edge case to support]

## API Design

### Component Module
```elixir
defmodule Stellar.Components.DataTable do
  use Phoenix.Component
  import Stellar.Components.Utils
  
  @moduledoc \"\"\"
  A headless data table component with sorting, filtering, and pagination.
  \"\"\"
end
```

### Props/Assigns
```elixir
@doc \"\"\"
Renders a data table.

## Examples

    <.data_table
      id=\"users-table\"
      rows={@users}
      columns={[
        %{key: :name, label: \"Name\", sortable: true},
        %{key: :email, label: \"Email\"}
      ]}
    >
      <:action :let={user}>
        <.link navigate={~p\"/users/#{user.id}\"}>Edit</.link>
      </:action>
    </.data_table>
\"\"\"

attr :id, :string, required: true, doc: \"Unique identifier for the table\"
attr :rows, :list, required: true, doc: \"List of data rows to display\"
attr :columns, :list, required: true, doc: \"Column definitions\"
attr :selectable, :boolean, default: false, doc: \"Enable row selection\"
attr :sortable, :boolean, default: true, doc: \"Enable column sorting\"
attr :paginated, :boolean, default: false, doc: \"Enable pagination\"
attr :page_size, :integer, default: 20, doc: \"Rows per page when paginated\"
attr :class, :string, default: \"\", doc: \"Additional CSS classes\"
attr :rest, :global, doc: \"Additional HTML attributes\"

slot :action, doc: \"Action buttons for each row\"
slot :empty_state, doc: \"Content to show when no rows\"
slot :header, doc: \"Custom header content\"
slot :footer, doc: \"Custom footer content\"
```

## Behavior Specifications

### State Management
```elixir
# Internal state the component manages
defmodule TableState do
  defstruct [
    :sort_by,
    :sort_order,
    :selected_rows,
    :current_page,
    :filters
  ]
end
```

### Events
```elixir
# Events the component handles
handle_event(\"sort\", %{\"column\" => column}, socket)
handle_event(\"select_row\", %{\"id\" => id}, socket)
handle_event(\"select_all\", _, socket)
handle_event(\"paginate\", %{\"page\" => page}, socket)
handle_event(\"filter\", %{\"field\" => field, \"value\" => value}, socket)
```

### Interactions
- Click column header: Sort by that column
- Shift+click column: Multi-column sort
- Checkbox click: Select/deselect row
- Ctrl/Cmd+A: Select all visible rows
- Arrow keys: Navigate rows (when focused)

## Accessibility

### ARIA Attributes
```html
<table role=\"table\" aria-label={@label} aria-rowcount={length(@rows)}>
  <thead role=\"rowgroup\">
    <tr role=\"row\">
      <th role=\"columnheader\" aria-sort={sort_direction}>
        Column Name
      </th>
    </tr>
  </thead>
</table>
```

### Keyboard Navigation
- Tab: Move between interactive elements
- Space: Select row (when checkbox focused)
- Enter: Activate row action
- ↑/↓: Navigate between rows
- Home/End: Jump to first/last row

### Screen Reader Support
- Announce sort changes
- Announce selection count
- Provide row context
- Live region updates for dynamic content

## Styling (Pulsar Only)

### Default Theme
```elixir
@default_theme %{
  table: \"min-w-full divide-y divide-gray-200\",
  header: \"bg-gray-50\",
  header_cell: \"px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider\",
  body: \"bg-white divide-y divide-gray-200\",
  row: \"hover:bg-gray-50\",
  cell: \"px-6 py-4 whitespace-nowrap text-sm text-gray-900\"
}
```

### Theme Customization
```elixir
<.data_table theme={@custom_theme} />

# Or via theme provider
<.theme_provider theme={@app_theme}>
  <.data_table />
</.theme_provider>
```

### Responsive Design
- Mobile: Cards view
- Tablet: Horizontal scroll
- Desktop: Full table

## Implementation Examples

### Basic Usage (Stellar)
```elixir
<Stellar.data_table
  id=\"users\"
  rows={@users}
  columns={[
    %{key: :name, label: \"Name\"},
    %{key: :email, label: \"Email\"}
  ]}
/>
```

### Styled Usage (Pulsar)
```elixir
<Pulsar.data_table
  id=\"users\"
  rows={@users}
  columns={@columns}
  theme=\"compact\"
  striped={true}
/>
```

### With LiveView
```elixir
defmodule MyAppWeb.UsersLive do
  use MyAppWeb, :live_view
  import Stellar.Components.DataTable
  
  @impl true
  def handle_event(\"table-sort\", %{\"column\" => col}, socket) do
    users = sort_users(socket.assigns.users, col)
    {:noreply, assign(socket, users: users)}
  end
end
```

## Testing Strategy

### Unit Tests
```elixir
describe \"data_table component\" do
  test \"renders with minimum required props\" do
    assigns = %{
      id: \"test-table\",
      rows: [%{id: 1, name: \"Test\"}],
      columns: [%{key: :name, label: \"Name\"}]
    }
    
    html = render_component(&data_table/1, assigns)
    assert html =~ \"test-table\"
    assert html =~ \"Test\"
  end
  
  test \"handles sorting events\" do
    # Test implementation
  end
end
```

### Accessibility Tests
- [ ] ARIA attributes present
- [ ] Keyboard navigation works
- [ ] Screen reader announces correctly
- [ ] Color contrast passes WCAG AA
- [ ] Focus management works properly

### Integration Tests
- [ ] Works with Phoenix forms
- [ ] LiveView events handled
- [ ] Performance with large datasets
- [ ] Mobile responsiveness

## Performance Considerations

- Virtual scrolling for > 100 rows
- Debounce filter inputs
- Memoize sorted results
- Use phx-update=\"prepend\" for real-time updates
- Lazy loading for large datasets

## Dependencies

### Required
- Phoenix.Component >= 1.3
- Phoenix.LiveView >= 0.20

### Optional
- Flop (for advanced pagination)
- TailwindCSS (for Pulsar)
- Heroicons (for icons)

## Migration Guide

If replacing existing component:

```elixir
# Old
<.old_table data={@users} />

# New
<.data_table 
  rows={@users}
  columns={columns_from_schema(User)}
/>
```

## Related Components

- Stellar.Pagination - Standalone pagination
- Stellar.Filters - Advanced filtering
- Stellar.BulkActions - Bulk operations toolbar

## Examples & Demos

### Live Examples
- Basic table: `/storybook/components/data-table/basic`
- Advanced features: `/storybook/components/data-table/advanced`
- Real-time updates: `/storybook/components/data-table/live`

### CodeSandbox
[Link to interactive example]

## Open Questions

- [ ] Should selection state persist across pagination?
- [ ] How to handle very wide tables on mobile?
- [ ] Support for nested/expandable rows?

## Implementation Checklist

- [ ] Core component built
- [ ] Props validated
- [ ] Events handled
- [ ] Accessibility complete
- [ ] Tests written
- [ ] Documentation updated
- [ ] Storybook examples added
- [ ] Performance optimized
- [ ] Theme variations (Pulsar)
```

## Stack-Specific Considerations

### For Stellar (Headless)
- No style opinions, only behavior and structure
- Maximum flexibility for users to style
- Focus on accessibility primitives
- Slots for all customizable parts
- Minimal markup, semantic HTML
- Event handling without visual assumptions

### For Pulsar (Styled)
- Built on Stellar base components
- Consistent with design system
- Theme-able but opinionated defaults
- Production-ready styles with Tailwind
- Animation and transition considerations
- Dark mode support built-in

### Phoenix LiveView Patterns
- Proper event handling with `phx-` attributes
- State management through assigns
- Real-time updates via live socket
- Form integration with changesets
- Optimistic updates where appropriate

## Output Options

Ask user where to save:

### Option A: Project Document (Recommended for component libraries)
- Save within the component library project as a document
- Title: 'Spec: [ComponentName]'
- Benefits: Attached to project context, reference for library development
- Use Linear MCP to create within specific project

### Option B: Linear Issue (For specific component implementations)
- Create as trackable issue for component development
- Can be child of larger component system epic
- Benefits: Trackable progress, can have sub-issues for implementation tasks
- Include spec content in issue description

### Option C: Both
- Create project document for reference
- Create implementation issue linked to the spec document
- Best for comprehensive component development

## Final Instructions

1. **Understand component type** (Stellar vs Pulsar) and adapt template accordingly
2. **Research similar patterns** if user needs guidance on approach
3. **Focus on Phoenix LiveView integration** and real-time capabilities
4. **Emphasize accessibility** - make it a first-class consideration
5. **Consider performance** for components that handle large datasets
6. **Document testing strategy** with specific Phoenix/LiveView testing approaches
7. **Provide concrete examples** with realistic use cases
8. **Create actionable implementation checklist**
9. **Link to related components** in the ecosystem
10. **Ask about save preferences** and create documentation accordingly

**Key Principles**:
- Headless (Stellar) components focus on behavior and accessibility
- Styled (Pulsar) components provide production-ready design
- All components should integrate seamlessly with Phoenix LiveView
- Accessibility is non-negotiable
- Performance matters for data-heavy components
- Documentation should enable both users and implementers