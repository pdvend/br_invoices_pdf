module BrInvoicesPdf
  class InvalidDocumentType < StandardError
    attr_reader :type

    def initialize(type)
      @type = type
    end
  end
end
