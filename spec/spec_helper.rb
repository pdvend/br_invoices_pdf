$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'br_invoices_pdf'
require 'coveralls'
require 'simplecov'
Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])
SimpleCov.start
