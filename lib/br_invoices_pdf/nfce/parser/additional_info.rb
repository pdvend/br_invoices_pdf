# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module AdditionalInfo
        extend Util::XmlLocate

        module_function

        def execute(xml)
          tribute = locate_element(xml, "#{root_path(xml)}/det/imposto/vTotTrib")
          tribute || 0
        end
      end
    end
  end
end
