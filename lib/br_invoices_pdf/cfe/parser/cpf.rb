module BrInvoicesPdf
  module Cfe
    module Parser
      class Cpf
        include BaseParser

        def execute(xml)
          locate_element(xml, 'infCFe/dest/CPF')
        end
      end
    end
  end
end
