module BrInvoicesPdf
  module Cfe
    module Renderer
      module_function

      AUTO_HEIGHT_MOCK = 2000

      RENDERERS = [
        CompanyIdentification,
        Header,
        ProductTable,
        Totals,
        PaymentForms,
        FiscoInfo,
        TaxesInfo,
        QrCode
      ].freeze

      def pdf(data, options)
        page_width = page_paper_width(options[:page_size])

        Prawn::Document.new(options.merge(page_size: [page_width, AUTO_HEIGHT_MOCK])) do |pdf|
          pdf_content(pdf, data, page_width)
        end
      end

      def pdf_content(pdf, data, page_width)
        pdf.font_size(7) do
          RENDERERS.each do |renderer|
            renderer.execute(pdf, data)
          end

          pdf.page.dictionary.data[:MediaBox] = [0, pdf.y - pdf.page.margins[:bottom], page_width, AUTO_HEIGHT_MOCK]
        end
      end

      def page_paper_width(name)
        (name.is_a?(Array) ? name : PDF::Core::PageGeometry::SIZES[name]).first
      end
    end
  end
end
