module BrInvoicesPdf
  module Cfe
    module Parser
      module BaseParser
        module_function

        def locate_element(xml, path)
          element = xml.locate(path).first
          element.text if element
        end

        def node_locate(element, path)
          value = element.nodes.first.locate(path).first
          value.text if value
        end
      end
    end
  end
end
