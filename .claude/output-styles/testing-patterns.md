---
name: testing-patterns
description: Output style for comprehensive testing with ExUnit, property-based testing, and test architecture
---

You are working on testing tasks. Apply these specialized patterns and templates:

## EXUNIT TEST TEMPLATES

### Context Test Structure
```elixir
defmodule MyApp.ResourcesTest do
  use MyApp.DataCase, async: true

  alias MyApp.Resources
  alias MyApp.Resources.Resource

  describe "list_resources/1" do
    setup do
      org = organization_fixture()
      resource = resource_fixture(organization_id: org.id)
      {:ok, org: org, resource: resource}
    end

    test "returns all resources for organization", %{org: org, resource: resource} do
      assert [returned] = Resources.list_resources(org.id)
      assert returned.id == resource.id
    end

    test "returns empty list for different organization" do
      other_org = organization_fixture()
      assert [] = Resources.list_resources(other_org.id)
    end

    test "orders by inserted_at desc by default", %{org: org} do
      old = resource_fixture(organization_id: org.id, inserted_at: ~N[2020-01-01 00:00:00])
      new = resource_fixture(organization_id: org.id, inserted_at: ~N[2024-01-01 00:00:00])
      
      assert [first, second] = Resources.list_resources(org.id)
      assert first.id == new.id
      assert second.id == old.id
    end
  end
end
```

### LiveView Test
```elixir
defmodule MyAppWeb.ResourceLiveTest do
  use MyAppWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "Index" do
    setup [:register_and_log_in_user]

    test "lists all resources", %{conn: conn} do
      resource = resource_fixture()
      
      {:ok, _index_live, html} = live(conn, ~p"/resources")

      assert html =~ "Resources"
      assert html =~ resource.name
    end

    test "saves new resource", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/resources")

      assert index_live |> element("a", "New Resource") |> render_click() =~
        "New Resource"

      assert_patch(index_live, ~p"/resources/new")

      assert index_live
             |> form("#resource-form", resource: %{name: ""})
             |> render_change() =~ "can't be blank"

      assert index_live
             |> form("#resource-form", resource: %{name: "Test Resource"})
             |> render_submit()

      assert_patch(index_live, ~p"/resources")

      html = render(index_live)
      assert html =~ "Resource created successfully"
      assert html =~ "Test Resource"
    end

    test "updates resource in listing", %{conn: conn} do
      resource = resource_fixture()
      
      {:ok, index_live, _html} = live(conn, ~p"/resources")

      assert index_live |> element("#resources-#{resource.id} a", "Edit") |> render_click() =~
        "Edit Resource"

      assert_patch(index_live, ~p"/resources/#{resource}/edit")

      assert index_live
             |> form("#resource-form", resource: %{name: "Updated Name"})
             |> render_submit()

      assert_patch(index_live, ~p"/resources")

      html = render(index_live)
      assert html =~ "Resource updated successfully"
      assert html =~ "Updated Name"
    end
  end
end
```

## PROPERTY-BASED TESTING

### StreamData Properties
```elixir
defmodule MyApp.Resources.PropertyTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias MyApp.Resources.Resource

  property "changeset validates name length" do
    check all name <- string(:alphanumeric, min_length: 1, max_length: 255) do
      changeset = Resource.changeset(%Resource{}, %{name: name})
      assert changeset.valid?
    end
  end

  property "changeset rejects empty names" do
    check all name <- string(:alphanumeric, max_length: 0) do
      changeset = Resource.changeset(%Resource{}, %{name: name})
      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).name
    end
  end

  property "unique constraint prevents duplicates" do
    check all name <- string(:alphanumeric, min_length: 1, max_length: 100),
              max_runs: 50 do
      org = organization_fixture()
      
      {:ok, _first} = Resources.create_resource(%{
        name: name,
        organization_id: org.id
      })
      
      {:error, changeset} = Resources.create_resource(%{
        name: name,
        organization_id: org.id
      })
      
      assert "has already been taken" in errors_on(changeset).name
    end
  end
end
```

## TEST FIXTURES & FACTORIES

### Fixture Pattern
```elixir
defmodule MyApp.TestFixtures do
  alias MyApp.Repo
  
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        name: "Test Org #{System.unique_integer()}",
        slug: "test-org-#{System.unique_integer()}"
      })
      |> MyApp.Organizations.create_organization()
    
    organization
  end

  def resource_fixture(attrs \\ %{}) do
    org = Map.get(attrs, :organization) || organization_fixture()
    
    {:ok, resource} =
      attrs
      |> Enum.into(%{
        name: "Test Resource #{System.unique_integer()}",
        organization_id: org.id,
        status: :active
      })
      |> MyApp.Resources.create_resource()
    
    resource
  end
end
```

## INTEGRATION TESTS

### API Integration Test
```elixir
defmodule MyAppWeb.API.ResourceControllerTest do
  use MyAppWeb.ConnCase, async: true

  setup %{conn: conn} do
    user = user_fixture()
    token = generate_api_token(user)
    
    conn = 
      conn
      |> put_req_header("authorization", "Bearer #{token}")
      |> put_req_header("content-type", "application/json")
    
    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all resources for authorized user", %{conn: conn, user: user} do
      resource = resource_fixture(organization_id: user.organization_id)
      
      conn = get(conn, ~p"/api/resources")
      
      assert [returned] = json_response(conn, 200)["data"]
      assert returned["id"] == resource.id
    end

    test "returns 401 for unauthorized request" do
      conn = build_conn()
      conn = get(conn, ~p"/api/resources")
      
      assert json_response(conn, 401)["error"] == "Unauthorized"
    end
  end
end
```

## PERFORMANCE TESTS

### Benchmark Test
```elixir
defmodule MyApp.PerformanceTest do
  use ExUnit.Case, async: false

  @tag :benchmark
  test "list_resources performance" do
    org = organization_fixture()
    
    # Create test data
    for _ <- 1..1000 do
      resource_fixture(organization_id: org.id)
    end
    
    # Benchmark
    time = :timer.tc(fn ->
      Resources.list_resources(org.id)
    end) |> elem(0)
    
    # Assert performance threshold (microseconds)
    assert time < 100_000, "Query took #{time}μs, expected < 100ms"
  end
end
```

## OUTPUT FORMAT STANDARDS

### Test Creation
```
🧪 **Tests Created**
Module: MyApp.ResourcesTest
Coverage: 95% (19/20 lines)

Test Categories:
✅ Unit tests: 8 passing
✅ Integration tests: 4 passing  
✅ Property tests: 3 passing
✅ Performance tests: 1 passing

Run: `mix test test/my_app/resources_test.exs`
```

### Test Results
```
✅ **All Tests Passing**
Finished in 0.3 seconds
42 tests, 0 failures

Coverage: 92.5%
- Resources context: 100%
- ResourceLive: 89%
- Resource schema: 95%

Slowest test: 45ms (list_resources with 1000 items)
```

### Test Failure
```
❌ **Test Failure**
Test: test list_resources/1 returns all resources
File: test/my_app/resources_test.exs:25

Failure:
  Expected: [%Resource{id: 1}]
  Actual: []

Likely cause: Missing organization scope in query

Fix:
  where: [organization_id: ^org_id]
```

## TEST ORGANIZATION

### Test Structure
```
test/
├── my_app/                    # Business logic tests
│   ├── resources_test.exs
│   └── resources/
│       └── resource_test.exs
├── my_app_web/                # Web layer tests
│   ├── controllers/
│   └── live/
├── support/                    # Test helpers
│   ├── fixtures.ex
│   ├── conn_case.ex
│   └── data_case.ex
└── property/                   # Property-based tests
    └── resources_property_test.exs
```

### Test Tags
```elixir
# Skip in CI
@tag :skip_ci
test "requires external service" do
  # test code
end

# Benchmark tests
@tag :benchmark
test "performance critical operation" do
  # performance test
end

# Integration tests
@tag :integration
test "full stack test" do
  # integration test
end
```

## COVERAGE ANALYSIS

### Coverage Report
```
-----------
COV    FILE                                        LINES RELEVANT   MISSED
100.0% lib/my_app/resources.ex                       142      89        0
 95.5% lib/my_app/resources/resource.ex              44      22        1
 88.9% lib/my_app_web/live/resource_live/index.ex    72      36        4
-----------
 93.2% TOTAL                                         258     147       10
```

You will format all testing output according to these patterns, ensuring comprehensive test coverage with clear structure, property-based testing where appropriate, and detailed reporting of test results and coverage.