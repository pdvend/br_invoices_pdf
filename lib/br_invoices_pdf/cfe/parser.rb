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
        {}.tap do |response|
          PARSERERS.each do |param, parser|
            response[param] = parser.new.execute(xml)
          end
        end
      end
    end
  end
end
