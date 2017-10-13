module BrInvoicesPdf
  module Cfe
    module Parser
      module Cnpj
        extend Util::XmlLocate

        module_function

        def execute(xml)
          locate_element(xml, 'infCFe/dest/CNPJ')
        end
      end
    end
  end
end
