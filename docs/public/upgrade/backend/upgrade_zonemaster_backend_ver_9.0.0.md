# Upgrade to 9.0.0

## Upgrading the database

If your Zonemaster database was created by a Zonemaster-Backend version smaller
than v9.0.0, and not upgraded, use the following instruction.

> You may need to run these command with root privileges.

### Preparation when using MariaDB

If you're using MariaDB you need to make a backup of your database before
upgrading its schema.

```sh
mysqldump zonemaster > backup-file.sql
```

In case the schema upgrade fails you may need to restore the backup before
trying again.

```sh
mysql zonemaster < backup-file.sql
```

### Upgrade database schema

```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
perl patch/patch_db_zonemaster_backend_ver_9.0.0.pl
```
