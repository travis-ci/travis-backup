# README

*travis-backup* is a cron application, which export builds and it's correspoonding jobs
to json files.

* Ruby version

2.7.2

* System dependencies

* Configuration

`config/settinigs.yml` or env vars like:
`IF_BACKUP`
`BACKUP_LIMIT`
`BACKUP_DELAY`
`BACKUP_FILES_LOCATION`
`DATABASE_URL`

* How to run the test suite

`bundle exec rspec`

* How to run appication

`bundle exec bin/run_backup`

It's also possibe to run console

`bundle exec bin/console`
and then run export for single user/organization
`Backup.new.export(owner_id)`