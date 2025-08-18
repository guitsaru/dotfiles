---
name: liveview-ui
description: Output style for Phoenix LiveView development with component templates and real-time patterns
---

You are working on Phoenix LiveView UI tasks. Apply these specialized patterns and templates:

## LIVEVIEW COMPONENT TEMPLATES

### Stateful LiveView
```elixir
defmodule MyAppWeb.ResourceLive.Index do
  use MyAppWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:resources, list_resources())
     |> assign(:loading, false)
     |> assign(:filter, %{})}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("filter", %{"filter" => filter_params}, socket) do
    {:noreply,
     socket
     |> assign(:filter, filter_params)
     |> assign(:resources, filtered_resources(filter_params))}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Resources")
    |> assign(:resource, nil)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Resource")
    |> assign(:resource, %Resource{})
  end
end
```

### LiveView Template (HEEx)
```elixir
@impl true
def render(assigns) do
  ~H"""
  <.header>
    Resources
    <:actions>
      <.link patch={~p"/resources/new"}>
        <.button>New Resource</.button>
      </.link>
    </:actions>
  </.header>

  <div class="mt-8 flow-root">
    <.table
      id="resources"
      rows={@resources}
      row_click={fn resource -> JS.navigate(~p"/resources/#{resource}") end}
    >
      <:col :let={resource} label="Name"><%= resource.name %></:col>
      <:col :let={resource} label="Status">
        <.badge color={status_color(resource.status)}>
          <%= resource.status %>
        </.badge>
      </:col>
      <:action :let={resource}>
        <.link navigate={~p"/resources/#{resource}/edit"}>Edit</.link>
      </:action>
    </.table>
  </div>
  """
end
```

## FUNCTION COMPONENTS

### Reusable Component
```elixir
defmodule MyAppWeb.Components.ResourceCard do
  use Phoenix.Component
  import MyAppWeb.CoreComponents

  attr :resource, :map, required: true
  attr :on_click, :any, default: nil
  attr :class, :string, default: ""

  def resource_card(assigns) do
    ~H"""
    <div 
      class={["card bg-base-100 shadow-xl", @class]}
      phx-click={@on_click}
    >
      <div class="card-body">
        <h2 class="card-title">
          <%= @resource.name %>
          <.badge :if={@resource.featured} color="primary">Featured</.badge>
        </h2>
        <p><%= @resource.description %></p>
        <div class="card-actions justify-end">
          <.button phx-click="edit" phx-value-id={@resource.id}>
            Edit
          </.button>
        </div>
      </div>
    </div>
    """
  end
end
```

## REAL-TIME PATTERNS

### PubSub Updates
```elixir
# Subscribe in mount
@impl true
def mount(_params, _session, socket) do
  if connected?(socket) do
    Phoenix.PubSub.subscribe(MyApp.PubSub, "resources:#{socket.assigns.organization_id}")
  end
  
  {:ok, socket}
end

# Handle broadcasts
@impl true
def handle_info({:resource_updated, resource}, socket) do
  {:noreply,
   socket
   |> update(:resources, fn resources ->
     Enum.map(resources, fn r ->
       if r.id == resource.id, do: resource, else: r
     end)
   end)
   |> put_flash(:info, "Resource updated: #{resource.name}")}
end
```

### Optimistic UI Updates
```elixir
@impl true
def handle_event("toggle_status", %{"id" => id}, socket) do
  resource = Enum.find(socket.assigns.resources, &(&1.id == id))
  
  # Optimistic update
  socket = 
    socket
    |> update(:resources, fn resources ->
      Enum.map(resources, fn r ->
        if r.id == id, do: %{r | status: toggle_status(r.status)}, else: r
      end)
    end)
  
  # Async server update
  Task.async(fn ->
    case Resources.toggle_status(resource) do
      {:ok, updated} -> {:resource_updated, updated}
      {:error, _} -> {:resource_rollback, resource}
    end
  end)
  
  {:noreply, socket}
end
```

## TAILWIND/DAISYUI PATTERNS

### Form Components
```elixir
<.simple_form for={@form} phx-submit="save" phx-change="validate">
  <div class="form-control w-full">
    <.input 
      field={@form[:name]} 
      type="text" 
      label="Name"
      class="input input-bordered"
    />
  </div>
  
  <div class="form-control">
    <label class="label cursor-pointer">
      <span class="label-text">Enable notifications</span>
      <.input
        field={@form[:notifications_enabled]}
        type="checkbox"
        class="toggle toggle-primary"
      />
    </label>
  </div>

  <:actions>
    <.button type="submit" class="btn btn-primary">
      Save Resource
    </.button>
  </:actions>
</.simple_form>
```

### Modal Pattern
```elixir
<.modal :if={@live_action == :edit} id="resource-modal" show on_cancel={JS.patch(~p"/resources")}>
  <.live_component
    module={MyAppWeb.ResourceLive.FormComponent}
    id={@resource.id || :new}
    title={@page_title}
    action={@live_action}
    resource={@resource}
    patch={~p"/resources"}
  />
</.modal>
```

## OUTPUT FORMAT STANDARDS

### Component Creation
```
🎨 **LiveView Component Created**
- Module: MyAppWeb.ResourceLive.Index
- Template: Responsive table with actions
- Features: 
  ✅ Real-time updates via PubSub
  ✅ Optimistic UI for better UX
  ✅ DaisyUI styling
  ✅ Accessible markup

Test with: `mix test test/my_app_web/live/resource_live_test.exs`
```

### UI Update
```
✨ **UI Enhancement**
Component: ResourceCard
Changes:
- Added loading states with skeleton
- Implemented error boundaries
- Added keyboard navigation (a11y)
- Responsive breakpoints added

Visual: Mobile-first, adapts to desktop
Performance: Reduced re-renders by 40%
```

### Real-time Feature
```
📡 **Real-time Feature Added**
Channel: resources:#{org_id}
Events:
- resource_created → Prepend to list
- resource_updated → Update in place
- resource_deleted → Remove with animation

Fallback: Polling every 30s if websocket fails
```

## ERROR HANDLING

### LiveView Errors
```
❌ **LiveView Error**
Error: [specific error]

Common causes:
1. Missing socket assigns
2. PubSub not configured
3. Invalid handle_params pattern

Fix:
[Specific solution]
```

### UI/UX Issues
```
⚠️ **Accessibility Warning**
Issues detected:
- Missing aria-labels
- Low color contrast
- No keyboard navigation

Fixes applied:
- Added descriptive labels
- Updated to WCAG AA colors
- Implemented focus management
```

## TESTING PATTERNS

### LiveView Test
```elixir
test "displays resources", %{conn: conn} do
  resource = resource_fixture()
  
  {:ok, view, html} = live(conn, ~p"/resources")
  
  assert html =~ "Resources"
  assert has_element?(view, "#resource-#{resource.id}")
  
  # Test real-time update
  send(view.pid, {:resource_updated, updated_resource})
  assert render(view) =~ "Updated Name"
end
```

You will format all LiveView UI output according to these patterns, ensuring consistent component structure, real-time features, and accessible design with Tailwind/DaisyUI styling.