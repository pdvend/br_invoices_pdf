module BrInvoicesPdf
  module Cfe
    module Parser
      class DocumentNumber
        include BaseParser

        def execute(xml)
          locate_element(xml, 'infCFe/ide/nCFe')
        end
      end
    end
  end
end
