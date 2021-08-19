# README

*travis-backup* is a cron application, which export builds and it's correspoonding jobs
to json files and sends them to GCE.

#### Ruby version

2.7.2

#### Configuration

`config/settinigs.yml` or env vars like:
`BACKUP_LIMIT`
`BACKUP_DELAY`
`BACKUP_HOUSEKEEPING_PERIOD`
`LOGS_URL`
`DATABASE_URL`
`GCE_PROJECT`
`GCE_CREDENTIALS`
`GCE_BUCKET`
`REDIS_URL`

#### How to run the test suite

`bundle exec rspec`

To make tests working properly you should also ensure the database connection string for an empty test database. You can set it as `DATABASE_URL` environment variable or in `config/database.yml`.

#### How to run appication

`bundle exec bin/run_backup`

It's also possibe to run console

`bundle exec bin/console`
and then run export for single user/organization
`Backup.new.export(owner_id)`