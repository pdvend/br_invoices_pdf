module BrInvoicesPdf
  module Errors
    class InvalidDocumentType < StandardError
      attr_reader :type

      def initialize(type)
        super("`#{type.inspect}` is not supported. Must be one of #{BrInvoicesPdf.supported_document_types}")
        @type = type
      end
    end
  end
end
