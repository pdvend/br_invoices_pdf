# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Customer
        extend Util::XmlLocate
        extend Util::MountParams

        module_function

        DEST_ROOT_PATH = "#{Util::XmlLocate::ROOT_PATH}/dest"

        def execute(xml)
          identification_type = identification_type_by(xml)
          {
            identification_type: identification_type,
            identification: locate_element(xml, "#{DEST_ROOT_PATH}/#{identification_type}"),
            address: mount(xml, address_params(DEST_ROOT_PATH, 'Dest'))
          }
        end

        def identification_type_by(xml)
          return 'CNPJ' if locate_element(xml, "#{DEST_ROOT_PATH}/CNPJ")
          return 'CPF' if locate_element(xml, "#{DEST_ROOT_PATH}/CPF")
          return 'idEstrangeiro' if locate_element(xml, "#{DEST_ROOT_PATH}/idEstrangeiro")
        end
        private_class_method :identification_type_by
      end
    end
  end
end
