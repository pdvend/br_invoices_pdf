# frozen_string_literal: true

module BrInvoicesPdf
  module Util
    module XmlLocate
      module_function

      ROOT_PATH = 'NFe/infNFe'

      def locate_element(xml, path)
        element = xml.locate(path).first
        element.text if element.present?
      end

      def node_locate(element, path)
        value = element.nodes.first.locate(path).first
        value.text if value.present?
      end
    end
  end
end
