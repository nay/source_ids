# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'source_ids/version'

Gem::Specification.new do |spec|
  spec.name          = "source_ids"
  spec.version       = SourceIds::VERSION
  spec.authors       = ["nay3"]
  spec.email         = ["y.ohba@everyleaf.com"]
  spec.description   = "Add source_ids attribute to wrap the has_many :through association."
  spec.summary       = "Add source_ids attribute to wrap the has_many :through association."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
