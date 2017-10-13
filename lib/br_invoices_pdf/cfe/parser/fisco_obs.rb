module BrInvoicesPdf
  module Cfe
    module Parser
      module FiscoObs
        extend Util::XmlLocate

        module_function

        def execute(xml)
          xml.locate('infCFe/infAdic/obsFisco').map do |element|
            node = element.nodes.first
            field = element.attributes[:xCampo]
            next unless node && field
            {
              text: node.text,
              field: field
            }
          end
        end
      end
    end
  end
end
