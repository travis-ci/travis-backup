Gem::Specification.new do |s|
  s.name                  = 'travis-backup'
  s.version               = '0.0.1'
  s.summary               = 'Travis CI backup tool'
  s.authors               = ['Karol Selak']
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  s.files                 = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.executables           = Dir.glob('bin/*').map { |f| File.basename(f) }
  s.require_paths         = ["lib"]
  s.license               = 'Beerware'

  s.add_dependency 'activerecord'
  s.add_dependency 'pg'
  s.add_dependency 'pry'
  s.add_dependency 'rails'

  s.add_dependency 'bootsnap'
  s.add_dependency 'tzinfo-data'

  s.add_development_dependency 'brakeman'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'listen'
  s.add_development_dependency 'rubocop', '~> 0.75.1'
  s.add_development_dependency 'rubocop-rspec'
end