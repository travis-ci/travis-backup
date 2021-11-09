# README

*travis-backup* is an application that helps with housekeeping and backup for Travis CI database v2.2 and with migration to v3.0 database. By default it removes requests and builds with their corresponding jobs and logs, as long as they are older than given threshold says (and backups them in files, if this option is active). Although it can be also run in special modes to perform other specific tasks.

### Installation and run

You can install the gem using

`gem install travis-backup`

Next you can run it like:

```
travis_backup 'postgres://user:pass@localhost:5432/my_db' --threshold 6
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
  --move_logs                # run in move logs mode - move all logs to database at destination_db_url URL
  --destination_db_url URL   # URL for moving logs to
  --remove_orphans           # run in remove orphans mode
  --orphans_table            # name of the table we will remove orphans from (if not defined, all tables are considered)
  --load_from_files          # loads files stored in files_location to the database
  --id_gap                   # concerns file loading - the gap between the biggest id in database and the lowest one that will be set to loaded data (that's for data inserted by other users during the load being performed; equals 1000 by default)
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

Using `--move_logs` flag you can move all logs to database at `destination_db_url` URL (which is required in this case). When you run gem in this mode no files are created and no other tables are being touched.

Using `--remove_orphans` flag you can remove all orphaned data from the tables. You can pick a specific table using `--orphans_table` flag or, by leaving it undefined, let all tables to be processed in the removing orphans procedure. When you run gem in this mode no files are created.

Using `--user_id`, `--org_id` or `--repo_id` flag without setting `--threshold` results in removing the specified user/organization/repository with all its dependencies. It can be combined with `--backup` flag in order to save removed data in files.

Using `--load_from_files` flag you can restore dumped data from files located at path given by `--files_location`. The distance defined by `--id_gap` is going to be kept between biggest ids in the database and the lowest ones from the data loaded from files (and it equals 1000 by default).

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
  move_logs: false          # run in move logs mode - move all logs to database at destination_db_url URL
  remove_orphans: false     # run in remove orphans mode
  orphans_table: 'builds'   # name of the table we will remove orphans from (if not defined, all tables are considered)
  load_from_files: false    # loads files stored in files_location to the database
  id_gap: 1500              # concerns file loading - the gap between the biggest id in database and the lowest one that will be set to loaded data (that's for data inserted by other users during the load being performed; equals 1000 by default)
```

You can also set these properties using env vars corresponding to them: `IF_BACKUP`, `BACKUP_DRY_RUN`, `BACKUP_LIMIT`, `BACKUP_THRESHOLD`, `BACKUP_FILES_LOCATION`, `BACKUP_USER_ID`, `BACKUP_ORG_ID`, `BACKUP_REPO_ID`, `BACKUP_MOVE_LOGS`, `BACKUP_REMOVE_ORPHANS`, `BACKUP_ORPHANS_TABLE`, `BACKUP_LOAD_FROM_FILES`, `BACKUP_ID_GAP`.

You should also specify your database url. You can do this the standard way in `config/database.yml` file, setting the `database_url` hash argument while creating `Backup` instance or using the `DATABASE_URL` env var. Your database should be consistent with the Travis 2.2 database schema.

For `move_logs` mode you need also to specify a destination database. You can set it also in `config/database.yml` file, in `destination` subsection, setting the `destination_db_url` hash argument while creating `Backup` instance or using the `BACKUP_DESTINATION_DB_URL` env var. Your destination database should be consistent with the Travis 3.0 database schema.

### How to run the test suite

You can run the test after cloning this repository. Next you should call

```
bundle install
```

and

```
bundle exec rspec
```

To make tests working properly you should also ensure database connection strings for empty test databases. You can set them as `DATABASE_URL` and `BACKUP_DESTINATION_DB_URL` environment variables or in `config/database.yml`.

**Warning: these databases will be cleaned during tests, so ensure that they include no important data.**

### Ruby version

2.7.2
