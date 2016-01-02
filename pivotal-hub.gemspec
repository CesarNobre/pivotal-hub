# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pivotal_hub/version'

Gem::Specification.new do |spec|
  spec.name          = "pivotal_hub"
  spec.version       = Pivotal_Hub::VERSION
  spec.authors       = ["César Nobre"]
  spec.email         = ["cesarnobrefilho@gmail.com"]
  spec.description   = %q{Integration Pivotal Tracker to Git}
  spec.summary       = %q{to do the main functions}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["pivotal-start"]  
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
