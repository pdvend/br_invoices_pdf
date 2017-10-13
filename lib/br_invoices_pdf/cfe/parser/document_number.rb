module BrInvoicesPdf
  module Cfe
    module Parser
      module DocumentNumber
        extend Util::XmlLocate

        module_function

        def execute(xml)
          locate_element(xml, 'infCFe/ide/nCFe')
        end
      end
    end
  end
end
