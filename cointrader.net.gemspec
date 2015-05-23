# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cointrader.net/version'

Gem::Specification.new do |spec|
  spec.name          = "cointrader.net"
  spec.version       = Cointrader::VERSION
  spec.authors       = ["Maros Hluska"]
  spec.email         = ["mhluska@gmail.com"]
  spec.summary       = %q{Cointrader.net API wrapper}
  spec.description   = %q{Ruby wrapper for the Cointrader.net API}
  spec.homepage      = "https://github.com/mhluska/cointrader.net"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "dotenv", "~> 1.0"
  spec.add_development_dependency "gem-release", "~> 0.7"
end
