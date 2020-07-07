# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'aservice'
  s.version     = '0.0.2'
  s.date        = '2020-07-07'
  s.summary     = 'Aservice'
  s.description = 'Gem for running services asynchroniously'
  s.authors     = ['Aleksandr Korotkikh']
  s.email       = 'koralvas@gmail.com'
  s.homepage    =
    'https://github.com/SanderMander/aservice'
  s.license       = 'MIT'
  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec|examples)/})
  end
  s.require_paths = ['lib']
  s.add_development_dependency 'bundler', '~> 2'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rake', '>= 12.3.3'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop'
  s.add_dependency 'anyway_config', '>= 2.0.0'
  s.add_dependency('sidekiq', ['>= 4.2.1'])
  s.add_dependency('sidekiq-status', ['>= 1.1.4'])
end
