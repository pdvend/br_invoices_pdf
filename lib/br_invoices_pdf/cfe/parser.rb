# frozen_string_literal: true

require 'br_invoices_pdf/cfe/parser/access_key'
require 'br_invoices_pdf/cfe/parser/company_attributes'
require 'br_invoices_pdf/cfe/parser/cpf'
require 'br_invoices_pdf/cfe/parser/cnpj'
require 'br_invoices_pdf/cfe/parser/document_number'
require 'br_invoices_pdf/cfe/parser/fisco_obs'
require 'br_invoices_pdf/cfe/parser/payment'
require 'br_invoices_pdf/cfe/parser/payments'
require 'br_invoices_pdf/cfe/parser/products_data'
require 'br_invoices_pdf/cfe/parser/sat'

module BrInvoicesPdf
  module Cfe
    module Parser
      module_function

      PARSERERS = {
        sat_params: Sat,
        document_number: DocumentNumber,
        payment: Payment,
        payments: Payments,
        products: ProductsData,
        company_attributes: CompanyAttributes,
        fisco_obs: FiscoObs,
        access_key: AccessKey,
        cpf: Cpf,
        cnpj: Cnpj
      }.freeze

      def parse(xml)
        PARSERERS.reduce({}) do |response, (param, parser)|
          { **response, param => parser.execute(xml) }
        end
      end
    end
  end
end
