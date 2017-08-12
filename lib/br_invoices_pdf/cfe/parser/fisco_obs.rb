module BrInvoicesPdf
  module Cfe
    module Parser
      class FiscoObs
        include BaseParser

        def execute(xml)
          xml.locate('infCFe/infAdic/obsFisco').map do |element|
            {
              text: element.nodes.first.text,
              field: element.attributes[:xCampo]
            }
          end
        end
      end
    end
  end
end
