# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Company
        extend Util::XmlLocate

        module_function

        EMIT_ROOT_PATH = "#{Util::XmlLocate::ROOT_PATH}/emit"

        def execute(xml)
          {
            name: locate_element(xml, "#{EMIT_ROOT_PATH}/xNome"),
            cnpj: locate_element(xml, "#{EMIT_ROOT_PATH}/CNPJ"),
            state_number: locate_element(xml, "#{EMIT_ROOT_PATH}/IE"),
            address: company_address_params(xml)
          }
        end

        def company_address_params(xml)
          {
            streetname: locate_element(xml, "#{EMIT_ROOT_PATH}/enderEmit/xLgr"),
            number: locate_element(xml, "#{EMIT_ROOT_PATH}/enderEmit/nro"),
            district: locate_element(xml, "#{EMIT_ROOT_PATH}/enderEmit/xBairro"),
            city: locate_element(xml, "#{EMIT_ROOT_PATH}/enderEmit/xMun"),
            state: locate_element(xml, "#{EMIT_ROOT_PATH}/enderEmit/UF")
          }
        end
        private_class_method :company_address_params
      end
    end
  end
end
