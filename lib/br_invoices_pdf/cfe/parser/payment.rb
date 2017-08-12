module BrInvoicesPdf
  module Cfe
    module Parser
      class Payment
        include BaseParser

        def execute(xml)
          {
            approximate_value_of_taxex: locate_element(xml, 'infCFe/total/vCFeLei12741'),
            total: locate_element(xml, 'infCFe/total/vCFe'),
            discount: locate_element(xml, 'infCFe/total/ICMSTot/vDesc'),
            total_price: locate_element(xml, 'infCFe/total/ICMSTot/vProd'),
            cash_back: locate_element(xml, 'infCFe/pgto/vTroco'),
            payd: locate_element(xml, 'infCFe/pgto/MP/vMP')
          }
        end
      end
    end
  end
end
