# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Company
        extend Util::XmlLocate
        extend Util::MountParams

        module_function

        def emit_root_path(xml)
          "#{root_path(xml)}/emit"
        end

        def execute(xml)
          {
            name: locate_element(xml, "#{emit_root_path(xml)}/xNome"),
            cnpj: locate_element(xml, "#{emit_root_path(xml)}/CNPJ"),
            state_number: locate_element(xml, "#{emit_root_path(xml)}/IE"),
            address: mount(xml, address_params(xml, emit_root_path(xml), 'Emit'))
          }
        end
      end
    end
  end
end
