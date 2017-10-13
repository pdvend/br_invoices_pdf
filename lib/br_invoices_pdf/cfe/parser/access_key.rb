module BrInvoicesPdf
  module Cfe
    module Parser
      module AccessKey
        extend Util::XmlLocate

        module_function

        def execute(xml)
          element = xml.locate('Signature/SignedInfo').first
          return unless element
          element = element.nodes.last
          return unless element
          element.attributes[:URI]
        end
      end
    end
  end
end
