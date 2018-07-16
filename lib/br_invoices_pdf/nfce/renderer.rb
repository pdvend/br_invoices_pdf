# frozen_string_literal: true

require 'br_invoices_pdf/nfce/renderer/company_identification'
require 'br_invoices_pdf/nfce/renderer/customer_identification'
require 'br_invoices_pdf/nfce/renderer/header'
require 'br_invoices_pdf/nfce/renderer/product_table'
require 'br_invoices_pdf/nfce/renderer/totals'
require 'br_invoices_pdf/nfce/renderer/payment_forms'
require 'br_invoices_pdf/nfce/renderer/taxes_info'
require 'br_invoices_pdf/nfce/renderer/procon_info'
require 'br_invoices_pdf/nfce/renderer/fiscal_message'
require 'br_invoices_pdf/nfce/renderer/qr_code'

module BrInvoicesPdf
  module Nfce
    module Renderer
      extend Util::PdfRenderer

      module_function

      RENDERERS = [
        CompanyIdentification,
        Header,
        ProductTable,
        Totals,
        PaymentForms,
        TaxesInfo,
        ProconInfo,
        FiscalMessage,
        CustomerIdentification,
        QrCode
      ].freeze

      def pdf(data, options)
        generate_pdf(data, options, RENDERERS)
      end
    end
  end
end
