# Upgrade to 11.1.0

## Upgrading the database

If your Zonemaster database was created by a Zonemaster-Backend version smaller
than v11.1.0, and not upgraded, use the following instruction.

> You may need to run these command with root privileges.

**Warning:** this database update will result in an increase of the used size.
Make sure you have enough free disk space before upgrading. Depending on the
database engine, you may need up to **5 times the database size of free space**.

### Upgrade database schema

```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
perl patch/patch_db_zonemaster_backend_ver_11.1.0.pl
```
