# Upgrade to 11.2.0

## Upgrading the database

If your Zonemaster database was created by a Zonemaster-Backend version smaller
than v11.2.0, and not upgraded, use the following instructions.

> You may need to run these command with root privileges.

### Migration script

The following script fixes existing untranslated entries that were missed between 
Zonemaster-Backend v11.1.0 (release v2023.2) and this version (release v2024.1).
```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
perl patch/patch_db_zonemaster_backend_ver_11.2.0.pl
```
