require 'br_invoices_pdf/cfe/parser/base_parser'

Dir['lib/br_invoices_pdf/cfe/parser/*.rb'].each do |f|
  f.slice! 'lib/'
  require f
end

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
        cpf: Cpf
      }.freeze

      def parse(xml)
        PARSERERS.reduce({}) do |response, (param, parser)|
          { **response, param => parser.execute(xml) }
        end
      end
    end
  end
end
