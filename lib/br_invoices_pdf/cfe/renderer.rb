module BrInvoicesPdf
  module Cfe
    module Renderer
      module_function

      def pdf(data, options)
        Prawn::Document.new(options) do |pdf|
          ## constroi o pdf
          pdf.text data.to_s
        end
      end
    end
  end
end
