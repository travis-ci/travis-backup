namespace :backup do
  desc 'Backup all daily outdated build/job'
  task :cron do
    $: << 'lib'
    require 'tci-backup'

    Backup.new.run
  end
end

namespace :spec do
  desc 'Run all specs'
  task :all do
    sh 'bundle exec rspec spec'
  end
end

task :default => :'backup:cron'
