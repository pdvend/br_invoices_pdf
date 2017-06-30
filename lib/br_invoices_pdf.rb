require 'ox'
require 'prawn'

require 'br_invoices_pdf/version'
require 'br_invoices_pdf/generator'
require 'br_invoices_pdf/errors/invalid_document_type'

module BrInvoicesPdf
  @generators = {}

  module_function

  def generate(type, xml, options = {})
    generator = @generators[type]
    raise(Errors::InvalidDocumentType, type) unless generator
    generator.generate(xml, options)
  end

  def register(type, renderer, parser)
    unless type.is_a?(String) || type.is_a?(Symbol)
      raise(ArgumentError, "Expected Symbol or String to type. Received #{type.class}")
    end
    @generators[type.to_sym] = Generator.new(renderer, parser)
  end

  def supported_document_types
    @generators.keys
  end
end

require 'br_invoices_pdf/cfe'
