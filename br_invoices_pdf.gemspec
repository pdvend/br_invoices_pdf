# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'br_invoices_pdf/version'

Gem::Specification.new do |spec|
  spec.name          = 'br_invoices_pdf'
  spec.version       = BrInvoicesPdf::VERSION
  if ENV['SEMAPHORE'] && ENV['PRE_RELEASE']
    spec.version << ".alpha.#{ENV['SEMAPHORE_DEPLOY_NUMBER']}"
  end
  spec.authors       = ['Thiago Ribeiro', 'Gabriel Teles']
  spec.email         = ['thiago@pdvend.com.br', 'gabriel@pdvend.com.br']

  spec.summary       = 'Brazilian Fiscal Documents PDF generator'
  spec.homepage      = 'https://github.com/pdvend/br_invoices_pdf'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'prawn', '~> 2.2.2'
  spec.add_dependency 'ox', '~> 2.5.0'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.14'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'reek'
end
