# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Customer
        extend Util::XmlLocate
        extend Util::MountParams

        module_function

        DEST_ROOT_PATH = "#{Util::XmlLocate::ROOT_PATH}/dest"

        CUSTOMER_ADDRESS_PARAMS =  {
            streetname: "#{DEST_ROOT_PATH}/enderDest/xLgr",
            number: "#{DEST_ROOT_PATH}/enderDest/nro",
            district: "#{DEST_ROOT_PATH}/enderDest/xBairro",
            city: "#{DEST_ROOT_PATH}/enderDest/xMun",
            state: "#{DEST_ROOT_PATH}/enderDest/UF"
          }.freeze

        def execute(xml)
          identification_type = identification_type_by(xml)
          {
            identification_type: identification_type,
            identification: locate_element(xml, "#{DEST_ROOT_PATH}/#{identification_type}"),
            address: mount(xml, CUSTOMER_ADDRESS_PARAMS)
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
