# Upgrade to 12.1.0

## Upgrading the database

If your Zonemaster database was created by a Zonemaster-Backend version lower
than v12.1.0, and not upgraded, use the following instructions.

> You may need to run these command with root privileges.

### Migration script

```sh
perl `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`/patch/patch_db_schema_version_1.pl
```
