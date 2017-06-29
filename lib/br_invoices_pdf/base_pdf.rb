require 'prawn'

module BrInvoicesPdf
  class PdfDefault
    PDF_OPTIONS = { page_size: 'A4', margin: [40, 75] }.freeze

    def initialize(xml = nil, path = nil)
      @path = path
      @xml = xml
    end
  end
end
