module BrInvoicesPdf
  module Nfce
    module Parser
      module Company
        extend Util::XmlLocate

        module_function

        ROOT_PATH = Util::XmlLocate::ROOT_PATH

        def execute(xml)
          {
            name: locate_element(xml, "#{ROOT_PATH}/emit/xNome"),
            cnpj: locate_element(xml, "#{ROOT_PATH}/emit/CNPJ"),
            state_number: locate_element(xml, "#{ROOT_PATH}/emit/IE"),
            address: company_address_params(xml)
          }
        end

        def company_address_params(xml)
          {
            streetname: locate_element(xml, "#{ROOT_PATH}/emit/enderEmit/xLgr"),
            number: locate_element(xml, "#{ROOT_PATH}/emit/enderEmit/nro"),
            district: locate_element(xml, "#{ROOT_PATH}/emit/enderEmit/xBairro"),
            city: locate_element(xml, "#{ROOT_PATH}/emit/enderEmit/xMun"),
            state: locate_element(xml, "#{ROOT_PATH}/emit/enderEmit/UF")
          }
        end
        private_class_method :company_address_params
      end
    end
  end
end
