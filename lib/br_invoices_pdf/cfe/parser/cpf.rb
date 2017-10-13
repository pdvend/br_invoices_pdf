module BrInvoicesPdf
  module Cfe
    module Parser
      module Cpf
        extend Util::XmlLocate

        module_function

        def execute(xml)
          locate_element(xml, 'infCFe/dest/CPF')
        end
      end
    end
  end
end
