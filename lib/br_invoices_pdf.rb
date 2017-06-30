require 'ox'
require 'prawn'

require 'br_invoices_pdf/version'
require 'br_invoices_pdf/generator'

module BrInvoicesPdf
  @generators = {}

  module_function

  def generate(type, xml, options)
    generator = @generators[type]
    raise(Errors::InvalidDocumentType, type) unless generator
    generator.generate(xml, options)
  end

  def register(type, renderer, parser)
    @generators[type] = Generator.new(renderer, parser)
  end
end

require 'br_invoices_pdf/cfe'
