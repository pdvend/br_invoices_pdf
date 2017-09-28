module BrInvoicesPdf
  module Cfe
    module Parser
      module Cnpj
        extend BaseParser

        module_function

        def execute(xml)
          locate_element(xml, 'infCFe/dest/CNPJ')
        end
      end
    end
  end
end
