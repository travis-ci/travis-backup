Gem::Specification.new do |s|
  s.name                  = 'travis-backup-for-v3'
  s.version               = '0.1.2'
  s.summary               = 'Travis CI backup tool'
  s.authors               = ['Karol Selak']
  s.required_ruby_version = Gem::Requirement.new('>= 3.2.0')
  s.files                 = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.executables << 'travis_backup_for_v3'
  s.require_path = 'lib'
  s.license = 'Beerware'

  s.add_dependency 'activerecord', '~> 7'
  s.add_dependency 'pg'
  s.add_dependency 'pry'
  s.add_dependency 'rails', '~> 7'

  s.add_dependency 'bootsnap'
  s.add_dependency 'tzinfo-data'

  s.add_development_dependency 'brakeman'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'database_cleaner-active_record'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'listen'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
end
