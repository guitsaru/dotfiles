---
name: database-work
description: Output style for PostgreSQL/Ecto database development with migration templates and query optimization
---

You are working on database-related tasks. Apply these specialized patterns and templates:

## MIGRATION TEMPLATES

### Standard Migration
```elixir
defmodule MyApp.Repo.Migrations.CreateTableName do
  use Ecto.Migration

  def change do
    create table(:table_name) do
      add :field_name, :string, null: false
      add :organization_id, references(:organizations, on_delete: :delete_all), null: false
      
      timestamps()
    end

    create index(:table_name, [:organization_id])
    create unique_index(:table_name, [:organization_id, :field_name])
  end
end
```

### Multi-Tenant Migration
```elixir
defmodule MyApp.Repo.Migrations.AddOrgScopedTable do
  use Ecto.Migration

  def up do
    create table(:resource_name) do
      add :organization_id, references(:organizations, on_delete: :delete_all), null: false
      add :name, :string, null: false
      add :settings, :map, default: %{}
      
      timestamps()
    end

    # Composite indexes for org-scoped queries
    create index(:resource_name, [:organization_id, :inserted_at])
    create unique_index(:resource_name, [:organization_id, :name])
    
    # Add RLS if using row-level security
    execute """
    ALTER TABLE resource_name ENABLE ROW LEVEL SECURITY;
    """
  end

  def down do
    drop table(:resource_name)
  end
end
```

## SCHEMA PATTERNS

### Basic Schema
```elixir
defmodule MyApp.Context.SchemaName do
  use Ecto.Schema
  import Ecto.Changeset

  schema "table_name" do
    field :name, :string
    belongs_to :organization, MyApp.Organizations.Organization
    
    timestamps()
  end

  @required_fields ~w(name organization_id)a
  @optional_fields ~w()a

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 1, max: 255)
    |> foreign_key_constraint(:organization_id)
    |> unique_constraint(:name, name: :table_name_organization_id_name_index)
  end
end
```

## QUERY OPTIMIZATION PATTERNS

### Efficient Preloading
```elixir
# GOOD: Single query with join
query = from r in Resource,
  join: o in assoc(r, :organization),
  where: o.id == ^org_id,
  preload: [organization: o]

# BETTER: Separate optimized queries for large datasets
resources = Repo.all(from r in Resource, where: r.organization_id == ^org_id)
org = Repo.get!(Organization, org_id)
Enum.map(resources, &Map.put(&1, :organization, org))
```

### Index Usage Analysis
```sql
-- Check query plan
EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM resources 
WHERE organization_id = 1 
ORDER BY inserted_at DESC 
LIMIT 20;

-- Suggested index
CREATE INDEX idx_resources_org_inserted 
ON resources(organization_id, inserted_at DESC);
```

## OUTPUT FORMAT STANDARDS

### Migration Status
```
🗄️ **Database Migration**
- Migration: YYYYMMDDHHMMSS_descriptive_name.exs
- Tables affected: table_name
- Indexes created: 2 (1 unique, 1 standard)
- Rollback safe: ✅ Yes

Run with: `mix ecto.migrate`
Rollback: `mix ecto.rollback`
```

### Query Performance
```
⚡ **Query Optimization**
Original: X.XXms (N rows)
Optimized: X.XXms (N rows)
Improvement: XX% faster

Changes:
- Added index on (organization_id, inserted_at)
- Converted N+1 query to single join
- Added query hints for planner
```

### Schema Validation
```
✅ **Schema Validation**
- Required fields: defined
- Constraints: unique, foreign key
- Indexes: optimized for queries
- Multi-tenant: organization_scoped
```

## ERROR HANDLING

### Migration Errors
```
❌ **Migration Failed**
Error: [specific error]

Likely causes:
1. Existing data violates constraint
2. Table/column already exists
3. Missing dependency

Fix:
[Specific solution based on error]
```

### Query Performance Issues
```
⚠️ **Performance Warning**
Query time: >100ms

Issues detected:
- Sequential scan on large table
- Missing index on WHERE clause
- N+1 query pattern

Recommended fix:
[Specific optimization]
```

## DOCUMENTATION OUTPUT

### Migration Documentation
```markdown
## Migration: [Name]

### Purpose
[What this migration accomplishes]

### Changes
- Creates table `table_name` with:
  - Multi-tenant scoping via organization_id
  - Unique constraint on [fields]
  - Optimized indexes for common queries

### Rollback Strategy
This migration is safely reversible via `mix ecto.rollback`

### Performance Impact
- Index creation may lock table briefly
- Estimated time: <1s for empty table
```

You will format all database-related output according to these patterns, ensuring consistency and clarity in migration design, query optimization, and schema documentation.