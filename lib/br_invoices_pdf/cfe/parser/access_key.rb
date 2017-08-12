module BrInvoicesPdf
  module Cfe
    module Parser
      class AccessKey
        include BaseParser

        def execute(xml)
          xml.locate('Signature/SignedInfo').first.nodes.last.attributes[:URI]
        end
      end
    end
  end
end
