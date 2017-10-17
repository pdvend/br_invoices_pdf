# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Parser
      module Payment
        extend Util::XmlLocate

        module_function

        def execute(xml)
          {
            approximate_value_of_taxes: locate_element(xml, 'infCFe/total/vCFeLei12741'),
            total: locate_element(xml, 'infCFe/total/vCFe'),
            discount: locate_element(xml, 'infCFe/total/ICMSTot/vDesc'),
            total_price: locate_element(xml, 'infCFe/total/ICMSTot/vProd'),
            cashback: locate_element(xml, 'infCFe/pgto/vTroco'),
            paid: locate_element(xml, 'infCFe/pgto/MP/vMP')
          }
        end
      end
    end
  end
end
