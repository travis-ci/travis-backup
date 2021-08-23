# README

*travis-backup* is an application that removes builds and their corresponding jobs
and exports them (optionally) to json files.

### Installation and run

You can install the gem using

`gem install tci-backup`

Next you can run it in your app like

```
require 'tci-backup'

backup = Backup.new
backup.run

# or with configs:

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
backup = Backup.new
backup.run(user_id: 1)
# or
backup.run(org_id: 1)
# or
backup.run(repo_id: 1)
```

### Configuration

One of the ways you can configure your export is a file `config/settinigs.yml` that you should place in your app's main directory. The gem uses the properties in following format:

```
backup:
  if_backup: true           # when false, removes data without saving it to file
  limit: 1000               # builds limit for one backup file
  threshold: 6                  # number of months from now - data younger than this time won't be backuped
  files_location: './dump'  # path of the folder in which backup files will be placed
  user_id                   # run only for given user
  org_id                    # run only for given organization
  repo_id                   # run only for given repository
```

You can also set these properties as hash arguments while creating `Backup` instance or use env vars corresponding to them: `IF_BACKUP`, `BACKUP_LIMIT`, `BACKUP_DELAY`, `FILES_LOCATION`, `USER_ID`, `ORG_ID`, `REPO_ID`.

You should also specify your database url. You can do this the standard way in `config/database.yml` file, setting the `database_url` hash argument while creating `Backup` instance or using the `DATABASE_URL` env var. Your database should be consistent with the Travis 2.2 database schema.

### How to run the test suite

You can run the test after cloning this repository. Next you should call

```
bundle install
```

and

```
bundle exec rspec
```

To make tests working properly you should also ensure the database connection string for an empty test database. You can set it as `DATABASE_URL` environment variable or in `config/database.yml`.

**Warning: this database will be cleaned during tests, so ensure that it includes no important data.**

#### Using as standalone application

After cloning this repo you can also run it as a standalone app using

```
bundle exec bin/run_backup
```

You can also pass arguments:

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

  # example:

  bundle exec bin/run_backup 'postgres://user:pass@localhost:5432/my_db' -b
```

### Ruby version

2.7.2
