# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Company
        extend Util::XmlLocate
        extend Util::MountParams

        module_function

        EMIT_ROOT_PATH = "#{Util::XmlLocate::ROOT_PATH}/emit"

        def execute(xml)
          {
            name: locate_element(xml, "#{EMIT_ROOT_PATH}/xNome"),
            cnpj: locate_element(xml, "#{EMIT_ROOT_PATH}/CNPJ"),
            state_number: locate_element(xml, "#{EMIT_ROOT_PATH}/IE"),
            address: mount(xml, address_params(EMIT_ROOT_PATH, 'Emit'))
          }
        end
      end
    end
  end
end
