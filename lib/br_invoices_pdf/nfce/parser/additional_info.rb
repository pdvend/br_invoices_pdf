# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module AdditionalInfo
        extend Util::XmlLocate

        module_function

        def execute(xml)
          locate_element(xml, 'NFe/infAdic/infCpl')
        end
      end
    end
  end
end
