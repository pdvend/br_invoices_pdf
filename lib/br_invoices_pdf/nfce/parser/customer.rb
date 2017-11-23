# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Customer
        extend Util::XmlLocate
        extend Util::MountParams

        module_function

        def dest_root_path(xml)
          "#{root_path(xml)}/dest"
        end

        def execute(xml)
          identification_type = identification_type_by(xml)
          root_path = dest_root_path(xml)

          {
            identification_type: identification_type,
            identification: locate_element(xml, "#{root_path}/#{identification_type}"),
            address: mount(xml, address_params(xml, root_path, 'Dest'))
          }
        end

        def identification_type_by(xml)
          root_path = dest_root_path(xml)

          return 'CNPJ' if locate_element(xml, "#{root_path}/CNPJ")
          return 'CPF' if locate_element(xml, "#{root_path}/CPF")
          return 'idEstrangeiro' if locate_element(xml, "#{root_path}/idEstrangeiro")
        end
        private_class_method :identification_type_by
      end
    end
  end
end
