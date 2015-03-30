# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qflux/version'

Gem::Specification.new do |spec|
  spec.name          = "qflux"
  spec.version       = Qflux::VERSION
  spec.authors       = ["mkralla11"]
  spec.email         = ["Mike.MKrallaProductions@gmail.com"]
  spec.summary       = %q{Quick project scaffolding generator for React Flux JS applications.}
  spec.description   = %q{qflux}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug"
  spec.add_dependency 'activesupport', '4.2.0'
  spec.add_dependency 'thor'
end
