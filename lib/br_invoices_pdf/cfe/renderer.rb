module BrInvoicesPdf
  module Cfe
    class Renderer
      def render(data, options)
        pdf(data, options).render
      end

      private

      def pdf(data, options)
        Prawn::Document.new(options) do |pdf|
          ## constroi o pdf
          pdf.text data.to_s
        end
      end
    end
  end
end
