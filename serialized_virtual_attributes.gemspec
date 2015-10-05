# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serialized_virtual_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "serialized_virtual_attributes"
  spec.version       = SerializedVirtualAttributes::VERSION
  spec.authors       = ["Sergey.Gnuskov"]
  spec.email         = ["sergey.gnuskov@flant.ru"]

  spec.summary       = %q{Ability to have several activerecord-like attributes in a single serialized column}
  spec.homepage      = "https://github.com/flant/serialized_virtual_attributes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 1.9'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"

  spec.add_runtime_dependency "activerecord", ">= 3.2"
end
