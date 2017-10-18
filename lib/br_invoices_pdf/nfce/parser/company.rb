# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Company
        extend Util::XmlLocate
        extend Util::MountParams

        module_function

        EMIT_ROOT_PATH = "#{Util::XmlLocate::ROOT_PATH}/emit"
        ADDRESS_PARAMS = {
            streetname: "#{EMIT_ROOT_PATH}/enderEmit/xLgr",
            number: "#{EMIT_ROOT_PATH}/enderEmit/nro",
            district: "#{EMIT_ROOT_PATH}/enderEmit/xBairro",
            city: "#{EMIT_ROOT_PATH}/enderEmit/xMun",
            state: "#{EMIT_ROOT_PATH}/enderEmit/UF"
          }.freeze

        def execute(xml)
          {
            name: locate_element(xml, "#{EMIT_ROOT_PATH}/xNome"),
            cnpj: locate_element(xml, "#{EMIT_ROOT_PATH}/CNPJ"),
            state_number: locate_element(xml, "#{EMIT_ROOT_PATH}/IE"),
            address: mount(xml, ADDRESS_PARAMS)
          }
        end
      end
    end
  end
end
