# frozen_string_literal: true

module BrInvoicesPdf
  class Generator
    PDF_OPTIONS = { page_size: 'A4', margin: [40, 75] }.freeze

    def initialize(renderer, parser)
      @renderer = renderer
      @parser = parser
    end

    def generate(xml, options)
      parsed_xml = Ox.parse(xml)
      data = @parser.parse(parsed_xml)
      opts = PDF_OPTIONS.merge(options)
      @renderer.pdf(data, opts).render
    end
  end
end
