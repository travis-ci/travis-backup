# README

*travis-backup-for-v3* is an application that helps with housekeeping and backup for Travis CI database v3.0. By default it removes requests and builds with their dependencies, as long as they are older than given threshold says (and backups them in files, if this option is active). It can also be used to remove specified users, organizations or repositories with their dependencies.

### Installation and run

You can install the gem using

`gem install travis-backup-for-v3`

Next you can run it like:

```
travis_backup_for_v3 'postgres://user:pass@localhost:5432/my_db' --threshold 6
```

All arguments:

```
  first argument, no flag    # database url
  -b, --backup               # when not present, removes data without saving it to file
  -d, --dry_run              # only prints in console what data will be backuped and deleted
  -l, --limit LIMIT          # builds limit for one backup file
  -t, --threshold MONTHS     # number of months from now - data younger than this time won't be backuped
  -f, --files_location PATH  # path of the folder in which backup files will be placed
  -u, --user_id ID           # run only for given user
  -o, --org_id ID            # run only for given organization
  -r, --repo_id ID           # run only for given repository
```

Or inside your app:

```
require 'travis-backup'

backup = Backup.new(
  if_backup: true,
  limit: 500,
  threshold: 12,
  files_location: './my_folder/dump',
  database_url: 'postgresql://postgres:pass@localhost:5432/my_db'
)
backup.run
```

You can also run backup only for given user, organisation or repository:

```
backup.run(user_id: 1)
# or
backup.run(org_id: 1)
# or
backup.run(repo_id: 1)
```

#### Special modes

Using `--user_id`, `--org_id` or `--repo_id` flag without setting `--threshold` results in removing the specified user/organization/repository with all its dependencies. It can be combined with `--backup` flag in order to save removed data in files.

Using `--dry_run` flag you can check which data would be removed by gem, but without removing them actually. Instead of that reports will be printed on standard output. This flag can be also combined with special modes.

### Configuration options

Despite of command line arguments, one of the ways you can configure your export is a file `config/settings.yml` that you can place in your app's main directory. The gem expects properties in the following format:

```
backup:
  if_backup: true           # when false, removes data without saving it to file
  dry_run: false            # when true, only prints in console what data should be backuped and deleted
  limit: 1000               # builds limit for one backup file
  threshold: 6              # number of months from now - data younger than this time won't be backuped
  files_location: './dump'  # path of the folder in which backup files will be placed
  user_id: 1                # run only for given user
  org_id: 1                 # run only for given organization
  repo_id: 1                # run only for given repository
```

You can also set these properties using env vars corresponding to them: `IF_BACKUP`, `BACKUP_DRY_RUN`, `BACKUP_LIMIT`, `BACKUP_THRESHOLD`, `BACKUP_FILES_LOCATION`, `BACKUP_USER_ID`, `BACKUP_ORG_ID`, `BACKUP_REPO_ID`.

You should also specify your database url. You can do this the standard way in `config/database.yml` file, setting the `database_url` hash argument while creating `Backup` instance or using the `DATABASE_URL` env var. Your database should be consistent with the Travis 3.0 database schema.

### How to run the test suite

You can run the test after cloning this repository. Next you should call

```
bundle install
```

and

```
bundle exec rspec
```

To make tests working properly you should also ensure database connection string for empty test database. You can set it as `DATABASE_URL` environment variable or in `config/database.yml`.

**Warning: this database will be cleaned during tests, so ensure that it includes no important data.**

### Ruby version

2.7.2
