Gem::Specification.new do |s|
  s.name        = 'routed_exceptions'
  s.version     = '0.0.0'
  s.date        = '2014-10-20'
  s.summary     = 'routed exceptions'
  s.description = 'Silences action dispatch errors and allows to route them via route.rb'
  s.authors     = ['ulferts']
  s.files       = ['lib/routed_exceptions.rb']
  s.homepage    =
    'http://rubygems.org/gems/routed_exceptions'
  s.license       = 'MIT'

  s.add_dependency 'rack'
  s.add_dependency 'rails'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
end
