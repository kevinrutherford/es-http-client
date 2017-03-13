# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'es-http-client'
  spec.version       = '0.1.0'
  spec.licenses      = ['MIT']
  spec.authors       = ['Kevin Rutherford']
  spec.email         = ['kevin@rutherford-software.com']

  spec.summary       = %q{A simple HTTP client for EventStore}
  spec.description   = %q{A simple HTTP client for EventStore}
  spec.homepage      = "https://github.com/kevinrutherford/es-http-client"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec'

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'json'
  spec.add_dependency 'hashie'
  spec.add_dependency 'uuidtools'
end
