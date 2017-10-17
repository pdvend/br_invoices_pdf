# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require 'coveralls'

Coveralls.wear!
require 'br_invoices_pdf'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])

SimpleCov.start
