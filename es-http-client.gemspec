# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'es-http-client'
  spec.version       = '0.1.1'
  spec.licenses      = ['MIT']
  spec.authors       = ['Kevin Rutherford']
  spec.email         = ['kevin@rutherford-software.com']

  spec.summary       = %q{A simple HTTP client for EventStore}
  spec.description   = %q{A simple HTTP client for EventStore}
  spec.homepage      = "https://github.com/kevinrutherford/es-http-client"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '3.5.0'

  spec.add_dependency 'faraday', '0.11.0'
  spec.add_dependency 'faraday_middleware', '0.11.0.1'
  spec.add_dependency 'json', '2.0.3'
  spec.add_dependency 'hashie', '3.5.5'
  spec.add_dependency 'uuidtools', '2.1.5'
end

