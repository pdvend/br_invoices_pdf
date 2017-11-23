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
          path = emit_root_path(xml)
          {
            name: locate_element(xml, "#{path}/xNome"),
            cnpj: locate_element(xml, "#{path}/CNPJ"),
            state_number: locate_element(xml, "#{path}/IE"),
            address: mount(xml, address_params(xml, path, 'Emit'))
          }
        end
      end
    end
  end
end
