module BrInvoicesPdf
  module Nfce
    module Parser
      module Company
        extend Util::XmlLocate

        module_function

        def execute(xml)
          {
            name: locate_element(xml, 'infNFe/emit/xNome'),
            cnpj: locate_element(xml, 'infNFe/emit/CNPJ'),
            state_number: locate_element(xml, 'infNFe/emit/IE'),
            address: company_address_params(xml)
          }
        end

        def company_address_params(xml)
          {
            streetname: locate_element(xml, 'infNFe/emit/enderEmit/xLgr'),
            number: locate_element(xml, 'infNFe/emit/enderEmit/nro'),
            district: locate_element(xml, 'infNFe/emit/enderEmit/xBairro'),
            city: locate_element(xml, 'infNFe/emit/enderEmit/xMun'),
            state: locate_element(xml, 'infNFe/emit/enderEmit/UF')
          }
        end
        private_class_method :company_address_params
      end
    end
  end
end
