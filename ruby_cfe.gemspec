# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_cfe/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_cfe'
  spec.version       = RubyCfe::VERSION
  spec.authors       = ['Thiago Ribeiro', 'Gabriel Teles']
  spec.email         = ['thiago@pdvend.com.br', 'gabriel@pdvend.com.br']

  spec.summary       = %q{CFe pdf generator}
  spec.homepage      = "https://github.com/pdvend/ruby_cfe"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
