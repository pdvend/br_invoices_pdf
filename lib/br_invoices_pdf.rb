require 'ox'
require 'prawn'

require 'br_invoices_pdf/version'
require 'br_invoices_pdf/generator'

module BrInvoicesPdf
  Generators = {}
  private_constant :Generators

  module_function

  def generate(type, xml, options)
    generator = Generators[type]
    raise Errors::InvalidDocumentType.new(type) unless generator
    generator.generate(xml, options)
  end

  def register(type, renderer, parser)
    Generators[type] = Generator.new(renderer, parser)
  end
end

require 'br_invoices_pdf/cfe'
