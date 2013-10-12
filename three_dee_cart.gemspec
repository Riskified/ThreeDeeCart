# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'three_dee_cart/version'

Gem::Specification.new do |spec|
  spec.name          = "three_dee_cart"
  spec.version       = ThreeDeeCart::VERSION
  spec.authors       = ["Elad Meidar"]
  spec.email         = ["elad@shinobidevs.com"]
  spec.description   = "An API Library for 3DCart e-commerce application"
  spec.summary       = ""
  spec.homepage      = "https://github.com/ShinobiDevs/ThreeDeeCart"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "fakeweb", ["~> 1.3"]
  spec.add_development_dependency 'simplecov'
  spec.add_dependency "savon", "2.0.0"
  #spec.add_dependency "activemodel", "~> 3.2.11"
end
