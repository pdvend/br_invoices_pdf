# frozen_string_literal: true

require 'br_invoices_pdf/nfce/parser/company'
require 'br_invoices_pdf/nfce/parser/products'
require 'br_invoices_pdf/nfce/parser/payments'
require 'br_invoices_pdf/nfce/parser/customer'
require 'br_invoices_pdf/nfce/parser/totals'
require 'br_invoices_pdf/nfce/parser/taxes'
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
        taxes: Taxes,
        emission_details: EmissionDetails
      }.freeze

      def parse(xml)
        PARSERERS.reduce({}) do |response, (param, parser)|
          { **response, param => parser.execute(xml) }
        end
      end
    end
  end
end
