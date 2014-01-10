# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'configurable_search/version'

Gem::Specification.new do |spec|
  spec.name          = "configurable_search"
  spec.version       = ConfigurableSearch::VERSION
  spec.authors       = ["Ismael Celis", "Iain Beeston"]
  spec.email         = ["ismael@new-bamboo.co.uk", "iain@new-bamboo.co.uk"]
  spec.summary       = %q{Configurable parameters for your elastic search queries}
  spec.description   = %q{Configurable parameters for your elastic search queries}
  spec.homepage      = "https://github.com/New-Bamboo/configurable_search"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.0.0"
  spec.add_dependency "activemodel", ">= 3.0.0"
  spec.add_dependency "tire", ">= 0.6.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.2.1"
end
