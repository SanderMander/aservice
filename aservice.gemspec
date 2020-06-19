# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'aservice'
  s.version     = '0.0.0'
  s.date        = '2020-06-17'
  s.summary     = 'Aservice'
  s.description = 'Gem for running services asynchroniously'
  s.authors     = ['Aleksandr Korotkikh']
  s.email       = 'koralvas@gmail.com'
  s.homepage    =
    'https://rubygems.org/gems/aservice'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.require_paths = ['lib']
  s.add_development_dependency 'bundler', '~> 2'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rake', '>= 12.3.3'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop'
  s.add_dependency 'anyway_config', '>= 2.0.0'
  s.add_dependency('sidekiq', ['>= 4.2.1'])
end