module BrInvoicesPdf
  class Generator
    PDF_OPTIONS = { page_size: 'A4', margin: [40, 75] }.freeze

    def initialize(renderer, parser)
      @renderer = renderer.new
      @parser = parser.new
    end

    def generate(xml, options)
      data = @parser.parse(xml)
      opts = PDF_OPTIONS.merge(options)
      @renderer.render(data, opts)
    end
  end
end
