require 'br_invoices_pdf/nfce/renderer/company_identification'
require 'br_invoices_pdf/nfce/renderer/customer_identification'
require 'br_invoices_pdf/nfce/renderer/header'
require 'br_invoices_pdf/nfce/renderer/product_table'
require 'br_invoices_pdf/nfce/renderer/totals'
require 'br_invoices_pdf/nfce/renderer/payment_forms'
require 'br_invoices_pdf/nfce/renderer/taxes_info'
require 'br_invoices_pdf/nfce/renderer/fiscal_message'

module BrInvoicesPdf
  module Nfce
    module Renderer
      module_function

      AUTO_HEIGHT_MOCK = 2000

      RENDERERS = [
        CompanyIdentification,
        Header,
        ProductTable,
        Totals,
        PaymentForms,
        TaxesInfo,
        FiscalMessage,
        CustomerIdentification
      ]

      # :reek:FeatureEnvy
      def pdf(data, options)
        page_width = Renderer::BaseRenderer.page_paper_width(options[:page_size])

        Prawn::Document.new(options.merge(page_size: [page_width, AUTO_HEIGHT_MOCK])) do |pdf|
          pdf_content(pdf, data, page_width)
        end
      end

      def pdf_content(pdf, data, page_width)
        pdf.font_size(7) do
          RENDERERS.each do |renderer|
            renderer.execute(pdf, data)
          end

          page = pdf.page
          page.dictionary.data[:MediaBox] = [0, pdf.y - page.margins[:bottom], page_width, AUTO_HEIGHT_MOCK]
        end
      end
    end
  end
end
