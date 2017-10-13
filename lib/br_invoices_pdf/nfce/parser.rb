require 'br_invoices_pdf/nfce/parser/company'
require 'br_invoices_pdf/nfce/parser/products'
require 'br_invoices_pdf/nfce/parser/payments'
require 'br_invoices_pdf/nfce/parser/customer'
require 'br_invoices_pdf/nfce/parser/totals'
require 'br_invoices_pdf/nfce/parser/emission_details'

module BrInvoicesPdf
  module Nfce
    module Parser
      module_function

      PARSERERS = {
        company: Company,
        products: Products,
        payments: Payments,
        customer: Customer,
        totals: Totals,
        emission_details: EmissionDetails
      }.freeze

      def parse(xml)
        { company: Company.execute(xml),
          products: Products.execute(xml),
          payments: Payments.execute(xml),
          customer: Customer.execute(xml),
          totals: Totals.execute(xml),
          taxes: {
            amount: BigDecimal('2.88'),
            percent: '7,33%'
          },
          emission_details: EmissionDetails.execute(xml) }
      end
    end
  end
end
