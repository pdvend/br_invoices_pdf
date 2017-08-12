module BrInvoicesPdf
  module Cfe
    module Parser
      module BaseParser
        module_function

        def locate_element(xml, path)
          element = xml.locate(path).first
          element.nil? ? nil : element.text
        end

        def node_locate(element, path)
          element.nodes.first.locate(path).first.text
        end
      end
    end
  end
end
