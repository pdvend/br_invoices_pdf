# frozen_string_literal: true

require 'br_invoices_pdf/cfe/renderer/company_identification'
require 'br_invoices_pdf/cfe/renderer/fisco_info'
require 'br_invoices_pdf/cfe/renderer/header'
require 'br_invoices_pdf/cfe/renderer/payment_forms'
require 'br_invoices_pdf/cfe/renderer/product_table'
require 'br_invoices_pdf/cfe/renderer/qr_code'
require 'br_invoices_pdf/cfe/renderer/taxes_info'
require 'br_invoices_pdf/cfe/renderer/totals'

module BrInvoicesPdf
  module Cfe
    module Renderer
      module_function

      extend Util::PdfRenderer

      RENDERERS = [
        CompanyIdentification,
        Header,
        ProductTable,
        Totals,
        PaymentForms,
        TaxesInfo,
        QrCode,
        FiscoInfo
      ].freeze

      def pdf(data, options)
        generate_pdf(data, options, RENDERERS)
      end
    end
  end
end
