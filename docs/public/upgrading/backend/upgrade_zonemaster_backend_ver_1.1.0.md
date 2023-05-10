# Upgrade to 1.1.0

## Upgrading the database

If your Zonemaster database was created by a Zonemaster-Backend version smaller than
v1.1.0, and not upgraded, use the following instructions.

### MySQL

```sql
  ALTER TABLE test_results ADD queue INTEGER DEFAULT 0;
```

### PostgreSQL

```sql
  ALTER TABLE test_results ADD queue INTEGER DEFAULT 0;
```

