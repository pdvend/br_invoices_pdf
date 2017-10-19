# frozen_string_literal: true

module BrInvoicesPdf
  module Util
    module PdfRenderer
      extend Util::BaseRenderer

      module_function

      AUTO_HEIGHT_MOCK = 2000

      # :reek:FeatureEnvy
      def generate_pdf(data, options, renderers)
        page_width = Util::BaseRenderer.page_paper_width(options[:page_size])

        Prawn::Document.new(options.merge(page_size: [page_width, AUTO_HEIGHT_MOCK])) do |pdf|
          pdf_content(pdf, data, page_width: page_width, renderers: renderers)
        end
      end

      def pdf_content(pdf, data, options)
        pdf.font_size(7) do
          options[:renderers].each do |renderer|
            renderer.execute(pdf, data)
          end

          page = pdf.page
          page.dictionary.data[:MediaBox] = [0, pdf.y - page.margins[:bottom], options[:page_width], AUTO_HEIGHT_MOCK]
        end
      end
    end
  end
end
