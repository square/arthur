# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "arthur"
  spec.version       = "1.0.0"
  spec.authors       = ['Bella Norvig', 'Danny Spencer']
  spec.email         = %w(bella@squareup.com dspencer@squareup.com)
  spec.description   = 'Consumes the Bugsnag API.'
  spec.summary       = 'Consumes the Bugsnag API, for real!'
  spec.homepage      = "https://github.com/square/arthur"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('rest-client')

  spec.add_development_dependency('rake')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rspec', '>= 3.0')
  spec.add_development_dependency('webmock', '>= 1.18')
end
